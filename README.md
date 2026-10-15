# Bases-de-datos-1-grupo-36(Proyecto-Grupal)
Sistema de Gestión de Ventas y Control de Stock: Frigorífico y Carnicería Industrial
Proyecto integrador de Bases de Datos I (año lectivo 2026), Grupo 36.

Base de datos relacional en SQL Server que soporta el ciclo completo de venta de un frigorífico con canal minorista (mostrador) y mayorista (restaurantes, carnicerías, supermercados): productos vendidos por kilo o por unidad, control de stock automático y precios históricos por venta.

Integrantes
Franco, Sebastián Mariano
Garay, Lucía Valentina
Gonzales, Milagros Esperanza
Ibalo Pereyra, Agustina Beatriz
Romero, Julieta Estefanía

Estructura del repositorio
docs/
  etapa-01/   Requerimientos, alcance y reglas de negocio
  etapa-02/   DER, modelo relacional y normalización (3FN)
  etapa-03/   Informe de implementación (DDL + DML)
  etapa-04/   Consultas SQL y casos de uso
  etapa-05/   Temas técnicos (procedimientos, funciones, transacciones, triggers, seguridad, índices)
sql/
  ddl/        Creación de la base FrigorificoDB y sus tablas
  dml/        Carga de datos de prueba por tabla
  consultas/  Consultas de la etapa IV
  tecnico/    Scripts de la etapa V

Modelo de datos

Tablas principales: CATEGORIA, PRODUCTO, CLIENTE, VENDEDOR, FORMA_PAGO, VENTA, DETALLE_VENTA.

DER

Decisiones de diseño destacadas:
Precio congelado por venta: DETALLE_VENTA.precio_unitario guarda el precio del momento, así los aumentos en PRODUCTO.precio_actual no alteran el historial.
Control de stock por trigger: TR_DETALLE_VENTA_CONTROL_STOCK rechaza la venta si no hay stock suficiente y, si lo hay, descuenta la cantidad vendida.
Unidades de medida restringidas con CHECK (kilogramos o unidades).
El detalle completo está en docs/etapa-02 y docs/etapa-03.

Cómo ejecutarlo
Requisitos: SQL Server y SQL Server Management Studio (o Azure Data Studio).

Ejecutar sql/ddl/DDL_Frigorifico.sql, que crea la base FrigorificoDB y todas las tablas.
Ejecutar los scripts de sql/dml/ en este orden, para respetar las claves foráneas: categoria → producto → cliente → vendedor → forma_pago → venta → detalle_venta.
Ejecutar las consultas de sql/consultas/.
