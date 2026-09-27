# Especificaciones Técnicas Previas — Base de Datos

**Proyecto:** Sistema de Reservas para Salas de Ensayo
**Motor de Base de Datos:** MySQL 8.x
**Tipo de Base de Datos:** Relacional

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
