# Seguridad en Base de Datos (Roles y Permisos)

### Que es la seguridad en bases de datos?
La seguridad en bases de datos es el conjunto de mecanismos, politicas y controles en SQL Server que permiten controlar y restringir que usuarios pueden acceder a la informacion y que operaciones especificas pueden realizar sobre los objetos de la base de datos. Se basa fundamentalmente en el principio de minimo privilegio, otorgando a cada usuario o rol unicamente los permisos estrictamente necesarios para cumplir su funcion operativa.

### Para que sirve?
Los roles y permisos se utilizan para responder a necesidades criticas de control y proteccion como:
* Quien tiene autorizacion para consultar datos sensibles del sistema (como el catalogo de productos y precios)?
* Como evitar modificaciones accidentales o no autorizadas directamente sobre las tablas principales de stock y ventas?
* Como permitir que un rol operativo ejecute procedimientos almacenados del negocio (como registrar una venta) sin darle acceso libre para alterar tablas por su cuenta?

### Aplicacion ejemplo
Un caso tipico en el sistema de ventas del frigorifico involucra a un rol comercial (`rol_vendedor`) y a los procedimientos de negocio:
* **Objetos protegidos:** La tabla `PRODUCTO` y el procedimiento almacenado de ventas (por ejemplo, `sp_RegistrarVentaCompleta`).
* **Propuesta de seguridad:** El vendedor puede consultar los productos (para ver precios y stock disponible) y ejecutar el procedimiento almacenado de ventas, pero tiene denegado explicitamente cualquier permiso de insercion, actualizacion o eliminacion directa (`INSERT`, `UPDATE`, `DELETE`) sobre las tablas base.

### Ejemplo practico

* **Antes (Configuracion inicial):**
  * Rol creado: `rol_vendedor`
  * Permisos otorgados al rol: `SELECT` sobre `PRODUCTO` y `EXECUTE` sobre el procedimiento de ventas.
  * Restriccion aplicada: `DENY` en operaciones directas (`UPDATE` / `INSERT`) sobre las tablas.

* **Actualizacion / Intento de operacion:**
  1. El usuario con el rol asignado (`usr_vendedor`) intenta modificar el stock directamente mediante una sentencia SQL:
     ```sql
     UPDATE PRODUCTO SET stock_actual = 50 WHERE id_producto = 1;
     ```
  2. El motor de SQL Server evalua los permisos vigentes para el rol y detecta la restriccion explicita.

* **Resultado generado:**
  * Al intentar el `UPDATE` directo, SQL Server rechaza la operacion automaticamente por falta de privilegios (arrojando un error de acceso denegado).
  * En cambio, si el usuario realiza la operacion a traves del procedimiento autorizado (`EXEC dbo.sp_RegistrarVentaCompleta`), la transaccion se efectua de manera correcta y controlada.

En base a esto, se entiende que una forma de demostrar la funcionalidad de seguridad es simulando los contextos de usuario (por ejemplo, utilizando `EXECUTE AS USER`), verificando que las consultas y ejecuciones permitidas respondan con exito, y comprobando que los intentos de alteracion directa de los datos sean bloqueados de forma segura por el motor.
