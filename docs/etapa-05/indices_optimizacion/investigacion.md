**¿Qué son los índices y la optimización?**

Un índice es una estructura de datos en SQL Server (organizada habitualmente como un árbol B-Tree) que se asocia a una tabla para acelerar la búsqueda y recuperación de información. Su función principal es evitar que el motor de la base de datos tenga que recorrer la tabla fila por fila (Table Scan) cuando se ejecuta una consulta.

**¿Para qué sirven?**


Los índices se utilizan para responder de forma eficiente a preguntas del negocio como:

°¿Cuáles fueron los movimientos de stock registrados en un período determinado?

°¿Cómo acelerar las consultas sobre tablas con un volumen masivo de registros históricos de faena o ventas?

°¿Cómo reducir el consumo de CPU y los costos de E/S (Entrada/Salida) en el motor de base de datos?

**Aplicación de ejemplo**


En el sistema de gestión del frigorífico, una de las tablas que más crece con el tiempo es la de movimientos de stock o historial de faena, acumulando millones de registros de fecha, cantidad y tipo de corte cárnico.

Cuando se requiere generar un informe anual de ventas o control de stock filtrado por fecha:



**Sin índice:** El motor realiza un Table Scan, leyendo página por página toda la tabla en disco, lo que genera un rendimiento muy lento.

**Con índice (Clustered Index):** El motor utiliza un índice agrupado sobre la columna de fechas, permitiendo ubicar los datos directamente mediante un Index Seek de manera inmediata.

