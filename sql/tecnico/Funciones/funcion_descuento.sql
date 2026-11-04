-- Etapa V - Tema 1: Funcion almacenada
-- Devuelve el descuento de un cliente segun su monto acumulado de compras:
-- mas de $500.000 -> 10%, mas de $200.000 -> 5%, resto -> 0%.
USE FrigorificoDB;
GO

CREATE OR ALTER FUNCTION dbo.fn_CalcularDescuentoCliente (@id_cliente INT)
RETURNS DECIMAL(4,2)
AS
BEGIN
    DECLARE @acumulado DECIMAL(12,2);

    SELECT @acumulado = ISNULL(SUM(total), 0)
    FROM VENTA
    WHERE id_cliente = @id_cliente;

    RETURN CASE
        WHEN @acumulado > 500000 THEN 0.10
        WHEN @acumulado > 200000 THEN 0.05
        ELSE 0.00
    END;
END;
GO

-- Demostracion 1: descuento de cada cliente con los datos actuales
SELECT c.id_cliente, c.nombre_cliente, c.apellido_cliente,
       ISNULL(SUM(v.total), 0) AS acumulado,
       dbo.fn_CalcularDescuentoCliente(c.id_cliente) AS descuento
FROM CLIENTE AS c
LEFT JOIN VENTA AS v ON v.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nombre_cliente, c.apellido_cliente
ORDER BY acumulado DESC;

-- Demostracion 2: tramo del 10% sin modificar los datos
BEGIN TRANSACTION;
    INSERT INTO VENTA (fecha_hora, total, id_cliente, id_vendedor, id_forma_pago)
    VALUES (GETDATE(), 200000.00, 5, 5, 6);          -- Don Julio pasa a 544.972
    SELECT dbo.fn_CalcularDescuentoCliente(5) AS descuento_don_julio;   -- 0.10
ROLLBACK TRANSACTION;                                -- deshace el INSERT

SELECT dbo.fn_CalcularDescuentoCliente(5) AS descuento_despues;     -- 0.05
GO
