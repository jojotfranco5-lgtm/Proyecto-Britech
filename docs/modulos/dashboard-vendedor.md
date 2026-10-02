# Módulo: Dashboard del vendedor ("Mi panel")

> Estado: **construido** (2026-10-02). Rama: `DashboardVendedor`.
> Sin tablas nuevas: solo **lee** datos que ya existen (`venta`, `pedido`, `caja`, `usuario`, `cliente`).

## Problema
El vendedor entraba al panel y caía directo en *Pedidos*, sin ninguna vista de
cómo venía su trabajo. Necesita un tablero propio que le muestre, de un vistazo:
cuánto se vende, cuánto compran los clientes, cómo están las cajas y quién vende más.

---

## Parte 1 — Cómo se usa (explicación sencilla)

Al iniciar sesión como **vendedor**, el panel abre directamente en **Mi panel**.
(El admin también lo ve en el menú lateral, debajo de *Inicio*.)

Arriba a la derecha hay un selector **Semana / Mes / Año** que cambia el período
de **todos** los gráficos a la vez:

| Opción | Qué abarca | Cada barra es… |
|---|---|---|
| Semana | últimos 7 días | un día |
| Mes | últimas 4 semanas | una semana |
| Año | últimos 12 meses | un mes |

Todo se mide en **cantidades** (cuántas ventas, cuántas compras, cuántas cajas), no en pesos.
Arriba de cada barra está escrito el número, y en la leyenda aparece el total del período.

1. **📈 Frecuencia de ventas** — dos barras por día/semana/mes:
   - **Mis ventas**: las ventas que hice yo en el POS.
   - **Total del local**: todas las ventas del POS, de todos los vendedores.
   Sirve para ver la evolución y comparar mi ritmo con el del local.
   Solo cuenta ventas **registradas** (las anuladas no).

2. **🛒 Compras de los clientes** — cuántas compras hicieron los clientes:
   - **En el local**: compras en el mostrador (ventas del POS).
   - **Tienda online**: pedidos de la página (los cancelados no cuentan).
   Al costado, **⭐ Clientes que más compran**: los 5 clientes con más compras en el
   período (no cuenta al "Consumidor Final" genérico del POS).

3. **📦 Cajas abiertas y cerradas**
   - Dos tarjetas con los números grandes: **Abiertas ahora** (todas las cajas que todavía
     no se cerraron, sean de cuando sean) y **Cerradas** en el período.
   - Debajo, un gráfico que compara por día/semana/mes cuántas se abrieron y siguen
     abiertas vs. cuántas se cerraron.
   - Si "Abiertas ahora" muestra una caja de hace días, es una caja que alguien se olvidó de cerrar.

4. **🏆 Ventas por vendedor** — ranking de **mayor a menor** cantidad de ventas del período.
   Los 3 primeros llevan medalla 🥇🥈🥉, tu fila aparece resaltada con la etiqueta **vos**,
   y los vendedores sin ventas aparecen al final con 0.

---

## Parte 2 — Cómo está hecho (para el equipo)

Respeta la misma arquitectura del resto del proyecto:
`Router → Controller → Repository → PDO` en el back, y HTML + CSS + JS puro en el front
(gráficos hechos con `div`s y CSS, igual que el dashboard del admin — **sin librerías nuevas**).

### Archivos

| Capa | Archivo | Qué hace |
|---|---|---|
| Ruta | `routes/api.php` | `GET /api/vendedor/dashboard` (requiere login) |
| Controller | `app/Controllers/VendedorDashboardController.php` | Valida que sea staff y el período; arma la respuesta JSON |
| Repository | `app/Repositories/VendedorDashboardRepository.php` | Las consultas SQL (solo `COUNT`, lectura) |
| Vista | `public/admin.html` | Botón **Mi panel** en el menú + sección `#vista-vendedor` |
| Lógica front | `public/assets/js/admin-vendedor.js` | Pide los datos y dibuja los gráficos |
| Navegación | `public/assets/js/admin.js` | `seleccionar('vendedor')`; el vendedor aterriza ahí al entrar |
| Estilos | `public/assets/css/admin.css` | Bloque `Dashboard del vendedor` (reusa `.dash-panel`, `.barras`, `.hbar-*`, `.card`) |

### API

`GET /api/vendedor/dashboard?periodo=semana|mes|ano` (si el período no es válido, usa `semana`).

Acceso: **staff** (`Session::esStaff()` → vendedor o admin). Sin sesión → 401; cliente → 403.

```json
{
  "ok": true,
  "periodo": "semana",
  "yo": 2,
  "ventas":  [{ "label": "Lun 29", "mias": 3, "total": 8 }, ...],
  "compras": [{ "label": "Lun 29", "local": 8, "online": 4 }, ...],
  "clientes_frecuentes": [{ "cliente": "Juan Perez", "compras": 4 }, ...],
  "cajas": { "abiertas": 1, "cerradas": 5,
             "serie": [{ "label": "Lun 29", "abiertas": 0, "cerradas": 1 }, ...] },
  "ranking": [{ "id": 3, "vendedor": "Lucía", "rol": "vendedor", "ventas": 22 }, ...]
}
```

### Cómo se arman los gráficos por período ("baldes")
Se usa la misma técnica que `DashboardRepository::serieVentas` (dashboard admin):

1. En PHP se crean los **baldes** vacíos del período, cada uno con su clave y etiqueta
   (ej. `2026-09-29 → "Lun 29"`), así aparecen también los días **sin** movimiento (en 0).
2. En SQL se agrupa con una expresión que produce **la misma clave**
   (`DATE(col)`, `DATE_FORMAT(col,'%x%v')` para semana ISO, `DATE_FORMAT(col,'%Y-%m')` para mes).
3. Se cuenta (`COUNT(*)`) y cada resultado se suma en su balde (`contarEn`).

### Reglas de cada consulta
- **Ventas**: tabla `venta`, `estado = 'registrada'`. "Mis ventas" filtra por `usuario_id` de la sesión.
- **Compras de clientes**: `venta` registradas (local) + `pedido` con `estado <> 'cancelado'` (online).
- **Clientes frecuentes**: `UNION ALL` de ambas fuentes, excluye `cliente_id = 1` (Consumidor Final), top 5.
- **Cajas**: abiertas = `estado = 'abierta'` (todas); cerradas = `estado = 'cerrada'` con `cerrada_en` en el período.
- **Ranking**: `usuario` `LEFT JOIN venta` del período → incluye vendedores activos con 0 ventas;
  `ORDER BY ventas DESC` (mayor a menor), desempate por nombre.

### Seguridad
- Todas las consultas usan **sentencias preparadas** (`?`); el período se valida contra una lista fija.
- El ranking expone solo **cantidad** de ventas por vendedor (no montos).
- El front escapa todo texto con `esc()` antes de insertarlo en el HTML.

### Cómo probarlo
1. Levantar el proyecto (ver `README.md`) e iniciar sesión con un usuario **vendedor**.
2. Debe abrir en **Mi panel**. Hacer una venta en el POS → recargar: sube "Mis ventas" y el ranking.
3. Abrir/cerrar una caja desde el POS → cambian las tarjetas de cajas.
4. Probar el selector Semana / Mes / Año.
5. Directo por API: `GET /api/vendedor/dashboard?periodo=mes` con la sesión iniciada.
