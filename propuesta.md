# Especificaciones Técnicas Previas — Base de Datos

*Proyecto de Base de Datos — MySQL 8.x*

**Materia:** Estructura y Base de Datos
**Docente:** Ing. Alejandro Jorge Behringer
**Auxiliar docente:** Juan Carlos Capia

---

## 1. Identificación del Proyecto

- **Nombre del proyecto:** base de datos para estudio
- **Versión:** beta
- **Fecha:** 31/08/26
- **Autor / Equipo:** Lucas Sanchez Fugaretta, Matias Cavalletto Ciancio, Isaac Farias
- **Motor de Base de Datos:** MySQL 8.x (MySQL Workbench)
- **Tipo de Base de Datos:** Relacional

---

## 2. Descripción de la Necesidad del Usuario

### 2.1 Contexto general

Un servicio en el que un cliente reserva una sala de ensayos por un tiempo estipulado, pudiendo además sumar instrumentos y equipamiento del lugar (parlantes, guitarras, baterías, etc.).

Actualmente existe una falta de solidez en la información dentro de la empresa: hay muchos instrumentos, equipos de audio y salas que no se organizan de forma centralizada, y no se cuenta con un sistema que coordine todo. El dueño del lugar registra la información de manera informal (notas sueltas, mensajes al grupo de trabajo), lo que genera desorden y riesgo de superposición de horarios o de reservar equipos que ya están en uso.

### 2.2 Objetivo del sistema

Diseñar una base de datos que resuelva la falta de centralización en la información, permitiendo:

- Reservar la sala por turnos, sin superposición de horarios.
- Llevar el inventario de instrumentos/equipos, sabiendo cuáles están disponibles, en uso o en reparación.
- Asociar cada sala y equipo usado a un responsable (cliente).
- Registrar el total de cada reserva.

### 2.3 Alcance del sistema

| **Incluye** | **No incluye** |
|---|---|
| Gestión de salas y disponibilidad horaria. | Grabación del ensayo, ni su edición o mezcla (post-producción, fuera del sistema). |
| Catálogo de instrumentos/equipos con su estado (disponible / en uso / en mantenimiento) y costo. | Publicación automática en redes sociales/YouTube. |
| Reserva de salas por el cliente, validando que la sala esté libre en ese horario. | Facturación electrónica / AFIP (queda como registro interno de pagos). |
| Asociación entre la reserva de la sala y uno o varios instrumentos/equipos. | Streaming en vivo de la sesión. |
| Registro del total y facturación de cada reserva. | |
| Reportes de ocupación y facturación. | |

---

## 3. Relevamiento de Requerimientos

### 3.1 Requerimientos funcionales

| **N°** | **Requerimiento funcional** |
|---|---|
| RF-01 | Registrar salas, indicando su capacidad y equipamiento. |
| RF-02 | Registrar instrumentos/equipos con su estado (disponible, en uso, en mantenimiento). |
| RF-03 | Reservar una sesión, validando que la sala esté libre en ese horario. |
| RF-04 | Asociar uno o varios instrumentos/equipos a una sala reservada. |
| RF-05 | Registrar la facturación de cada reserva. |
| RF-06 | Consultar la ocupación de salas por rango de fechas. |
| RF-07 | Consultar qué instrumentos/equipos son más pedidos (ranking). |
| RF-08 | Consultar la facturación registrada. |

### 3.2 Requerimientos no funcionales

| **N°** | **Requerimiento no funcional** |
|---|---|
| RNF-01 | El sistema debe evitar el solapamiento de horarios en una misma sala. |
| RNF-02 | El sistema debe soportar múltiples sesiones simultáneas en distintas salas. |
| RNF-03 | Los datos de pago deben mantenerse disponibles e íntegros. |

---

## 4. Identificación de Entidades y Atributos

> **Guía:** el detalle completo de entidades y atributos se documenta en el Anexo A — Diccionario de Datos (hojas "1. Entidades" y "2. Atributos"). Acá va el listado preliminar y una síntesis.

