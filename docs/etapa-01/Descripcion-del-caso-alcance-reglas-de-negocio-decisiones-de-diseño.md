

**BASES DE DATOS I** 

# **PROYECTO INTEGRADOR** 

**ETAPA I: REQUERIMIENTOS Y DOMINIO DEL NEGOCIO** 

**TEMA DEL PROYECTO** **~~Sistema de Gestión de~~ Ventas y Control de Stock NÚMERO DE GRUPO para Frigorífico y Carnicería Grupo 36** **<u>Industrial</u>** 

#### **INTEGRANTES DEL EQUIPO** 

|**#**|**APELLIDO Y NOMBRE**|**DNI**|
|---|---|---|
|**1**|**Franco, Sebastián Mariano**|**46.717.321**|
|**2**|**Garay, Lucia Valentina**|**46.241.524**|
|**3**|**Gonzales, Milagros Esperanza**|**46.775.536**|
|**4**|**Ibalo Pereyra, Agustina Beatriz**|**46.601.661**|
|**5**|**Romero, Julieta Estefanía**|**44.557.617**|



**Año lectivo:** 2026 

**Fecha de entrega: 04/09/2026** 

#### **CONSIGNAS Y FECHAS:** 

#### **Aspectos establecidos en el programa de la asignatura BASES DE DATOS I Proyecto:** 

El trabajo de estudio e investigación, promueve el aprendizaje basado en problemas, aplicando habilidades y conocimientos adquiridos, como así también la investigación y el aprendizaje autónomo. A partir de un caso de estudio, cada grupo de estudiantes, elabora una propuesta con una implementación en un motor de bases de datos, aplicando aspectos técnicos que son aportados por el equipo docente. Cada docente tendrá un rol orientador para cada grupo de proyecto. 

#### **Evaluación asociada:** 

Se evaluará la participación activa del estudiante en las actividades de aprendizaje, así como su capacidad para trabajar en equipo y colaborar con otros estudiantes.  La capacidad del estudiante para planificar y organizar su trabajo, comunicarse de manera clara y efectiva, aplicar su creatividad e innovación, y el uso de herramientas y tecnologías. 

#### **Régimen de acreditación** 

El proyecto de estudio, que tiene como objetivo unir la teoría con la práctica de manera de aplicar lo aprendido para su mejor comprensión e internalización, tendrá diferentes etapas de entregas parciales, y será considerado como “ _aceptable_ ” si al momento de la entrega final, cumple con todas las pautas previamente <u>establecidas por el cuerpo docente. La calificación final será individual.</u> 

|**Etapa**|**Pregunta que responde**|**Producto**|**Fecha**<br>**Entrega **|
|---|---|---|---|
|I. Requerimientos|¿Qué necesita el negocio?|Requerimientos + reglas|viernes<br>04/09|
|II. Modelado|¿Cómo representamos la<br>información?|DER + modelo relacional + 3FN|viernes<br>11/09|
|III.<br>Implementación|<sup>¿Cómo construimos la BD?</sup>|<sup>DDL + DML</sup>|miércoles<br>30/09|
|IV. Consultas|¿Cómo obtenemos<br>información?|SQL + casos de uso||
|V. Temas<br>técnicos|¿Cómo hacemos la solución<br>más robusta?|Procedimientos, funciones, transacciones,<br>triggers,seguridad e índices||



## **Pautas para la elaboración** 

#### **1. Presentación y Contexto** 

El objetivo central del proyecto es diseñar, normalizar e implementar una base de datos relacional que soporte el ciclo completo de operaciones de venta, garantizando la integridad referencial, la consistencia y la no redundancia de la información. 

#### **2. Alcance y Restricciones** 

- **Dominio del problema:** Todos los equipos deberán desarrollar un sistema de gestión de ventas de productos o servicios(ej. indumentaria, electrónica, repuestos automotores, librería, etc.) , pudiendo seleccionar libremente el dominio específico, siempre que el caso permita satisfacer los requerimientos mínimos establecidos. 

- **Límite de tablas:** El modelo deberá presentar una complejidad suficiente para representar adecuadamente el dominio seleccionado. Como referencia, se espera un esquema de entre 6 y 10 relaciones, pudiendo justificarse una cantidad diferente cuando las características del dominio lo requieran. 

- **Nivel de normalización:** El esquema debe alcanzar obligatoriamente la **Tercera Forma Normal (3FN)** . 

#### **3. Etapas y Entregables:** 

