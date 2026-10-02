<?php

namespace App\Controllers;

use App\Core\Request;
use App\Core\Response;
use App\Core\Session;
use App\Repositories\VendedorDashboardRepository;

/** Dashboard del vendedor (staff: vendedor o admin). Métricas en cantidades. */
class VendedorDashboardController
{
    /** GET /api/vendedor/dashboard?periodo=semana|mes|ano */
    public function resumen(): void
    {
        if (!Session::esStaff()) { Response::json(['ok' => false, 'error' => 'Solo staff.'], 403); return; }

        $periodo = Request::query('periodo', 'semana');
        if (!in_array($periodo, VendedorDashboardRepository::PERIODOS, true)) { $periodo = 'semana'; }

        $r = new VendedorDashboardRepository();
        Response::json([
            'ok'                  => true,
            'periodo'             => $periodo,
            'yo'                  => (int) Session::usuarioId(),
            'ventas'              => $r->frecuenciaVentas((int) Session::usuarioId(), $periodo),
            'compras'             => $r->frecuenciaCompras($periodo),
            'clientes_frecuentes' => $r->clientesFrecuentes($periodo),
            'cajas'               => $r->cajas($periodo),
            'ranking'             => $r->rankingVendedores($periodo),
        ]);
    }
}
