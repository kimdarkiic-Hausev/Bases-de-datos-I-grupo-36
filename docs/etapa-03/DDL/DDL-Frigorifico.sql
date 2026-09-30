-- Creación de la base de datos
CREATE DATABASE FrigorificoDB;
GO

USE FrigorificoDB;
GO

-- 1. Tabla CATEGORIA
CREATE TABLE CATEGORIA (
    id_categoria INT IDENTITY(1,1) CONSTRAINT PK_Categoria PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL CONSTRAINT UQ_Categoria_Nombre UNIQUE,
    descripcion VARCHAR(150) NULL
);
GO

-- 2. Tabla PRODUCTO
CREATE TABLE PRODUCTO (
    id_producto INT IDENTITY(1,1) CONSTRAINT PK_Producto PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    unidad_medida VARCHAR(10) NOT NULL CONSTRAINT CK_Producto_Unidad CHECK (unidad_medida IN ('KG', 'UNIDAD', 'kg', 'unidad')),
    precio_actual DECIMAL(10,2) NOT NULL CONSTRAINT CK_Producto_Precio CHECK (precio_actual > 0),
    stock_actual DECIMAL(10,2) NOT NULL CONSTRAINT CK_Producto_Stock CHECK (stock_actual >= 0),
    id_categoria INT NOT NULL,
    CONSTRAINT FK_Producto_Categoria FOREIGN KEY (id_categoria) 
        REFERENCES CATEGORIA(id_categoria)
        ON DELETE NO ACTION
        ON UPDATE CASCADE
);
GO

-- 3. Tabla CLIENTE
CREATE TABLE CLIENTE (
    id_cliente INT IDENTITY(1,1) CONSTRAINT PK_Cliente PRIMARY KEY,
    nombre_cliente VARCHAR(50) NOT NULL,
    apellido_cliente VARCHAR(50) NOT NULL,
    razon_social VARCHAR(100) NULL,
    dni_cliente VARCHAR(15) NULL CONSTRAINT UQ_Cliente_DNI UNIQUE,
    cuit_cliente VARCHAR(15) NULL CONSTRAINT UQ_Cliente_CUIT UNIQUE,
    telefono_cliente VARCHAR(20) NULL,
    email_cliente VARCHAR(100) NULL
);
GO

-- 4. Tabla VENDEDOR
CREATE TABLE VENDEDOR (
    id_vendedor INT IDENTITY(1,1) CONSTRAINT PK_Vendedor PRIMARY KEY,
    nombre_vendedor VARCHAR(50) NOT NULL,
    apellido_vendedor VARCHAR(50) NOT NULL,
    dni_vendedor VARCHAR(15) NOT NULL CONSTRAINT UQ_Vendedor_DNI UNIQUE,
    legajo VARCHAR(20) NOT NULL CONSTRAINT UQ_Vendedor_Legajo UNIQUE,
    telefono_vendedor VARCHAR(20) NULL
);
GO

-- 5. Tabla FORMA_PAGO
CREATE TABLE FORMA_PAGO (
    id_forma_pago INT IDENTITY(1,1) CONSTRAINT PK_FormaPago PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL CONSTRAINT UQ_FormaPago_Descripcion UNIQUE
);
GO

-- 6. Tabla VENTA
CREATE TABLE VENTA (
    id_venta INT IDENTITY(1,1) CONSTRAINT PK_Venta PRIMARY KEY,
    fecha_hora DATETIME DEFAULT GETDATE() NOT NULL,
    total DECIMAL(12,2) NOT NULL CONSTRAINT CK_Venta_Total CHECK (total >= 0),
    id_cliente INT NOT NULL,
    id_vendedor INT NOT NULL,
    id_forma_pago INT NOT NULL,
    CONSTRAINT FK_Venta_Cliente FOREIGN KEY (id_cliente) 
        REFERENCES CLIENTE(id_cliente)
        ON DELETE NO ACTION
        ON UPDATE CASCADE,
    CONSTRAINT FK_Venta_Vendedor FOREIGN KEY (id_vendedor) 
        REFERENCES VENDEDOR(id_vendedor)
        ON DELETE NO ACTION
        ON UPDATE CASCADE,
    CONSTRAINT FK_Venta_FormaPago FOREIGN KEY (id_forma_pago) 
        REFERENCES FORMA_PAGO(id_forma_pago)
        ON DELETE NO ACTION
        ON UPDATE CASCADE
);
GO
--7. Tabla detalle-venta
CREATE TABLE DETALLE_VENTA (
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,

    cantidad DECIMAL(10,2) NOT NULL
        CONSTRAINT CK_Detalle_Cantidad CHECK (cantidad > 0),

    precio_unitario DECIMAL(10,2) NOT NULL
        CONSTRAINT CK_Detalle_Precio CHECK (precio_unitario > 0),

    subtotal AS (cantidad * precio_unitario) PERSISTED,

    CONSTRAINT PK_DetalleVenta
        PRIMARY KEY (id_venta, id_producto),

    CONSTRAINT FK_Detalle_Venta
        FOREIGN KEY (id_venta)
        REFERENCES VENTA(id_venta)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT FK_Detalle_Producto
        FOREIGN KEY (id_producto)
        REFERENCES PRODUCTO(id_producto)
        ON DELETE NO ACTION
        ON UPDATE CASCADE
);
GO


CREATE TRIGGER TR_DETALLE_VENTA_CONTROL_STOCK
ON DETALLE_VENTA
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Verificar que el stock disponible sea suficiente
    IF EXISTS (
        SELECT 1
        FROM inserted AS i
        INNER JOIN PRODUCTO AS p
            ON i.id_producto = p.id_producto
        WHERE i.cantidad > p.stock_actual
    )
    BEGIN
        RAISERROR('No se puede realizar la venta: stock insuficiente para uno o más productos.', 16,1 );

        ROLLBACK TRANSACTION;
        RETURN;
    END;

    -- Descontar automáticamente el stock
    UPDATE p
    SET p.stock_actual = p.stock_actual - i.cantidad
    FROM PRODUCTO AS p
    INNER JOIN inserted AS i
        ON p.id_producto = i.id_producto;
END;
GO