#### **Etapa I: Requerimientos y Dominio del Negocio** 

1. **Descripción del caso:** Breve introducción al rubro elegido y alcance del sistema. 

2. **Reglas de Negocio (mínimo 6):** Redacción explícita de las reglas que rigen las operaciones. 

   - a. _Debe incluir al menos:_ gestión de stock, registro de clientes, historial de precios unitarios en el detalle de compra (para evitar cambios retroactivos) y métodos de pago. 

#### **Etapa II: Modelado Conceptual y Lógico** 

1. **Diagrama Entidad-Relación (DER):** Diagrama con entidades, atributos, relaciones y cardinalidades (1:1, 1:N, N:M). Usando notación P. Chen en la herramienta ERDPlus. 

2. **Transformación al Modelo Relacional:** Notación de tablas con claves primarias (PK) y foráneas (FK). 

3. **Proceso de Normalización:** Documentación paso a paso de la evolución del modelo: 

   - a. **1FN:** Eliminación de grupos repetitivos y garantía de atomicidad. 

   - b. **2FN:** Eliminación de dependencias funcionales parciales en claves compuestas. 

   - c. **3FN:** Eliminación de dependencias transitivas en atributos no clave. 

#### **Etapa III: Implementación Física (Scripts SQL)** 

1. **Script DDL (Data Definition Language):** 

   - a. Creación de tablas e integridad referencial (PRIMARY KEY, FOREIGN KEY con reglas de borrado/modificación). 

   - b. Definición correcta de tipos de datos (VARCHAR, DECIMAL, DATETIME, etc.) y restricciones (NOT NULL, UNIQUE, CHECK). 

2. **Script DML (Data Manipulation Language):** 

   - a. Poblado inicial de la base de datos con al menos **8 a 10 registros coherentes por tabla** para pruebas. 

#### **Etapa IV: Consultas y Casos de Uso** 

Desarrollar y probar los scripts SQL para responder a las siguientes necesidades de información: 

#### 1. 

1. **Factura/Comprobante:** Consulta que consolide el encabezado y detalle de una venta, calculando sub-totales por renglón y el total acumulado. 

2. **Reporte Agregado:** Total de ventas realizadas por cada vendedor o por cada categoría de producto en un rango de fechas (GROUP BY, SUM, COUNT). 

3. **Consulta de Negocio Avanzada:** Una consulta que combine al menos 3 tablas mediante JOIN y aplique filtros condicionales (HAVING o subconsultas). 

#### **Etapa V: Implementación temas tècnicos** 

Investigar e implementar en el motor de bases de datos diferentes  componentes, mecanismos y estructuras que aportan valor crítico para que la implementación de la base de datos sea robusta, rápida, segura y fácil de mantener a largo plazo. 

1. **Descripción breve** de cada uno de los temas tècnicos y fundamentos de aplicación en el caso de estudio desarrollado 

2. **Script SQL de implementación** en el motor de bases de datos 

3. **Script SQL o resumen explicativo** (en caso de corresponder) **de demostración** de utilización de cada tema técnico implementado. 

4. **Temas técnicos:** Procedimientos y funciones almacenadas; Manejo de transacciones; Triggers de auditorías; Seguridad; Índices (optimización) 

**5. Etapas y fechas** 

|**Etapa**|**Pregunta que responde**|**Producto**|**Fecha**<br>**Entrega**|
|---|---|---|---|
|**I. Requerimientos**|¿Qué necesita el negocio?|Requerimientos + reglas|viernes<br>04/09|
|**II. Modelado**|¿Cómo representamos la<br>información?|DER + modelo relacional + 3FN|viernes<br>11/09|
|**III.**<br>**Implementación**|<sup>¿Cómo construimos la BD?</sup>|<sup>DDL + DML</sup>|miércoles<br>30/09|
|**IV. Consultas**|¿Cómo obtenemos<br>información?|SQL + casos de uso||
|**V. Temas técnicos**|<sup>¿Cómo hacemos la solución</sup><br>más robusta?|Procedimientos, funciones, transacciones,<br>triggers,seguridad e índices||



#### **6. Estructura del GIT** 

Cada equipo debería tener un repositorio propio, siguiendo la siguiente estructura: 



<!-- Start of picture text -->
Proyecto-bd1-equipo_XX/<br>│<br>├── docs/<br>│   ├── etapa-01/<br>│   ├── etapa-02/<br>│   ├── etapa-03/<br>│   ├── etapa-04/<br>│   └── etapa-05/<br>│<br>├── sql/<br>│   ├── ddl/<br>│   ├── dml/<br>│   ├── consultas/<br>│   └── tecnico/<br>│<br>├── modelos/<br>│   └── der/<br>│<br>└──  README.md<br><!-- End of picture text -->

