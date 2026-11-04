-- Etapa V - Tema 1: Procedimiento almacenado
-- Registra una venta de un producto: precio historico, descuento, encabezado y detalle.
-- El stock lo valida y descuenta el trigger TR_DETALLE_VENTA_CONTROL_STOCK.
-- Requiere sql/tecnico/Funciones/01_funcion_descuento.sql.
USE FrigorificoDB;
GO

CREATE OR ALTER PROCEDURE dbo.sp_RegistrarVentaCompleta
    @id_cliente    INT,
    @id_vendedor   INT,
    @id_forma_pago INT,
    @id_producto   INT,
    @cantidad      DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @precio    DECIMAL(10,2),
            @descuento DECIMAL(4,2),
            @total     DECIMAL(12,2),
            @id_venta  INT;

    -- 1) Precio actual del producto (queda guardado como precio historico)
    SELECT @precio = precio_actual
    FROM PRODUCTO
    WHERE id_producto = @id_producto;

    IF @precio IS NULL
    BEGIN
        RAISERROR('El producto %d no existe.', 16, 1, @id_producto);
        RETURN;
    END;

    -- 2) Descuento segun lo que el cliente compro hasta hoy
    SET @descuento = dbo.fn_CalcularDescuentoCliente(@id_cliente);

    -- 3) Total con descuento aplicado
    SET @total = ROUND(@cantidad * @precio * (1 - @descuento), 2);

    BEGIN TRY
        BEGIN TRANSACTION;

        -- 4) Encabezado de la venta
        INSERT INTO VENTA (fecha_hora, total, id_cliente, id_vendedor, id_forma_pago)
        VALUES (GETDATE(), @total, @id_cliente, @id_vendedor, @id_forma_pago);

        SET @id_venta = SCOPE_IDENTITY();

        -- 5) Detalle (el trigger valida y descuenta stock)
        INSERT INTO DETALLE_VENTA (id_venta, id_producto, cantidad, precio_unitario)
        VALUES (@id_venta, @id_producto, @cantidad, @precio);

        -- 6) Confirmar
        COMMIT TRANSACTION;

        SELECT @id_venta AS id_venta, @precio AS precio_unitario,
               @descuento AS descuento, @total AS total;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

-- Demostracion: Don Julio (cliente 5, 5% de descuento) compra 5 kg de Matambre (producto 3)
SELECT id_producto, nombre_producto, precio_actual, stock_actual
FROM PRODUCTO WHERE id_producto = 3;

EXEC dbo.sp_RegistrarVentaCompleta
     @id_cliente = 5, @id_vendedor = 5, @id_forma_pago = 6,
     @id_producto = 3, @cantidad = 5;

SELECT TOP 1 * FROM VENTA ORDER BY id_venta DESC;
SELECT * FROM DETALLE_VENTA WHERE id_venta = (SELECT MAX(id_venta) FROM VENTA);
SELECT id_producto, nombre_producto, stock_actual
FROM PRODUCTO WHERE id_producto = 3;
GO
