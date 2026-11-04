-- Selecciona la base de datos donde se creara la tabla y el trigger
USE FrigorificoDB;
GO

-- Crea una tabla para almacenar el historial de cambios de precios
CREATE TABLE AUDITORIA_PRECIOS (
    -- Identificador unico de cada registro de auditoria
    id_auditoria INT IDENTITY(1,1) PRIMARY KEY,

    -- Identificador del producto cuyo precio fue modificado
    id_producto INT NOT NULL,

    -- Guarda el precio que tenia el producto antes de la modificacion
    precio_anterior DECIMAL(10,2) NOT NULL,

    -- Guarda el nuevo precio asignado al producto
    precio_nuevo DECIMAL(10,2) NOT NULL,

    -- Almacena la fecha y hora de la modificacion
    -- Si no se indica una fecha, utiliza automaticamente la fecha actual
    fecha_modificacion DATETIME NOT NULL DEFAULT GETDATE()
);
GO

-- Crea un trigger para registrar automaticamente los cambios de precios
-- Se ejecuta despues de realizar una actualizacion en la tabla PRODUCTO
CREATE TRIGGER TR_AUDITORIA_PRECIOS
ON PRODUCTO
AFTER UPDATE
AS
BEGIN
    -- Evita mostrar mensajes adicionales sobre la cantidad de filas afectadas
    SET NOCOUNT ON;

    -- Inserta en la tabla de auditoria los datos de cada precio modificado
    INSERT INTO AUDITORIA_PRECIOS
        (id_producto, precio_anterior, precio_nuevo, fecha_modificacion)

    -- Obtiene los valores anteriores y nuevos del precio del producto
    SELECT
        D.id_producto,
        D.precio_actual,
        I.precio_actual,
        GETDATE()

    -- deleted contiene los valores anteriores a la actualizacion
    FROM deleted D

    -- inserted contiene los valores nuevos despues de la actualizacion
    -- Se relacionan ambas tablas mediante el identificador del producto
    INNER JOIN inserted I
        ON D.id_producto = I.id_producto

    -- Registra solamente los productos cuyo precio haya cambiado
    WHERE D.precio_actual <> I.precio_actual;

END;
GO
