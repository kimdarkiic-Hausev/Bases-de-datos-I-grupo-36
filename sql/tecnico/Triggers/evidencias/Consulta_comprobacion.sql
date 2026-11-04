--comprueba si se creo correctamente la tabla de auditoria
USE FrigorificoDB;
GO

SELECT name
FROM sys.triggers
WHERE name = 'TR_AUDITORIA_PRECIOS';
