-- Selecciona la base de datos donde se ejecutara la consulta
USE FrigorificoDB;
GO

-- Declara una variable para indicar que venta se desea consultar
-- Se puede cambiar el valor para consultar otra factura
DECLARE @id_venta INT = 1;

-- Selecciona los datos del encabezado y del detalle de la factura
SELECT
    -- Obtiene el numero de factura y la fecha de la venta
    V.id_venta AS Numero_Factura,
    V.fecha_hora AS Fecha,

    -- Obtiene los datos identificatorios del cliente
    C.id_cliente,
    C.nombre_cliente,
    C.apellido_cliente,
    C.razon_social,
    C.dni_cliente,
    C.cuit_cliente,

    -- Obtiene el nombre y apellido del vendedor que realizo la venta
    VE.nombre_vendedor,
    VE.apellido_vendedor,

    -- Obtiene la forma de pago utilizada en la venta
    FP.descripcion AS Forma_Pago,

    -- Obtiene los datos del producto vendido
    P.id_producto,
    P.nombre_producto AS Producto,
    P.unidad_medida AS Unidad,

    -- Muestra la cantidad vendida y el precio por unidad
    DV.cantidad,
    DV.precio_unitario,

    -- Muestra el subtotal de cada renglon
    -- El subtotal se calcula multiplicando cantidad por precio unitario
    DV.subtotal AS Subtotal_Renglon,

    -- Suma los subtotales de todos los productos de la misma venta
    -- El total se repite en cada renglon de la factura
    SUM(DV.subtotal) OVER (
        PARTITION BY V.id_venta
    ) AS Total_Calculado,

    -- Muestra el total que fue registrado en la tabla VENTA
    -- Permite compararlo con el total calculado a partir del detalle
    V.total AS Total_Registrado

-- Indica que la consulta comienza en la tabla principal de ventas
FROM VENTA V

-- Relaciona cada venta con el cliente correspondiente
INNER JOIN CLIENTE C
    ON V.id_cliente = C.id_cliente

-- Relaciona cada venta con el vendedor correspondiente
INNER JOIN VENDEDOR VE
    ON V.id_vendedor = VE.id_vendedor

-- Relaciona cada venta con su forma de pago
INNER JOIN FORMA_PAGO FP
    ON V.id_forma_pago = FP.id_forma_pago

-- Relaciona la venta con sus renglones de detalle
INNER JOIN DETALLE_VENTA DV
    ON V.id_venta = DV.id_venta

-- Relaciona cada renglon con los datos de su producto
INNER JOIN PRODUCTO P
    ON DV.id_producto = P.id_producto

-- Filtra los resultados para mostrar solamente la venta indicada
WHERE V.id_venta = @id_venta

-- Ordena los productos por nombre para facilitar la lectura de la factura
ORDER BY P.nombre_producto;
GO
