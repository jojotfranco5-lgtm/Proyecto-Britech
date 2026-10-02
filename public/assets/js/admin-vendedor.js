/* ============================================================
 * Dashboard del vendedor ("Mi panel").
 * Frecuencia de ventas, frecuencia de compras de los clientes,
 * cajas abiertas vs cerradas y ranking de ventas por vendedor.
 * Todo en CANTIDADES. Un solo selector de período (Semana/Mes/Año)
 * aplica a todos los gráficos.
 * Reusa los globals de admin.js ($, api, esc, kpi).
 * ========================================================== */

let vendPeriodo = 'semana';
const VEND_TXT_PERIODO = { semana: 'últimos 7 días', mes: 'últimas 4 semanas', ano: 'últimos 12 meses' };

// Barras agrupadas (2 series) con la CANTIDAD escrita arriba de cada barra.
// series: [{ campo, cls, nombre }] — cls reusa los colores del dashboard admin.
function vendBarras(serie, series) {
    const max = Math.max(1, ...serie.flatMap((x) => series.map((s) => Number(x[s.campo]))));
    return `<div class="barras grupos vend-barras">${serie.map((x) => `<div class="barra-col">
        <div class="barra-par">${series.map((s) => {
            const n = Number(x[s.campo]);
            const h = n > 0 ? Math.max(Math.round(n / max * 100), 2) : 0;
            return `<div class="barra ${s.cls}" style="height:${h}%" ${n > 0 ? `data-n="${n}"` : ''} title="${esc(s.nombre)}: ${n}"></div>`;
        }).join('')}</div>
        <span>${esc(x.label)}</span></div>`).join('')}</div>`;
}

// Leyenda con el TOTAL del período de cada serie.
function vendLeyenda(serie, series) {
    return `<div class="chart-legend">${series.map((s) => {
        const total = serie.reduce((acc, x) => acc + Number(x[s.campo]), 0);
        return `<span class="lg"><i class="sw ${s.cls}"></i>${esc(s.nombre)} · <b>${total}</b></span>`;
    }).join('')}</div>`;
}

function vendPanelSerie(id, titulo, serie, series) {
    $(id).innerHTML = `<div class="chart-head"><h3>${esc(titulo)} · ${VEND_TXT_PERIODO[vendPeriodo]}</h3></div>
        ${vendLeyenda(serie, series)}
        ${vendBarras(serie, series)}`;
}

async function renderVendedor() {
    document.querySelectorAll('#vend-periodo button').forEach((b) => b.classList.toggle('activo', b.dataset.p === vendPeriodo));
    let d;
    try { d = await api.get('/api/vendedor/dashboard?periodo=' + vendPeriodo); }
    catch { $('vend-ventas').innerHTML = '<p class="tabla-vacia">No se pudo cargar el panel.</p>'; return; }

    // --- 📈 Frecuencia de ventas: mis ventas vs total del local ---
    vendPanelSerie('vend-ventas', '📈 Frecuencia de ventas', d.ventas, [
        { campo: 'mias',  cls: 'fisica', nombre: 'Mis ventas' },
        { campo: 'total', cls: 'online', nombre: 'Total del local' },
    ]);

    // --- 🛒 Frecuencia de compras de los clientes: local vs online ---
    vendPanelSerie('vend-compras', '🛒 Compras de los clientes', d.compras, [
        { campo: 'local',  cls: 'fisica', nombre: 'En el local' },
        { campo: 'online', cls: 'online', nombre: 'Tienda online' },
    ]);

    // --- 📦 Cajas abiertas vs cerradas ---
    const cj = d.cajas || { abiertas: 0, cerradas: 0, serie: [] };
    $('vend-cajas').innerHTML = `<h3>📦 Cajas abiertas y cerradas</h3>
        <div class="cards vend-cajas-kpis">
            ${kpi('Abiertas ahora', cj.abiertas, cj.abiertas > 0 ? 'sin cerrar todavía' : 'ninguna abierta')}
            ${kpi('Cerradas', cj.cerradas, VEND_TXT_PERIODO[vendPeriodo])}
        </div>
        ${vendLeyenda(cj.serie, [
            { campo: 'abiertas', cls: 'online', nombre: 'Abiertas' },
            { campo: 'cerradas', cls: 'fisica', nombre: 'Cerradas' },
        ])}
        ${vendBarras(cj.serie, [
            { campo: 'abiertas', cls: 'online', nombre: 'Abiertas' },
            { campo: 'cerradas', cls: 'fisica', nombre: 'Cerradas' },
        ])}`;

    // --- 🏆 Ranking: ventas por vendedor (ya viene ordenado de mayor a menor) ---
    const rk = d.ranking || [];
    const maxRk = Math.max(1, ...rk.map((v) => Number(v.ventas)));
    const medalla = ['🥇', '🥈', '🥉'];
    $('vend-ranking').innerHTML = `<h3>🏆 Ventas por vendedor · ${VEND_TXT_PERIODO[vendPeriodo]}</h3>` + (rk.length === 0
        ? `<p class="dash-vacio">Todavía no hay vendedores cargados.</p>`
        : `<ol class="vend-ranking">${rk.map((v, i) => {
            const n = Number(v.ventas);
            const yo = Number(v.id) === Number(d.yo);
            return `<li class="${yo ? 'yo' : ''}">
                <span class="vend-pos">${n > 0 && i < 3 ? medalla[i] : (i + 1)}</span>
                <span class="hbar-label" title="${esc(v.vendedor)}">${esc(v.vendedor)}${yo ? ' <span class="chip">vos</span>' : ''}</span>
                <div class="hbar-track"><div class="hbar-fill" style="width:${n > 0 ? Math.max(3, Math.round(n / maxRk * 100)) : 0}%"></div></div>
                <span class="hbar-val">${n}</span></li>`;
        }).join('')}</ol>`);

    // --- Clientes que más compran (complementa la frecuencia de compras) ---
    const cf = d.clientes_frecuentes || [];
    $('vend-clientes').innerHTML = `<h3>⭐ Clientes que más compran</h3>` + (cf.length === 0
        ? `<p class="dash-vacio">Sin compras de clientes identificados en el período.</p>`
        : `<ul class="dash-lista">${cf.map((c) =>
            `<li><span>${esc(c.cliente)}</span><span class="dash-num">${Number(c.compras)} compra(s)</span></li>`).join('')}</ul>`);
}

// Selector de período (estático en admin.html): recarga todo el panel.
document.querySelectorAll('#vend-periodo button').forEach((b) => b.addEventListener('click', () => {
    if (b.dataset.p === vendPeriodo) return;
    vendPeriodo = b.dataset.p;
    renderVendedor();
}));
