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

    -- Guardar el ID de la venta
    INSERT INTO VENTA_TEMPORAL (id_venta)
    VALUES (SCOPE_IDENTITY());

    -- Intentar vender una cantidad superior al stock
    INSERT INTO DETALLE_VENTA (
        id_venta,
        id_producto,
        cantidad,
        precio_unitario
    )
    SELECT
        id_venta,
        1,
        999999,
        1000
    FROM VENTA_TEMPORAL;

    -- Confirmar la transacción
    COMMIT TRANSACTION;

    PRINT 'Venta registrada correctamente.';

END TRY

BEGIN CATCH

    -- Deshacer los cambios si ocurre un error
    IF XACT_STATE() <> 0
        ROLLBACK TRANSACTION;

    PRINT 'No se pudo registrar la venta.';
    PRINT ERROR_MESSAGE();

END CATCH;

-- Eliminar el registro auxiliar
DELETE FROM VENTA_TEMPORAL;
GO
```