**Etapa I: Requerimientos y Dominio del Negocio** 

### **Descripción completa del caso de estudio:** 

El presente proyecto aborda el diseño e implementación de un sistema de gestión de base de datos relacional para una empresa del rubro cárnico (Frigorífico / Carnicería Industrial). La organización se dedica al procesamiento, distribución y comercialización mayorista y minorista de diversos cortes de carne (vacuno, porcino, avícola), embutidos y achuras. 

Actualmente, la empresa enfrenta la necesidad de sistematizar su proceso de ventas para garantizar la integridad de las transacciones, mantener un control riguroso sobre las existencias de mercancía, gestionar adecuadamente las carteras de clientes habituales y corporativos, y disponer de una trazabilidad exacta de los valores históricos de comercialización debido a la constante fluctuación de precios en el mercado cárnico. 

#### **Alcance del sistema (hasta donde abarca el proyecto):** 

El sistema abarcará de manera integral el **ciclo completo de operaciones de venta** y control directo de existencias: 

- **Gestión de catálogo y productos:** Clasificación de cortes y productos por categorías (Vacuno, Porcino, Avícola, Embutidos, Achuras), registrando unidades de medida en kilogramos o unidades físicas. 

- **Gestión de clientes y vendedores:** Padrón completo de clientes registrados (minoristas y mayoristas) y registro del personal de ventas interviniente. 

- **Control de stock en tiempo real:** Actualización de las existencias disponibles ante cada transacción concretada. 

- **Procesamiento y facturación de ventas:** Registro de comprobantes de venta (encabezado y detalle) con congelamiento del precio unitario aplicable en el momento exacto de la operación. 

- **Formas y métodos de pago:** Registro detallado de la modalidad de pago empleada en cada venta (Efectivo, Débito, Crédito, Transferencia). 

_Fuera de alcance:_ No se incluyen los procesos de logística externa/transporte, liquidación de sueldos del personal, compras e importación de hacienda en pie ni procesos biológicos/industriales de faena. 

- **RN.01 (Historial de precios unitarios):** Cada detalle de venta registra el precio unitario del momento para evitar que futuros aumentos modifiquen ventas pasadas. 

- **RN.02 (Control de stock):** Cada producto tiene un stock disponible en kg o unidades que disminuye automáticamente con cada venta. 

- **RN.03 (Registro de clientes):** Toda venta requiere asociar un cliente registrado o el registro genérico "Consumidor Final". 

- **RN.04 (Métodos de pago):** Cada venta debe asignarse a una forma de pago válida (Efectivo, Débito, Crédito o Transferencia). 

- **RN.05 (Asignación de vendedor):** Cada comprobante de venta debe registrar obligatoriamente al vendedor que realizó la operación. 

- **RN.06 (Categorización de productos):** Todo producto debe pertenecer a una sola categoría (ej. Vacuno, Porcino, Avícola, Embutidos). 

- **RN.07 (Validación de stock disponible):** No se pueden realizar ventas por una cantidad mayor al stock actual del producto. 

- **RN.08 (Precios y cantidades vendidas positivas):** Los precios unitarios y las cantidades 

- vendidas deben ser mayores a cero, mientras que el nivel de stock puede ser cero. 

- **RN.09 (Unicidad de documentos):** Los vendedores se identifican de forma única mediante su DNI y las empresas clientes o clientes comerciales mediante su CUIT. 

- **RN.10 (Consistencia del total):** El monto total de la venta debe ser igual a la suma de los subtotales (cantidad × precio unitario) de sus ítems. 

#### **Debe incluir al menos:** 

1. **Gestión de Stock:(** Incluido en la regla **RN.02** _(Control de stock)_ y la **RN.07** _(Validación de stock disponible)_ ). 

2. **Registros de clientes:(** incluido en la regla **RN.03** _(Registro de clientes)_ y la **RN.09** _(Unicidad de documentos)_ ). 

3. **Historial de precios unitarios en el detalle de compra (para evitar cambios y retroactivos): (** Incluido en la regla **RN.01** _(Historial de precios unitarios en el detalle de venta))._ 

4. **Métodos de pago:** ( Incluido en la regla **RN.04** _(Métodos de pago habilitados)_ 

