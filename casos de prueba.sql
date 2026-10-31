-- =====================================================
-- Casos de prueba - salas_de_ensayo_db
-- Requiere haber ejecutado antes carga_de_datos.sql
-- Orden sugerido: primero los 5 casos OK y después los 5 con ERROR.
-- Ejecutar cada sentencia por separado.
-- =====================================================
USE salas_de_ensayo_db;

-- =====================================================
-- PARTE A: CASOS QUE DEBEN FUNCIONAR
-- =====================================================

-- -----------------------------------------------------
-- OK 1: Alta de una persona y de su perfil de empleado
-- Valida: PK/UNIQUE de persona, FK de empleado,
-- legajo autoincremental y contraseña por defecto.
-- -----------------------------------------------------
INSERT INTO persona (dni, correo, nombre, telefono)
VALUES ('34567890', 'ezequiel.vega@email.com', 'Ezequiel Vega', '1199887766');

INSERT INTO empleado (dni_persona)
VALUES ('34567890');

-- Confirmación: debe devolver 1 fila con legajo asignado automáticamente (4)
SELECT p.dni, p.nombre, p.correo, e.legajo, e.contraseña
FROM persona p
JOIN empleado e ON e.dni_persona = p.dni
WHERE p.dni = '34567890';


-- -----------------------------------------------------
-- OK 2: Reserva válida en una sala libre
-- Valida: trigger de solapamiento (no hay reservas ese día en la sala 3),
-- CHECK de horarios y valor por defecto de confirmada (1).
-- -----------------------------------------------------
INSERT INTO reserva (fecha, hora_inicio, hora_fin, sala_precio_x_hora, dni_persona, nro_sala)
VALUES ('2026-11-10', '18:00:00', '20:00:00', 9000.00, '40123789', 3);

-- Confirmación: 1 fila, sala "Sala Clásica", confirmada = 1
SELECT r.nro, r.fecha, r.hora_inicio, r.hora_fin, r.confirmada,
       s.nombre AS sala, r.sala_precio_x_hora, p.nombre AS cliente
FROM reserva r
JOIN sala s ON s.nro = r.nro_sala
JOIN persona p ON p.dni = r.dni_persona
WHERE r.nro_sala = 3
ORDER BY r.nro DESC;


-- -----------------------------------------------------
-- OK 3: Misma sala y misma fecha que otra reserva, pero en horario distinto
-- Valida: el trigger solo bloquea cuando los horarios se pisan.
-- La reserva 12 ocupa la Sala Master de 18 a 20; esta va de 21 a 23.
-- -----------------------------------------------------
INSERT INTO reserva (nro, fecha, hora_inicio, hora_fin, sala_precio_x_hora, dni_persona, nro_sala)
VALUES (101, '2026-11-03', '21:00:00', '23:00:00', 15000.00, '38654321', 1);

-- Confirmación: 2 filas (la 12 de 18 a 20 y la 101 de 21 a 23)
SELECT nro, fecha, hora_inicio, hora_fin, dni_persona
FROM reserva
WHERE nro_sala = 1 AND fecha = '2026-11-03'
ORDER BY hora_inicio;


-- -----------------------------------------------------
-- OK 4: Alquiler de ítems con cantidad igual al stock (caso límite)
-- Valida: trigger de stock. MIC-03 tiene stock 2 y se piden 2:
-- el trigger solo rechaza cuando la cantidad es MAYOR al stock.
-- -----------------------------------------------------
INSERT INTO reserva_inventario (nro_reserva, id_item_inventario, precio_unit, cantidad)
VALUES (101, 'MIC-03', 1500.00, 2);

-- Confirmación: 1 fila con cantidad = stock = 2
SELECT ri.nro_reserva, i.id, i.descripcion, ri.cantidad, i.stock
FROM reserva_inventario ri
JOIN item_inventario i ON i.id = ri.id_item_inventario
WHERE ri.nro_reserva = 101;


-- -----------------------------------------------------
-- OK 5: Pago usando los valores por defecto
-- Valida: DEFAULT de fecha (hoy) y de medio_de_pago ('Efectivo'),
-- y el UNIQUE de nro_reserva (la reserva 14 todavía no tenía pago).
-- -----------------------------------------------------
INSERT INTO pago (monto, nro_reserva)
VALUES (75200.00, 14);

-- Confirmación: medio = Efectivo, fecha = hoy y monto = total_sala + total_items
SELECT r.nro AS reserva,
       ROUND(TIME_TO_SEC(TIMEDIFF(r.hora_fin, r.hora_inicio)) / 3600 * r.sala_precio_x_hora, 2) AS total_sala,
       (SELECT COALESCE(SUM(ri.cantidad * ri.precio_unit), 0)
          FROM reserva_inventario ri
         WHERE ri.nro_reserva = r.nro) AS total_items,
       p.monto, p.medio_de_pago,
       DATE_FORMAT(p.fecha, "%d/%m/%Y") AS fecha,
       (p.fecha = CURDATE()) AS fecha_es_hoy
