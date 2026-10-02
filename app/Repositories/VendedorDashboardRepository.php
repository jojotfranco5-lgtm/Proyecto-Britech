<?php

namespace App\Repositories;

use App\Core\Database;

/**
 * Métricas para el dashboard del VENDEDOR. Solo lecturas agregadas (COUNT/SUM).
 * Todo se cuenta en CANTIDADES (no montos): cuántas ventas, cuántas compras,
 * cuántas cajas. El período ('semana' | 'mes' | 'ano') define el eje X.
 */
class VendedorDashboardRepository
{
    public const PERIODOS = ['semana', 'mes', 'ano'];
    private const CONSUMIDOR_FINAL = 1;   // cliente genérico del POS (no es un cliente "real")
    private const MESES = ['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic'];
    private const DIAS  = ['Dom','Lun','Mar','Mié','Jue','Vie','Sáb'];

    /**
     * Arma los "baldes" del período (clave => etiqueta), la expresión SQL que
     * produce la MISMA clave a partir de una columna fecha, y la fecha de inicio.
     * Misma lógica que DashboardRepository::serieVentas (admin).
     * @param string[] $campos  campos numéricos de cada balde (arrancan en 0)
     * @return array{0:array,1:callable,2:string}  [baldes, fn(columna) => expr SQL, desde]
     */
    private function baldes(string $periodo, array $campos): array
    {
        $ceros = array_fill_keys($campos, 0);
        $b = [];
        if ($periodo === 'ano') {
            for ($i = 11; $i >= 0; $i--) {
                $t = strtotime("first day of -$i month");
                $b[date('Y-m', $t)] = ['label' => self::MESES[(int) date('n', $t) - 1]] + $ceros;
            }
            $grp = fn (string $col) => "DATE_FORMAT($col,'%Y-%m')";
            $desde = date('Y-m-01', strtotime('first day of -11 month'));
        } elseif ($periodo === 'mes') {
            for ($i = 3; $i >= 0; $i--) {
                $t = strtotime("monday -$i week");
                $b[date('oW', $t)] = ['label' => 'Sem ' . date('d/m', $t)] + $ceros;
            }
            $grp = fn (string $col) => "DATE_FORMAT($col,'%x%v')";   // año-semana ISO (= date('oW'))
            $desde = date('Y-m-d', strtotime('monday -3 week'));
        } else { // semana
            for ($i = 6; $i >= 0; $i--) {
                $t = strtotime("-$i day");
                $b[date('Y-m-d', $t)] = ['label' => self::DIAS[(int) date('w', $t)] . ' ' . date('d', $t)] + $ceros;
            }
            $grp = fn (string $col) => "DATE($col)";
            $desde = date('Y-m-d', strtotime('-6 day'));
        }
        return [$b, $grp, $desde];
    }

    /** Corre una consulta agrupada (k, n) y SUMA cada n en el balde de su clave. */
    private function contarEn(array &$baldes, string $campo, string $sql, array $params): void
    {
        $st = Database::conexion()->prepare($sql);
        $st->execute($params);
        foreach ($st->fetchAll() as $r) {
            $k = (string) $r['k'];
            if (isset($baldes[$k])) { $baldes[$k][$campo] += (int) $r['n']; }
        }
    }

    /** Fecha de inicio del período (para los listados que no van por baldes). */
    public function desde(string $periodo): string
    {
        return $this->baldes($periodo, [])[2];
    }

