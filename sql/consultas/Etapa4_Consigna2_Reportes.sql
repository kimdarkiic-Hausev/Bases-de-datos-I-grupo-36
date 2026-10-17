--------------------------------------------------------------------------------
-- ETAPA IV - CONSIGNA 2: REPORTES AGREGADOS
-- OBJETIVO: Consolidar el total de ventas (monto y/o unidades) en un rango de 
-- fechas utilizando GROUP BY, SUM, COUNT y AVG.
--------------------------------------------------------------------------------

USE FrigorificoDB;
GO

-- 2.1: Reporte Agregado por VENDEDOR
-- Muestra la cantidad de ventas realizadas, monto total y ticket promedio por cada vendedor.
SELECT
    ve.id_vendedor,
    CONCAT(ve.nombre_vendedor, ' ', ve.apellido_vendedor) AS vendedor,
    COUNT(v.id_venta) AS cantidad_ventas_realizadas,
    SUM(v.total) AS total_monto_vendido,
    AVG(v.total) AS ticket_promedio
FROM VENDEDOR ve
INNER JOIN VENTA v ON ve.id_vendedor = v.id_vendedor
WHERE v.fecha_hora >= '2026-09-01 00:00:00'
  AND v.fecha_hora <= '2026-09-30 23:59:59'
GROUP BY ve.id_vendedor, ve.nombre_vendedor, ve.apellido_vendedor
ORDER BY total_monto_vendido DESC;
GO


-- 2.2: Reporte Agregado por CATEGORÍA DE PRODUCTO
-- Muestra el total de unidades/kilos vendidos y el monto facturado por cada categoría cárnica.
SELECT
    cat.id_categoria,
    cat.nombre_categoria AS categoria,
    COUNT(DISTINCT v.id_venta) AS total_transacciones,
    SUM(dv.cantidad) AS total_unidades_kilos_vendidos,
    SUM(dv.cantidad * dv.precio_unitario) AS monto_total_recaudado
FROM CATEGORIA cat
INNER JOIN PRODUCTO p ON cat.id_categoria = p.id_categoria
INNER JOIN DETALLE_VENTA dv ON p.id_producto = dv.id_producto
INNER JOIN VENTA v ON dv.id_venta = v.id_venta
WHERE v.fecha_hora >= '2026-09-01 00:00:00'
  AND v.fecha_hora <= '2026-09-30 23:59:59'
GROUP BY cat.id_categoria, cat.nombre_categoria
ORDER BY monto_total_recaudado DESC;
GO


-- 2.3: Reporte Agregado por FORMA DE PAGO
-- Muestra el total recaudado y la cantidad de operaciones agrupadas por método de pago.
SELECT
    fp.id_forma_pago,
    fp.descripcion AS forma_pago,
    COUNT(v.id_venta) AS cantidad_operaciones,
    SUM(v.total) AS total_recaudado
FROM FORMA_PAGO fp
INNER JOIN VENTA v ON fp.id_forma_pago = v.id_forma_pago
WHERE v.fecha_hora >= '2026-09-01 00:00:00'
  AND v.fecha_hora <= '2026-09-30 23:59:59'
GROUP BY fp.id_forma_pago, fp.descripcion
ORDER BY total_recaudado DESC;
GO


-- 2.4: Reporte Agregado por PRODUCTO (Ranking de Ventas)
-- Muestra el volumen total vendido y la facturación de cada producto individual.
SELECT
    p.id_producto,
    p.nombre_producto AS producto,
    p.unidad_medida,
    SUM(dv.cantidad) AS total_volumen_vendido,
    SUM(dv.cantidad * dv.precio_unitario) AS total_facturado
FROM PRODUCTO p
INNER JOIN DETALLE_VENTA dv ON p.id_producto = dv.id_producto
INNER JOIN VENTA v ON dv.id_venta = v.id_venta
WHERE v.fecha_hora >= '2026-09-01 00:00:00'
  AND v.fecha_hora <= '2026-09-30 23:59:59'
GROUP BY p.id_producto, p.nombre_producto, p.unidad_medida
ORDER BY total_volumen_vendido DESC;
GO