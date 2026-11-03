## ¿Que es un trigger?

Un trigger es un objeto de base de datos en sql server que se utiliza para la automatización de acciones en respuesta a ciertos eventos (inserciones-INSERT, actualizaciones-UPDATE y eliminaciones de datos de una tabla-DELETE)

Los triggers cuentan con distintos propósitos pero uno de los principales es la auditoria y la trazabilidad que permite registrar información cada vez que se realiza un cambio en lo datos (quien lo realizo, cuando lo realizo, etc)

## ¿Para que sirven?

Los trigger se usan para responder a preguntas como:

¿Quién realizo la actualizacion?

¿Cuándo lo hizo?

¿Cómo se veía el dato antes del cambio?

## Aplicación ejemplo

Un caso de aplicación puede ser de un usuario que quiere cambiar el precio de un producto

Tabla principal

Tabla de auditoria

En este caso lo que se registraría es la fecha y hora, usuario, producto afectado, precio anterior, precio nuevo y el tipo de operación

## Ejemplo practico

antes

| producto | Precio |
| --- | --- |
| Cuaderno | 12000 |

## actualizacion

- 1 UPDATE producto

- 2 SET precio = 15000

- 3 WHERE producto_id = 1


Registro generado

| Fecha | Producto | Precio anterior | Precio nuevo |
| --- | --- | --- | --- |
| 03/11/2026 | Cuaderno | 12000 | 15000 |

En base a esto se entiende que una forma de demostrar la funcionalidad es realizando un cambio en alguno de los datos, después ver la tabla de auditoria y por ultimo verificar si el cambio se efectuo exitosamente
