# 🛠️ Etapa III: Implementación Física (Scripts DDL y DML)

En esta etapa se fundamenta y documenta la construcción física de la base de datos `FrigorificoDB` en el motor **SQL Server**.

### Contenido
* **Script DDL (Data Definition Language):** Creación de tablas, selección de tipos de datos (`VARCHAR`, `DECIMAL`, `DATETIME`), restricciones de integridad (`NOT NULL`, `UNIQUE`, `CHECK`), claves foráneas con reglas de borrado/actualización y definición de columnas calculadas persistidas (`PERSISTED`).
* **Lógica de Control de Inventario:** Implementación del trigger `TR_DETALLE_VENTA_CONTROL_STOCK` para la validación y descuento automático de stock en tiempo real.
* **Script DML (Data Manipulation Language):** Estrategia y orden secuencial de carga de datos de prueba coherentes por tabla para resguardar la integridad referencial.
