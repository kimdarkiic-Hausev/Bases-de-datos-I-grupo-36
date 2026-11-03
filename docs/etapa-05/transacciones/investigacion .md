## Que son las transacciones?

Una transacción es un conjunto de operaciones SQL que se ejecutan como una única unidad lógica de trabajo. Esto significa que todas las operaciones deben completarse correctamente para que los cambios queden guardados.

Si ocurre un error durante la ejecución, se pueden deshacer todas las operaciones realizadas.

Las transacciones garantizan las propiedades ACID:

\* Atomicidad: todas las operaciones se realizan correctamente o ninguna queda registrada.

*Consistencia: la base de datos mantiene sus reglas y restricciones.

*Aislamiento: las transacciones concurrentes no deben interferir incorrectamente entre sí.

*Durabilidad: los cambios confirmados permanecen guardados.

## Por qué utilizarlas?

En el sistema de gestión del frigorífico, una venta puede involucrar varias operaciones y tablas:

VENTA: almacena la información general de la operación.

DETALLE_VENTA: registra los productos y las cantidades vendidas.

PRODUCTO: almacena los precios y el stock disponible.

Es necesario utilizar transacciones para evitar que una venta quede registrada de manera incompleta o que se modifique el stock cuando la operación no puede concretarse.

## Caso de aplicacion

Un cliente realiza una compra que incluye:

- \- 5 kg de carne vacuna.

- \- 3 kg de pollo.

- \- 2 kg de chorizo.

La operación debe:

- 1. Crear un único registro de venta.

- 2. Registrar cada producto en la tabla DETALLE_VENTA.

- 3. Calcular el total de la compra.

- 4. Verificar la disponibilidad de stock de todos los productos.


- 5. Descontar las cantidades correspondientes del stock.

Si alguno de los productos no cuenta con stock suficiente:

- \- No se registra la venta.

- \- No se registra ningún detalle.

- \- No se modifica el stock de ningún producto.

## Implementación

Para garantizar el funcionamiento de la operación se utiliza un procedimiento almacenado denominado "SP_REGISTRAR_VENTA".

Este procedimiento utiliza las siguientes instrucciones:

- \- BEGIN TRANSACTION: inicia la transacción.

- \- COMMIT TRANSACTION: confirma y guarda todos los cambios realizados.

- \- ROLLBACK TRANSACTION: deshace los cambios cuando ocurre un error.

Además, se utiliza el trigger "TR_DETALLE_VENTA_CONTROL_STOCK", que verifica automáticamente la disponibilidad de los productos y descuenta las cantidades correspondientes.

Caso Correcto:

Venta de varios productos con stock suficiente.

Resultado:

- \- Se registra una única venta.

- \- Se registran todos los productos en el detalle.

- \- Se actualiza el stock.

- \- Se ejecuta COMMIT.

Caso Incorrecto:

Venta de varios productos donde al menos uno no tiene stock suficiente.

Resultado:

- \- Se produce un error.

- \- Se ejecuta ROLLBACK.


- \- No queda ningún registro parcial.

- \- El stock de todos los productos permanece sin modificaciones.
