# Propuesta: ‘Púa de Rosa’ — Gestión de salas de ensayo

**Versión:** alpha · **Equipo:** Farias Isaac José y Sanchez Fugaretta Lucas
**Materia:** Estructura y Base de Datos · UTN – INSPT (Comisión 2.602)

---

## El problema

Hoy las reservas, las salas y el inventario (instrumentos, amplificadores, cableado) se anotan en notas y papeles. Eso genera desorden, riesgo de perder información y, sobre todo, la posibilidad de **reservar dos veces la misma sala en el mismo horario**.

## La propuesta

Una **base de datos central** donde queda todo registrado y ordenado: clientes, empleados, salas, equipos, reservas, pagos y controles. El sistema cuida por sí mismo las reglas más importantes, sin depender de que alguien se acuerde de revisarlas.

## Qué va a poder hacer el local

- **Reservar salas** con día y horario, sin superposiciones.
- **Sumar equipos a una reserva** (amplificadores, micrófonos, baterías, pedales), con control de cantidad disponible.
- **Registrar el pago** de cada reserva: fecha, monto y medio (efectivo, transferencia, crédito o débito).
- **Llevar el inventario** ordenado por categorías y marcas, con su stock y su costo de alquiler.
- **Registrar los controles** que hacen los empleados sobre cada equipo, con fecha y observaciones.
- **Consultar información útil:** qué salas están más ocupadas, cuánto se cobró por sala, qué equipos se alquilan más y qué reservas todavía no se pagaron.

## Cómo funciona, en simple

1. Un **cliente** queda registrado con sus datos de contacto.
2. Hace una **reserva** de una sala para un día y horario.
3. Si lo necesita, **agrega equipos** a esa reserva.
4. Se registra el **pago**.
5. Los **empleados** controlan el estado de los equipos cada tanto y dejan constancia.

## Qué cuida el sistema automáticamente

| Situación | Qué hace el sistema |
|---|---|
| Se intenta reservar una sala ya ocupada en ese horario | La reserva se rechaza |
| Se piden más unidades de un equipo que las que existen | El pedido se rechaza |
| Datos incorrectos (horario de fin anterior al de inicio, montos negativos, medio de pago inexistente) | No se guardan |
| Un correo repetido o un empleado inexistente | Se rechaza |
| El precio de una sala o equipo cambia más adelante | Las reservas ya hechas conservan el precio que tenían |

## Alcance

| Incluye | No incluye |
|---|---|
| Salas y disponibilidad horaria | Facturación electrónica |
| Inventario con categorías y marcas | Grabación del ensayo o post-producción |
| Reservas de clientes | Streaming en vivo de la sesión |
| Equipos asociados a cada reserva | Publicación en redes sociales |
| Pagos y medio de pago | Cobro en línea (pasarelas de pago) |
| Controles de inventario por empleados | Aplicación o pantallas para usuarios |
| Registro de clientes y empleados | |

> Esta etapa entrega la **base de datos**: la estructura y las reglas. Las pantallas o la aplicación para usarla quedan fuera del alcance actual.

## Cómo lo probamos

- Se cargó un **conjunto de datos de ejemplo**: 12 personas, 5 salas, 12 equipos, 14 reservas y 11 pagos.
- Se armaron **10 pruebas**: 5 que deben funcionar y 5 que el sistema debe rechazar.
- Se escribieron **10 consultas** para responder las preguntas del negocio (ocupación, ingresos, equipos más alquilados, reservas sin pago, entre otras).

## Próximas mejoras

- Permitir **reservas consecutivas** (hoy, si una reserva empieza justo cuando termina otra, se considera superpuesta).
- Controlar la disponibilidad de los equipos **por horario**, y no solo contra el total que existe.
- Impedir reservas en **salas deshabilitadas**.
- Reforzar la **seguridad de las contraseñas** de los empleados.
- Agregar **reportes listos para consultar** (ocupación, ingresos).

---

*Detalle completo en `Especificaciones_Tecnicas_Previas.docx`.*
