## **Mapa II: Modelado Conceptual y Lógico** 

1. **Diagrama Entidad-Relación (DER):** Diagrama con entidades, atributos, relaciones y 

   - cardinalidades (1:1, 1:N, N:M). Usando notación P. Chen en la herramienta ERDPlus. 

2. **Transformación al Modelo Relacional:** Notación de tablas con claves primarias (PK) y foráneas (FK). 

3. **Proceso de Normalización:** Documentación paso a paso de la evolución del modelo: 

      - **1FN:** Eliminación de grupos repetitivos y garantía de atomicidad. 

      - **2FN:** Eliminación de dependencias funcionales parciales en claves compuestas. 

      - **3FN:** Eliminación de dependencias transitivas en atributos no clave. 

#### **DESARROLLO:** 

### **Entidades y Atributos** 

- **CATEGORIA:** id_categoria, nombre_categoria, descripcion 

- **PRODUCTO:** id_producto, nombre_producto, unidad_medida, precio_actual, stock_actual 

- **CLIENTE:** id_cliente, nombre_cliente,,apellido_cliente,,razon_social, dni,telefono_cliente, email_cliente. 

- **VENDEDOR:** id_vendedor, nombre_vendedor, apellido_vendedor, dni_vendedor, legajo,teléfono_vendedor. 

- **FORMA_PAGO:** id_forma_pago, descripcion 

- **VENTA:** id_venta, fecha_hora, total 

- **Relación N:M (Contiene / Detalle):** cantidad, precio_unitario, subtotal 

### **Relaciones y Cardinalidades (para ERDPlus)** 

**CATEGORIA — (1:N) — PRODUCTO:** Una Categoría clasifica N Productos. Un Producto pertenece a 1 sola Categoría. 

**CLIENTE — (1:N) — VENTA:** Un Cliente realiza N Ventas. Una Venta es realizada por 1 solo Cliente. 

**VENDEDOR — (1:N) — VENTA:** Un Vendedor atiende N Ventas. Una Venta es registrada por 1 solo Vendedor. 

**FORMA_PAGO — (1:N) — VENTA:** Una Forma de Pago se utiliza en N Ventas. Una Venta utiliza 1 sola Forma de Pago. 

**VENTA — (N:M) — PRODUCTO:** Una Venta contiene M Productos. Un Producto está contenido en N Ventas. 

○ _Atributos colgados de la relación N:M:_ <mark>cantidad, precio_unitario</mark> , <mark>subtotal.</mark> 

# **2. Transformación al Modelo Relacional** 

- **CATEGORIA** (id_categoria,nombre_categoria,, descripcion) 

- **PRODUCTO** (id_producto, nombre_producto, unidad_medida, precio_actual, stock_actual, _id_categoria_ ) 

- **CLIENTE** (id_cliente, nombre-cliente,apellido_cliente,DNI_cliente, telefono_cliente, email_cliente) 

- 

- **VENDEDOR** (id_vendedor, nombre_vendedor, apellido_vendedor, dni_vendedor, legajo) 

- **FORMA_PAGO** (id_forma_pago, descripcion) 

- **VENTA** (id_venta, fecha_hora, total, _id_cliente_ , _id_vendedor_ , _id_forma_pago_ ) 

- **DETALLE_VENTA** (id_venta, id_producto, cantidad, precio_unitario, subtotal) 

_Simbología:_ **id_atributo** = Clave Primaria (PK) | ***id_atributo*** = Clave Foránea (FK). 

# **3. Proceso de Normalización Paso a Paso** 

### **Estado Inicial (No Normalizado - UNF)** 

En una vista plana sin normalizar, una transacción de venta acumula los ítems dentro del mismo registro: 

- **VENTA** (id_venta, fecha, cliente_nombre, cliente_doc, vendedor_nombre, forma_pago, [producto_nombre, categoria_nombre, cantidad, precio_unitario, subtotal]) 

### **Primera Forma Normal (1FN)** 

- **Regla aplicada:** Eliminación de grupos repetitivos y garantía de atomicidad en los atributos. 

- **Desarrollo:** Se independizan los ítems comprados en una estructura de detalle vinculada al comprobante cabecera. 

- **Esquema resultante en 1FN:** 

   - **VENTA:** (id_venta, fecha_hora, cliente_nombre, cliente_doc, vendedor_nombre, forma_pago) 

   - **DETALLE_VENTA:** (id_venta, id_producto, producto_nombre, categoria_nombre, cantidad, precio_unitario_historico, subtotal) 

   - 

### **Segunda Forma Normal (2FN)** 

- **Regla aplicada:** Cumplir 1FN y eliminar dependencias funcionales parciales sobre la clave primaria compuesta. 

- **Desarrollo:** En <mark>DETALLE_VENTA</mark> (PK compuesta por <mark>id_venta</mark> e <mark>id_producto</mark> ), los atributos <mark>producto_nombre</mark> y <mark>categoria_nombre</mark> dependen únicamente de <mark>id_producto</mark> (dependencia parcial). Por lo tanto, se extraen hacia la entidad <mark>PRODUCTO.</mark> Los campos <mark>cantidad</mark> y <mark>precio_unitario_historico</mark> se mantienen en la tabla intermedia ya que dependen de la combinación de ambas claves. 

- **Esquema resultante en 2FN:** 

   - **VENTA:** (id_venta, fecha_hora, cliente_nombre, cliente_doc, vendedor_nombre, forma_pago) 

   - **PRODUCTO:** (id_producto, producto_nombre, categoria_nombre, precio_actual, stock_actual) 

   - **DETALLE_VENTA:** (id_venta, id_producto, cantidad, precio_unitario_historico, subtotal) 

### **Tercera Forma Normal (3FN)** 

- **Regla aplicada:** Cumplir 2FN y eliminar dependencias transitivas entre atributos no clave. 

- **Desarrollo:** 

   - En <mark>VENTA,</mark> los datos del cliente, vendedor y la forma de pago no dependen directamente de <mark>id_venta.</mark> Se crean las entidades independientes <mark>CLIENTE, VENDEDOR</mark> y <mark>FORMA_PAGO.</mark> 

   - En <mark>PRODUCTO,</mark> la descripción de la categoría depende del concepto de categoría y no del producto individual. Se crea la entidad independiente <mark>CATEGORIA.</mark> 

   - 

- **Esquema Final en 3FN:** 

   - **CATEGORIA** (id_categoria, nombre_categoria, descripcion) 

   - **PRODUCTO** (id_producto, nombre_producto, unidad_medida, precio_actual, stock_actual, _id_categoria_ ) 

   - **CLIENTE** (id_cliente, nombre-cliente,apellido_cliente,razon_social, DNI_cliente, telefono_cliente, email_cliente) 

   - **VENDEDOR** (id_vendedor, nombre_vendedor, apellido_vendedor, DNI_vendedor , legajo,telefono_vendedor) 

   - **FORMA_PAGO** (id_forma_pago, descripcion) 

   - **VENTA** (id_venta, fecha_hora, total, _id_cliente_ , _id_vendedor_ , _id_forma_pago_ ) 

   - **DETALLE_VENTA** (id_venta, id_producto, cantidad, precio_unitario,subtotal) 
![alt text](Modelo-relacional-1.png)