FROM reserva r
JOIN pago p ON p.nro_reserva = r.nro
WHERE r.nro = 14;


-- =====================================================
-- PARTE B: CASOS QUE DEBEN FALLAR
-- Cada INSERT tiene que devolver el error indicado y no guardar nada.
-- =====================================================

-- -----------------------------------------------------
-- ERROR 1: Reserva que se solapa con otra (trigger)
-- La Sala Master está tomada el 2026-11-03 de 18 a 20 (reserva 12).
-- Error esperado: 1644 (45000) "Error: La sala ya se encuentra reservada en ese horario."
-- -----------------------------------------------------
INSERT INTO reserva (fecha, hora_inicio, hora_fin, sala_precio_x_hora, dni_persona, nro_sala)
VALUES ('2026-11-03', '19:00:00', '21:00:00', 15000.00, '35123456', 1);

-- Confirmación: no existe ninguna reserva que empiece a las 19:00 (solo la 12 y la 102)
SELECT nro, hora_inicio, hora_fin
FROM reserva
WHERE nro_sala = 1 AND fecha = '2026-11-03'
ORDER BY hora_inicio;


-- -----------------------------------------------------
-- ERROR 2: Cantidad de ítems mayor al stock (trigger)
-- BAT-02 tiene stock 1 y se piden 2.
-- Error esperado: 1644 (45000) "Error: La cantidad solicitada supera el stock disponible del ítem."
-- -----------------------------------------------------
INSERT INTO reserva_inventario (nro_reserva, id_item_inventario, precio_unit, cantidad)
VALUES (13, 'BAT-02', 4000.00, 2);

-- Confirmación: stock = 1 y cantidad_en_reserva_13 = 0 (no se guardó)
SELECT i.id, i.stock,
       (SELECT COALESCE(SUM(ri.cantidad), 0)
          FROM reserva_inventario ri
         WHERE ri.nro_reserva = 13 AND ri.id_item_inventario = 'BAT-02') AS cantidad_en_reserva_13
FROM item_inventario i
WHERE i.id = 'BAT-02';


-- -----------------------------------------------------
-- ERROR 3: Hora de fin anterior a la de inicio (CHECK)
-- Error esperado: 3819 "Check constraint 'chk_reserva_horarios' is violated."
-- -----------------------------------------------------
INSERT INTO reserva (fecha, hora_inicio, hora_fin, sala_precio_x_hora, dni_persona, nro_sala)
VALUES ('2026-12-01', '20:00:00', '19:00:00', 9000.00, '35123456', 3);

-- Confirmación: 0 reservas ese día
SELECT COUNT(*) AS reservas_2026_12_01
FROM reserva
WHERE fecha = '2026-12-01';


-- -----------------------------------------------------
-- ERROR 4: Correo repetido (UNIQUE)
-- juan.perez@email.com ya pertenece al DNI 35123456.
-- Error esperado: 1062 "Duplicate entry 'juan.perez@email.com' for key 'persona.correo_UNIQUE'"
-- -----------------------------------------------------
INSERT INTO persona (dni, correo, nombre, telefono)
VALUES ('45678901', 'juan.perez@email.com', 'Otro Juan', '1100000000');

-- Confirmación: solo aparece Juan Pérez; el DNI 45678901 no se creó
SELECT dni, nombre, correo
FROM persona
WHERE correo = 'juan.perez@email.com' OR dni = '45678901';


-- -----------------------------------------------------
-- ERROR 5: Control de inventario hecho por alguien que no es empleado (FK)
-- Juan Pérez (35123456) es cliente: existe en persona pero no en empleado.
-- Error esperado: 1452 "Cannot add or update a child row: a foreign key constraint fails
--                       (... CONSTRAINT `fk_dni_empleado` ...)"
-- -----------------------------------------------------
INSERT INTO control_inventario (dni_empleado, id_item_inventario, observacion)
VALUES ('35123456', 'AMP-01', 'Revisión hecha por un cliente');

-- Confirmación: es_empleado = NULL (no está en empleado) y no hay controles a su nombre
SELECT p.dni, p.nombre, e.dni_persona AS es_empleado,
       (SELECT COUNT(*) FROM control_inventario c WHERE c.dni_empleado = p.dni) AS controles
FROM persona p
LEFT JOIN empleado e ON e.dni_persona = p.dni
WHERE p.dni = '35123456';