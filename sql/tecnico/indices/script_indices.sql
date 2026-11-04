
USE FrigorificoDB;
GO

-- 1. Insertar el cliente con el nombre y apellido exigidos por la tabla de tus compañeros
IF NOT EXISTS (SELECT 1 FROM dbo.CLIENTE WHERE id_cliente = 1)
BEGIN
    SET IDENTITY_INSERT dbo.CLIENTE ON;
    INSERT INTO dbo.CLIENTE (id_cliente, nombre_cliente, apellido_cliente) 
    VALUES (1, 'Consumidor', 'Final');
    SET IDENTITY_INSERT dbo.CLIENTE OFF;
END
GO

-- 2. Insertar el vendedor básico con ID 1 (por si acaso)
IF NOT EXISTS (SELECT 1 FROM dbo.VENDEDOR WHERE id_vendedor = 1)
BEGIN
    SET IDENTITY_INSERT dbo.VENDEDOR ON;
    INSERT INTO dbo.VENDEDOR (id_vendedor) 
    VALUES (1);
    SET IDENTITY_INSERT dbo.VENDEDOR OFF;
END
GO

-- 3. Insertar la forma de pago básica con ID 1 (por si acaso)
IF NOT EXISTS (SELECT 1 FROM dbo.FORMA_PAGO WHERE id_forma_pago = 1)
BEGIN
    SET IDENTITY_INSERT dbo.FORMA_PAGO ON;
    INSERT INTO dbo.FORMA_PAGO (id_forma_pago) 
    VALUES (1);
    SET IDENTITY_INSERT dbo.FORMA_PAGO OFF;
END
GO

-- 4. Insertar los datos de prueba en VENTA de manera segura
INSERT INTO dbo.VENTA (fecha_hora, total, id_cliente, id_vendedor, id_forma_pago)
VALUES 
    ('2025-05-10 10:30:00', 15000.00, 1, 1, 1),
    ('2025-06-12 14:15:00', 22500.50, 1, 1, 1),
    ('2025-08-20 09:00:00', 8900.00, 1, 1, 1),
    ('2025-09-15 16:45:00', 31000.00, 1, 1, 1),
    ('2025-10-01 11:20:00', 12400.00, 1, 1, 1);
GO

-- 5. Eliminar el índice si ya existía para evitar conflictos
IF EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_VENTA_Fecha_Hora_Incluir' AND object_id = OBJECT_ID('dbo.VENTA'))
BEGIN
    DROP INDEX IX_VENTA_Fecha_Hora_Incluir ON dbo.VENTA;
END
GO

-- 6. Consulta ANTES del índice (Acuérdate de activar el Plan de Ejecución con Ctrl + M)
SELECT fecha_hora, COUNT(*) AS Total_Ventas
FROM dbo.VENTA
WHERE fecha_hora BETWEEN '2025-01-01' AND '2025-12-31'
GROUP BY fecha_hora;
GO

-- 7. Creación del Índice No Clustered optimizado
CREATE INDEX IX_VENTA_Fecha_Hora_Incluir 
ON dbo.VENTA (fecha_hora)
INCLUDE (total);
GO

-- 8. Consulta DESPUÉS del índice para verificar
SELECT fecha_hora, COUNT(*) AS Total_Ventas
FROM dbo.VENTA
WHERE fecha_hora BETWEEN '2025-01-01' AND '2025-12-31'
GROUP BY fecha_hora;
GO