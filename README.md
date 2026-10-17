# 🥩 BD1 Grupo 36 | Frigorífico Cárnico
> **Sistema de Gestión de Ventas y Control de Stock: Frigorífico y Carnicería Industrial**  
> Proyecto Integrador - Bases de Datos I (Año Lectivo 2026) — **Grupo 36**



## 📌 Descripción del Proyecto

Sistema de base de datos relacional desarrollado en **SQL Server** diseñado para soportar el ciclo comercial y operativo completo de una empresa del rubro cárnico. 

Soporta la convivencia de **canales minoristas** (atención de mostrador a consumidores finales) y **canales mayoristas** (distribución a restaurantes, carnicerías de barrio y supermercados), gestionando productos por kilogramos o unidades, trazabilidad de precios históricos y control automático de inventario.



## 👥 Integrantes

* **Franco**, Sebastián Mariano
* **Garay**, Lucía Valentina
* **Gonzales**, Milagros Esperanza
* **Ibalo Pereyra**, Agustina Beatriz
* **Romero**, Julieta Estefanía



## 📁 Estructura del Repositorio


├── docs/
│   ├── etapa-01/    # Requerimientos, alcance y reglas de negocio
│   ├── etapa-02/    # DER (Peter Chen), modelo relacional y normalización (3FN)
│   ├── etapa-03/    # Informe de implementación física (DDL + DML)
│   ├── etapa-04/    # Consultas SQL, casos de uso y reportes
│   └── etapa-05/    # Temas técnicos avanzados (SPs, Triggers, Transacciones, Seguridad, Índices)
│
└── sql/
    ├── ddl/         # Script de creación de la base FrigorificoDB y sus tablas
    ├── dml/         # Scripts de carga inicial de datos por tabla
    ├── consultas/   # Consultas de la Etapa IV (Facturas, reportes y clientes VIP)
    └── tecnico/     # Scripts de la Etapa V (Lógica programada y optimización)



## 🗺️ Etapas del Proyecto

### 📌 [Etapa I: Requerimientos y Dominio del Negocio](https://www.google.com/search?q=./docs/etapa-01/)

Definición del alcance operativo para los canales minorista y mayorista, junto con las **Reglas de Negocio (RN)** que rigen la gestión de stock, registro de clientes, historial congelado de precios unitarios y métodos de pago.

### 📐 [Etapa II: Modelado Conceptual y Lógico](https://www.google.com/search?q=./docs/etapa-02/)

Diseño del **Diagrama Entidad-Relación (DER)** en notación Peter Chen (mediante ERDPlus), transformación al modelo relacional (PKs y FKs) y proceso documentado de normalización paso a paso (**UNF $\rightarrow$ 1FN $\rightarrow$ 2FN $\rightarrow$ 3FN**).

### 🛠️ [Etapa III: Implementación Física (Scripts SQL)](https://www.google.com/search?q=./docs/etapa-03/)


Construcción física en SQL Server:

* **DDL:** Creación de tablas, restricciones `CHECK`, claves foráneas con reglas de borrado/actualización y columna calculada `PERSISTED` para subtotales.
* **Control de Stock:** Trigger `TR_DETALLE_VENTA_CONTROL_STOCK` para validación y descuento automático de inventario en tiempo real.
* **DML:** Carga inicial ordenada de datos de prueba para asegurar la integridad referencial.

### 📊 [Etapa IV: Consultas y Casos de Uso](https://www.google.com/search?q=./docs/etapa-04/)

Desarrollo y prueba de necesidades de información del negocio:

* **Consigna 1 (Factura / Comprobante):** Consulta consolidada de encabezado y detalle con `SUM(...) OVER(PARTITION BY id_venta)`.
* **Consigna 2 (Reportes Agregados):** Análisis multidimensional por período (vendedor, categoría, forma de pago y producto) mediante `GROUP BY`, `SUM`, `COUNT` y `AVG`.
* **Consigna 3 (Consulta Avanzada):** Segmentación de clientes VIP/mayoristas mediante `JOIN` multitabla, filtros `HAVING` y subconsultas dinámicas sobre el gasto promedio general.

### ⚙️ [Etapa V: Implementación de Temas Técnicos Avanzados](https://www.google.com/search?q=./docs/etapa-05/)

Mecanismos y estructuras avanzadas para asegurar solidez, seguridad y rendimiento:

* **Procedimientos y Funciones Almacenadas (SPs & Functions):** Encapsulamiento de lógica frecuente.
* **Transacciones (`BEGIN TRAN / COMMIT / ROLLBACK`):** Garantía de propiedades ACID en operaciones críticas.
* **Triggers de Auditoría:** Registro automático de modificaciones y auditoría de eventos.
* **Seguridad y Permisos:** Roles, usuarios y privilegios acotados.
* **Índices y Optimización:** Estructuras `CLUSTERED` y `NONCLUSTERED` para acelerar consultas frecuentes.



## 🚀 Guía de Ejecución

### **Requisitos Previos**

* SQL Server (2019 o superior / Express)
* SQL Server Management Studio (SSMS) o Azure Data Studio

### **Orden de Ejecución de Scripts**

1. **Creación de la Estructura (DDL):**
Ejecutar `sql/ddl/DDL_Frigorifico.sql` para crear la base de datos `FrigorificoDB` y sus tablas.
2. **Carga de Datos (DML):**
Ejecutar los scripts dentro de `sql/dml/` respetando las dependencias jerárquicas:
CATEGORIA / CLIENTE / VENDEDOR / FORMA_PAGO-->PRODUCTO--> VENTA --> DETALLE_VENTA


3. **Consultas y Casos de Uso (Etapa IV):**
Ejecutar los archivos ubicados en `sql/consultas/` (o `sql/consultas/Etapa4CasosPrueba.sql`).
4. **Objetos Técnicos Avanzados (Etapa V):**
Ejecutar los scripts correspondientes dentro de `sql/tecnico/`.

