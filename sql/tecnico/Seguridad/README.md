
-- SEGURIDAD - Base de datos: FrigorificoDB
USE FrigorificoDB;
GO

-- 1  crea usuario (para practicas locales)
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'usr_vendedor')
    CREATE USER usr_vendedor WITHOUT LOGIN;
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'usr_sin_permisos')
    CREATE USER usr_sin_permisos WITHOUT LOGIN;
GO

-- 2. crear rol personalizado
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'rol_vendedor' AND type = 'R')
    CREATE ROLE rol_vendedor;
GO

-- 3. ASIGNAR PERMISOS AL ROL
-- El rol puede consultar productos y ejecutar el procedimiento real de ventas de la companera
GRANT SELECT ON OBJECT::dbo.PRODUCTO TO rol_vendedor;
GRANT EXECUTE ON OBJECT::dbo.sp_RegistrarVentaCompleta TO rol_vendedor;

-- Bloquear explicitamente modificaciones directas sobre las tablas criticas
DENY INSERT, UPDATE, DELETE ON OBJECT::dbo.PRODUCTO TO rol_vendedor;
DENY INSERT, UPDATE, DELETE ON OBJECT::dbo.VENTA TO rol_vendedor;
DENY INSERT, UPDATE, DELETE ON OBJECT::dbo.DETALLE_VENTA TO rol_vendedor;
GO

-- 4. ASOCIAR EL USUARIO AUTORIZADO AL ROL
ALTER ROLE rol_vendedor ADD MEMBER usr_vendedor;
GO
-- ('usr_sin_permisos' se queda fuera del rol y sin ningun permiso otorgado).

-- =====================================================================
-- 5. SCRIPT DE DEMOSTRACION (PRUEBAS CON EXECUTE AS USER)
PRINT '-------------------------------------------------------------';
PRINT 'CASO 1: PRUEBA CON USUARIO AUTORIZADO (usr_vendedor)';
PRINT '-------------------------------------------------------------';
EXECUTE AS USER = 'usr_vendedor';
GO

-- 5.1 Prueba Concedida: Leer la tabla PRODUCTO
BEGIN TRY
    SELECT TOP 3 id_producto, nombre_producto, precio_actual FROM dbo.PRODUCTO;
    PRINT '-> EXITO [CONCEDIDO]: usr_vendedor pudo consultar los productos.';
END TRY
BEGIN CATCH
    PRINT '-> ERROR: ' + ERROR_MESSAGE();
END CATCH;
GO

-- 5.2 Prueba Concedida: Ejecutar el Procedimiento Real de la companera
-- (Utiliza los parametros reales: cliente, vendedor, forma_pago, producto, cantidad)
BEGIN TRY
    EXEC dbo.sp_RegistrarVentaCompleta 
         @id_cliente = 5, 
         @id_vendedor = 5, 
         @id_forma_pago = 6, 
         @id_producto = 3, 
         @cantidad = 5;
         
    PRINT '-> EXITO [CONCEDIDO]: usr_vendedor pudo ejecutar el SP real de ventas.';
END TRY
BEGIN CATCH
    PRINT '-> ERROR: ' + ERROR_MESSAGE();
END CATCH;
GO

-- 5.3 Prueba Denegada: Intentar modificar directamente la tabla PRODUCTO
BEGIN TRY
    UPDATE dbo.PRODUCTO SET stock_actual = 999 WHERE id_producto = 1;
    PRINT '-> ALERTA: Se permitio la modificacion (No deberia pasar).';
END TRY
BEGIN CATCH
    PRINT '-> RESULTADO CORRECTO [DENEGADO]: Bloqueado por seguridad -> ' + ERROR_MESSAGE();
END CATCH;
GO

REVERT; -- Volvemos a nuestro usuario administrador
GO

PRINT '';
PRINT '-------------------------------------------------------------';
PRINT 'CASO 2: PRUEBA CON USUARIO NO AUTORIZADO (usr_sin_permisos)';
PRINT '-------------------------------------------------------------';
EXECUTE AS USER = 'usr_sin_permisos';
GO

-- 5.4 Prueba Denegada Total: Intentar leer la tabla sin permisos
BEGIN TRY
    SELECT * FROM dbo.PRODUCTO;
    PRINT '-> ALERTA: Pudo leer sin tener permisos.';
END TRY
BEGIN CATCH
    PRINT '-> RESULTADO CORRECTO [DENEGADO]: Acceso denegado a la tabla -> ' + ERROR_MESSAGE();
END CATCH;
GO

REVERT; -- Volvemos al usuario administrador original
GO

PRINT '-------------------------------------------------------------';
PRINT 'FIN DE LA DEMOSTRACION DE SEGURIDAD';
PRINT '-------------------------------------------------------------';
GO

