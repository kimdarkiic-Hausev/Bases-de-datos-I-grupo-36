USE FrigorificoDB;
GO

-- 1. Limpieza previa: Borramos el índice si ya existe para poder probar su creación desde cero
IF EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_VENTA_Fecha_Hora_Incluir' AND object_id = OBJECT_ID('dbo.VENTA'))
BEGIN
    DROP INDEX IX_VENTA_Fecha_Hora_Incluir ON dbo.VENTA;
END
GO

-- ==========================================
-- CASO DE PRUEBA 1: Consulta ANTES del Índice
-- (Acuérdate de apretar Ctrl + M para activar el plan de ejecución antes de correr esto)
-- ==========================================
SELECT fecha_hora, COUNT(*) AS Total_Ventas
FROM dbo.VENTA
WHERE fecha_hora BETWEEN '2025-01-01' AND '2025-12-31'
GROUP BY fecha_hora;
GO

-- ==========================================
-- CASO DE PRUEBA 2: Creación del Índice
-- ==========================================
CREATE INDEX IX_VENTA_Fecha_Hora_Incluir 
ON dbo.VENTA (fecha_hora)
INCLUDE (total);
GO

-- ==========================================
-- CASO DE PRUEBA 3: Consulta DESPUÉS del Índice
-- ==========================================
SELECT fecha_hora, COUNT(*) AS Total_Ventas
FROM dbo.VENTA
WHERE fecha_hora BETWEEN '2025-01-01' AND '2025-12-31'
GROUP BY fecha_hora;
GO