    /**
     * Frecuencia de ventas (POS): cantidad de ventas del vendedor logueado vs.
     * el total del local, por balde. Solo ventas registradas (no anuladas).
     * @return array<int,array{label:string,mias:int,total:int}>
     */
    public function frecuenciaVentas(int $usuarioId, string $periodo): array
    {
        [$b, $grp, $desde] = $this->baldes($periodo, ['mias', 'total']);
        $g = $grp('creado_en');
        $this->contarEn($b, 'mias',
            "SELECT $g AS k, COUNT(*) AS n FROM venta
             WHERE estado = 'registrada' AND usuario_id = ? AND creado_en >= ? GROUP BY k", [$usuarioId, $desde]);
        $this->contarEn($b, 'total',
            "SELECT $g AS k, COUNT(*) AS n FROM venta
             WHERE estado = 'registrada' AND creado_en >= ? GROUP BY k", [$desde]);
        return array_values($b);
    }

    /**
     * Frecuencia de compras de los clientes: cuántas compras hicieron, separando
     * las del local (ventas POS) de las de la tienda online (pedidos no cancelados).
     * @return array<int,array{label:string,local:int,online:int}>
     */
    public function frecuenciaCompras(string $periodo): array
    {
        [$b, $grp, $desde] = $this->baldes($periodo, ['local', 'online']);
        $g = $grp('creado_en');
        $this->contarEn($b, 'local',
            "SELECT $g AS k, COUNT(*) AS n FROM venta
             WHERE estado = 'registrada' AND creado_en >= ? GROUP BY k", [$desde]);
        $this->contarEn($b, 'online',
            "SELECT $g AS k, COUNT(*) AS n FROM pedido
             WHERE estado <> 'cancelado' AND creado_en >= ? GROUP BY k", [$desde]);
        return array_values($b);
    }

    /**
     * Clientes que más compran en el período (local + online), sin contar al
     * "Consumidor Final" genérico del POS. Top 5, de mayor a menor.
     */
    public function clientesFrecuentes(string $periodo): array
    {
        $sql = "SELECT c.nombre AS cliente, COUNT(*) AS compras
                FROM (
                    SELECT cliente_id FROM venta
                     WHERE estado = 'registrada' AND creado_en >= ? AND cliente_id <> ?
                    UNION ALL
                    SELECT cliente_id FROM pedido
                     WHERE estado <> 'cancelado' AND creado_en >= ?
                ) x
                JOIN cliente c ON c.id = x.cliente_id
                GROUP BY x.cliente_id, c.nombre
                ORDER BY compras DESC, c.nombre
                LIMIT 5";
        $desde = $this->desde($periodo);
        $st = Database::conexion()->prepare($sql);
        $st->execute([$desde, self::CONSUMIDOR_FINAL, $desde]);
        return $st->fetchAll();
    }

    /**
     * Cajas abiertas vs cerradas.
     *  - abiertas: TODAS las que siguen abiertas ahora (sin importar cuándo se abrieron;
     *    una caja abierta de hace días es justamente algo a revisar).
     *  - cerradas: las que se cerraron dentro del período.
     * La serie reparte las abiertas por fecha de apertura y las cerradas por fecha de cierre.
     * @return array{abiertas:int,cerradas:int,serie:array}
     */
    public function cajas(string $periodo): array
    {
        [$b, $grp, $desde] = $this->baldes($periodo, ['abiertas', 'cerradas']);
        $this->contarEn($b, 'abiertas',
            "SELECT {$grp('abierta_en')} AS k, COUNT(*) AS n FROM caja
             WHERE estado = 'abierta' AND abierta_en >= ? GROUP BY k", [$desde]);
        $this->contarEn($b, 'cerradas',
            "SELECT {$grp('cerrada_en')} AS k, COUNT(*) AS n FROM caja
             WHERE estado = 'cerrada' AND cerrada_en >= ? GROUP BY k", [$desde]);

        $abiertas = (int) Database::conexion()->query("SELECT COUNT(*) FROM caja WHERE estado = 'abierta'")->fetchColumn();
        $st = Database::conexion()->prepare("SELECT COUNT(*) FROM caja WHERE estado = 'cerrada' AND cerrada_en >= ?");
        $st->execute([$desde]);

        return ['abiertas' => $abiertas, 'cerradas' => (int) $st->fetchColumn(), 'serie' => array_values($b)];
    }

    /**
     * Ranking: cantidad de ventas (POS, registradas) de cada vendedor en el período,
     * de MAYOR a MENOR. Incluye a los vendedores activos con 0 ventas (al final) y
     * a cualquier otro usuario que haya vendido (ej. el admin desde el POS).
     */
    public function rankingVendedores(string $periodo): array
    {
        $sql = "SELECT u.id, u.nombre AS vendedor, r.nombre AS rol, COUNT(v.id) AS ventas
                FROM usuario u
                JOIN rol r ON r.id = u.rol_id
                LEFT JOIN venta v ON v.usuario_id = u.id AND v.estado = 'registrada' AND v.creado_en >= ?
                WHERE u.activo = 1
                GROUP BY u.id, u.nombre, r.nombre
                HAVING r.nombre = 'vendedor' OR ventas > 0
                ORDER BY ventas DESC, u.nombre";
        $st = Database::conexion()->prepare($sql);
        $st->execute([$this->desde($periodo)]);
        return $st->fetchAll();
    }
}