### 4.1 Listado preliminar de entidades

| **N°** | **Entidad** | **Tipo (Fuerte/Débil)** | **Descripción breve** |
|---|---|---|---|
| | | | |
| | | | |
| | | | |
| | | | |

### 4.2 Referencia

*(Ver Anexo A — Diccionario de Datos, hoja "2. Atributos" para el detalle de tipo de dato, tamaño, nulabilidad y dominio de cada atributo.)*

---

## 5. Definición de Claves

### 5.1 Claves primarias

> **Guía:** indicar, por entidad, la clave primaria elegida y justificar por qué (natural vs. sustituta/surrogate).

| **Entidad** | **Clave primaria (PK)** | **Justificación** |
|---|---|---|
| | | |
| | | |
| | | |
| | | |
| | | |

### 5.2 Claves foráneas y relaciones

> **Guía:** el detalle completo de FK, tabla referenciada y reglas ON DELETE/ON UPDATE se documenta en el Anexo A, hoja "4. Claves y Restricciones".

| **Tabla** | **Clave foránea (FK)** | **Tabla referenciada** | **ON DELETE / ON UPDATE** |
|---|---|---|---|
| | | | |
| | | | |
| | | | |
| | | | |
| | | | |

---

## 6. Modelo Conceptual

> **Guía:** insertar aquí el Diagrama Entidad-Relación (DER) completo: entidades, atributos, claves, relaciones y cardinalidades. Puede pegarse como imagen (captura de draw.io, MySQL Workbench, Lucidchart, etc.).

*[ Espacio reservado para pegar el DER — imagen o captura ]*

---

## 7. Modelo Lógico

> **Guía:** transformar el DER en tablas: por cada entidad fuerte y débil, indicar el nombre de tabla resultante y cómo se resolvió cada relación (FK, tabla intermedia N:M, herencia).

| **Entidad / Relación del DER** | **Tabla resultante** | **Cómo se resolvió (FK / tabla intermedia / herencia)** |
|---|---|---|
| | | |
| | | |
| | | |
| | | |
| | | |

---

## 8. Normalización

> **Guía:** analizar cada tabla del modelo lógico contra 1FN, 2FN y 3FN. El detalle tabla por tabla se completa en el Anexo A, hoja "5. Normalización". Acá va la conclusión general.

**Resumen del análisis de normalización:**

*(completar)*

---

## 9. Modelo Físico — MySQL

### 9.1 Tipos de datos y restricciones

> **Guía:** confirmar en el Anexo A (hojas 2 y 4) que cada atributo tiene tipo de dato MySQL válido y sus restricciones (PK, FK, UNIQUE, NOT NULL, CHECK, DEFAULT).

**Notas:**

*(completar)*

### 9.2 Script SQL de creación

> **Guía:** pegar el script DDL completo (CREATE DATABASE, CREATE TABLE con todas las restricciones). Usar fuente monoespaciada, palabras clave en MAYÚSCULAS, JOIN explícito, sin SELECT *.

```sql
-- CREATE DATABASE nombre_bd;

-- USE nombre_bd;

-- CREATE TABLE ...
```

---

## 10. Validación del Modelo

### 10.1 Casos de prueba

> **Guía:** definir escenarios de prueba (altas, bajas, restricciones que deben fallar) para verificar que el modelo se comporta como se espera.

| **N°** | **Caso de prueba** | **Resultado esperado** | **Resultado obtenido** |
|---|---|---|---|
| | | | |
| | | | |
| | | | |

### 10.2 Consultas SQL de validación

> **Guía:** el detalle completo de las consultas (SELECT, JOIN, GROUP BY/HAVING, subconsultas) se documenta en el Anexo A, hoja "6. Diccionario de Consultas".

*(completar)*

---

## 11. Conclusión Técnica

> **Guía:** resumir el diseño final, cómo se cumplieron los requerimientos relevados en la Sección 3, y qué mejoras futuras podría tener el modelo.

**Respuesta:**

*(completar)*
