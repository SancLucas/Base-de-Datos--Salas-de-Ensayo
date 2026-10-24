USE salas_de_ensayo_db;
-- 10.1 Casos de prueba

-- carga de la reserva.
INSERT INTO reserva (fecha, hora_inicio, hora_fin, confirmada, sala_precio_x_hora, dni_persona, nro_sala)
VALUES ('2026-11-10', '18:00:00', '20:00:00', 1, 15000.00, '35123456', 1);

-- registro de los materiales en inventario disponibles.
INSERT INTO reserva_inventario (nro_reserva, id_item_inventario, precio_unit, cantidad)
VALUES (1, 'AMP-01', 3000.00, 1),
       (1, 'MIC-01', 1000.00, 2);

-- comprobación.
SELECT r.nro AS nro_reserva, r.fecha, r.hora_inicio, r.hora_fin, s.nombre AS sala,
       i.id AS id_item, i.descripcion AS item, ri.cantidad, ri.precio_unit
FROM reserva r
JOIN sala s ON r.nro_sala = s.nro
JOIN reserva_inventario ri ON r.nro = ri.nro_reserva
JOIN item_inventario i ON ri.id_item_inventario = i.id
WHERE r.nro = 1;

-- -----
-- -----

-- 1. Registrar la primera reserva. (Exitosa)
INSERT INTO reserva (fecha, hora_inicio, hora_fin, confirmada, sala_precio_x_hora, dni_persona, nro_sala)
VALUES ('2026-11-01', '14:00:00', '16:00:00', 1, 15000.00, '35123456', 1);

-- 2. Intentar solapar reserva en el mismo horario. (debe fallar por el Trigger)
INSERT INTO reserva (fecha, hora_inicio, hora_fin, confirmada, sala_precio_x_hora, dni_persona, nro_sala)
VALUES ('2026-11-01', '15:00:00', '17:00:00', 1, 15000.00, '35123456', 1);

-- comprobación.
SELECT nro, fecha, hora_inicio, hora_fin, nro_sala, confirmada
FROM reserva
WHERE nro_sala = 1 AND fecha = '2026-11-01';

-- -----
-- -----

-- Registrar el pago para la reserva nro 1
INSERT INTO pago (fecha, monto, medio_de_pago, nro_reserva)
VALUES (CURRENT_DATE(), 30000.00, 'Transferencia', 1);

-- comprobación.
SELECT p.id AS id_pago, p.fecha, p.monto, p.medio_de_pago, r.nro AS nro_reserva, r.dni_persona
FROM pago p
JOIN reserva r ON p.nro_reserva = r.nro;

-- -----
-- -----

-- Registrar un control de inventario por parte del empleado
INSERT INTO control_inventario (dni_empleado, id_item_inventario, fecha, observacion) 
VALUES ('28987654', 'AMP-01', CURRENT_DATE(), 'Revisión periódica: Estado óptimo, sin daños visibles.');

SELECT c.nro, c.dni_empleado, p.nombre AS empleado, c.id_item_inventario, i.descripcion AS item, c.fecha, c.observacion
FROM control_inventario c
JOIN empleado e ON c.dni_empleado = e.dni_persona
JOIN persona p ON e.dni_persona = p.dni
JOIN item_inventario i ON c.id_item_inventario = i.id;

-- -----
-- -----

-- Suponiendo que el ítem 'AMP-01' tiene un stock de 3 unidades,
-- intentamos reservar una cantidad mayor (por ejemplo, 5 unidades).
INSERT INTO reserva_inventario (nro_reserva, id_item_inventario, precio_unit, cantidad)
VALUES (1, 'AMP-01', 3000.00, 5);