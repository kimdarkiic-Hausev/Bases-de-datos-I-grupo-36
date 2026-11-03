
BEGIN TRY

    BEGIN TRANSACTION;

    -- Registrar la venta
    INSERT INTO VENTA (
        total,
        id_cliente,
        id_vendedor,
        id_forma_pago
    )
    VALUES (0, 1, 1, 1);

      --Guardar el ID de la venta
    INSERT INTO VENTA_TEMPORAL (id_venta)
    VALUES (SCOPE_IDENTITY());

    -- Registrar los productos vendidos
    INSERT INTO DETALLE_VENTA (
        id_venta,
        id_producto,
        cantidad,
        precio_unitario
    )
    SELECT
        id_venta,
        1,
        5,
        1000
    FROM VENTA_TEMPORAL;

    INSERT INTO DETALLE_VENTA (
        id_venta,
        id_producto,
        cantidad,
        precio_unitario
    )
    SELECT
        id_venta,
        2,
        3,
        1500
    FROM VENTA_TEMPORAL;

    INSERT INTO DETALLE_VENTA (
        id_venta,
        id_producto,
        cantidad,
        precio_unitario
    )
    SELECT
        id_venta,
        3,
        2,
        2000
    FROM VENTA_TEMPORAL;

    -- Calcular el total de la venta
    UPDATE VENTA
    SET total = (
        SELECT SUM(subtotal)
        FROM DETALLE_VENTA
        WHERE id_venta = VENTA_TEMPORAL.id_venta
    )
    FROM VENTA_TEMPORAL
    WHERE VENTA.id_venta = VENTA_TEMPORAL.id_venta;

    -- Confirmar la transacción
    COMMIT TRANSACTION;

    PRINT 'Venta registrada correctamente.';

END TRY

BEGIN CATCH

    IF XACT_STATE() <> 0
        ROLLBACK TRANSACTION;

    PRINT 'Error al registrar la venta.';
    PRINT ERROR_MESSAGE();

END CATCH;

-- Eliminar el registro auxiliar
DELETE FROM VENTA_TEMPORAL;
GO
```
