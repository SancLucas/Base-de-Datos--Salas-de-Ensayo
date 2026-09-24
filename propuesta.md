# Propuesta de Proyecto — Base de Datos

**Salas de Ensayo**

## Contexto
Un servicio en donde un cliente reserva una sala de ensayos por un tiempo estipulado, también pudiendo sumar instrumentos/equipamiento del lugar (parlantes, guitarras, baterias, etc.).

## Objetivo del sistema

Diseñar una base de datos que permita:
- Reservar la sala por turnos sin superposición de horarios.
- Llevar el inventario de instrumentos/equipos, sabiendo cuáles están disponibles, en uso o en reparación.
- Asociar cada sala y equipo usado a un responsable (cliente).
- Registrar el total de la reserva.

## Alcance

**Incluye**
- Gestión de salas y disponibilidad.
- Catálogo de instrumentos/equipos con su estado y costo (disponible / en uso / en mantenimiento).
- Reserva de salas por el cliente.
- Asociación entre la reserva de la sala y de los instrumentos.
- Registro del total de la reserva.
- Reportes de ocupación y facturación.

**No incluye**
- Grabación del ensayo.
- Publicación automática en redes/YouTube.
- Facturación electrónica.

## Entidades preliminares
|  Entidad   |
|------------|
| Cliente    |
| Sala       |
| Inventario |

## Requerimientos funcionales (borrador)
- Registrar salas con su capacidad y equipamiento.
- Registrar instrumentos/equipos con estado (disponible, en uso, en mantenimiento).
- Registrar facturación.
- Reservar una sesión validando que la sala esté libre en ese horario.
- Asociar uno o varios instrumentos a una sala.
- Consultar ocupación de salas por rango de fechas.
- Consultar qué instrumentos son más pedidos (ranking).
- Consultar facturación.

## Requerimientos no funcionales (borrador)
- El sistema debe evitar solapamiento de horarios en una misma sala.
- Debe soportar múltiples sesiones simultáneas en distintas salas.
- Los datos de pago deben mantenerse disponibles.

