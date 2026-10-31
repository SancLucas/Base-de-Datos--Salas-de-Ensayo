-- =====================================================
-- Pensado para ejecutarse sobre las tablas VACÍAS.
-- Los datos respetan los CHECK, las FK y los dos triggers
-- (solapamiento de reservas y validación de stock).
-- =====================================================
USE salas_de_ensayo_db;

-- Cargar personas base (clientes y empleados)
INSERT INTO persona (dni, correo, nombre, telefono) VALUES 
('35123456', 'juan.perez@email.com', 'Juan Pérez', '1155443322'),
('28987654', 'maria.gomez@email.com', 'María Gómez', '1166778899'),
('30456789', 'lucas.fernandez@email.com', 'Lucas Fernández', '1144556677'),
('33789012', 'camila.rodriguez@email.com', 'Camila Rodríguez', '1133221100'),
('36234567', 'martin.lopez@email.com', 'Martín López', '1155667788'),
('40123789', 'sofia.martinez@email.com', 'Sofía Martínez', '1122334455'),
('38654321', 'agustin.diaz@email.com', 'Agustín Díaz', '1166001122'),
('41234567', 'valentina.sosa@email.com', 'Valentina Sosa', '1177889900'),
('29567890', 'pablo.herrera@email.com', 'Pablo Herrera', '1133445566'),
('39012345', 'julieta.navarro@email.com', 'Julieta Navarro', '1188776655'),
('27345678', 'diego.romero@email.com', 'Diego Romero', '1144001122'),
('31876543', 'laura.acosta@email.com', 'Laura Acosta', '1155990011');

-- Cargar empleado (debe existir previamente en persona)
INSERT INTO empleado (dni_persona, contraseña) VALUES 
('28987654', 'ar-09/'),
('27345678', 'Contr_'),
('31876543', 'Hola-mundo/');

-- Cargar salas de ensayo
INSERT INTO sala (nombre, capacidad, habilitada, precio_x_hora) VALUES 
('Sala Master', 9, 1, 15000.00),
('Sala Clásica', 4, 1, 80000.00),
('Sala Mediana', 7, 0, 11000.00),
('Sala Grande', 11, 1, 22000.00),
('Tostada', 2, 0, 7000.00);

-- Cargar categorías de inventario
INSERT INTO categoria (descripcion, id_categoria_padre) VALUES 
('Amplificadores', NULL),
('Micrófonos', NULL),
('Instrumentos de cuerda', NULL),
('Percusión', NULL),
('Accesorios', NULL),
('Amplificadores de guitarra', 1),
('Amplificadores de bajo', 1),
('Micrófonos dinámicos', 2),
('Micrófonos de condensador', 2),
('Pedales de efectos', 5),
('Baterías', 4);

-- Cargar fabricantes
INSERT INTO fabricante (nombre) VALUES 
('Marshall'),
('Shure'),
('Fender'),
('Yamaha'),
('Pearl'),
('Boss'),
('Audio-Technica');

-- Cargar ítems de inventario
INSERT INTO item_inventario (id, stock, descripcion, costo_alquiler, id_categoria, id_fabricante) VALUES 
('AMP-01', 3, 'Amplificador de guitarra Marshall JCM900', 3000.00, 1, 1),
('MIC-01', 5, 'Micrófono dinámico Shure SM58', 1000.00, 2, 2),
('AMP-02', 2, 'Amplificador de bajo Fender Rumble 100', 2500.00, 7, 3),
('AMP-03', 2, 'Amplificador de guitarra Fender Twin Reverb', 3500.00, 6, 3),
('MIC-02', 4, 'Micrófono dinámico Shure SM57', 900.00, 8, 2),
('MIC-03', 2, 'Micrófono de condensador Audio-Technica AT2020', 1500.00, 9, 7),
('GTR-01', 3, 'Guitarra eléctrica Fender Stratocaster', 2500.00, 3, 3),
('BAJ-01', 2, 'Bajo eléctrico Fender Precision Bass', 2500.00, 3, 3),
('BAT-01', 2, 'Batería acústica Yamaha Stage Custom', 4000.00, 11, 4),
('BAT-02', 1, 'Batería acústica Pearl Export', 4000.00, 11, 5),
('PED-01', 6, 'Pedal de distorsión Boss DS-1', 600.00, 10, 6),
('PED-02', 4, 'Pedal de delay Boss DD-8', 800.00, 10, 6);

-- =====================================================
-- RESERVAS
-- sala_precio_x_hora copia el precio de la sala al momento de reservar.
-- Ninguna reserva confirmada se pisa ni queda pegada a otra en la misma sala y fecha.
-- La reserva 6 está cancelada (confirmada = 0) y su horario se
-- vuelve a reservar en la 7: por eso va antes en el orden.
-- =====================================================
INSERT INTO reserva (fecha, hora_inicio, hora_fin, confirmada, sala_precio_x_hora, dni_persona, nro_sala) VALUES
('2026-10-05', '18:00:00', '20:00:00', 1, 15000.00, '35123456', 1),
('2026-10-05', '19:00:00', '21:00:00', 1, 12000.00, '30456789', 2),
('2026-10-08', '16:00:00', '19:00:00', 1,  9000.00, '33789012', 3),
('2026-10-10', '20:00:00', '22:00:00', 1, 22000.00, '36234567', 4),
('2026-10-12', '14:00:00', '16:00:00', 1, 15000.00, '40123789', 1),
('2026-10-12', '18:00:00', '21:00:00', 0, 15000.00, '38654321', 1),
('2026-10-12', '18:00:00', '21:00:00', 1, 15000.00, '41234567', 1),
('2026-10-17', '17:00:00', '19:00:00', 1, 12000.00, '29567890', 2),
('2026-10-20', '19:00:00', '22:00:00', 1,  9000.00, '35123456', 3),
('2026-10-24', '15:00:00', '18:00:00', 1, 22000.00, '39012345', 4),
('2026-10-28', '18:00:00', '20:00:00', 1, 15000.00, '30456789', 1),
('2026-11-03', '18:00:00', '20:00:00', 1, 15000.00, '33789012', 1),
('2026-11-05', '20:00:00', '22:00:00', 1, 12000.00, '36234567', 2),
('2026-11-07', '16:00:00', '19:00:00', 1, 22000.00, '35123456', 4);

-- =====================================================
-- ÍTEMS ALQUILADOS POR RESERVA
-- precio_unit copia el costo_alquiler del ítem al momento de alquilar.
-- Todas las cantidades respetan el stock (trigger de stock).
-- =====================================================
INSERT INTO reserva_inventario (nro_reserva, id_item_inventario, precio_unit, cantidad) VALUES
(1,  'AMP-01', 3000.00, 1),
(1,  'MIC-01', 1000.00, 2),
(2,  'AMP-01', 3000.00, 1),
(2,  'MIC-01', 1000.00, 2),
(3,  'GTR-01', 2500.00, 1),
(3,  'PED-01',  600.00, 2),
(4,  'BAT-01', 4000.00, 1),
(4,  'MIC-02',  900.00, 4),
(7,  'AMP-03', 3500.00, 1),
(7,  'MIC-03', 1500.00, 1),
(7,  'PED-02',  800.00, 1),
(8,  'AMP-02', 2500.00, 1),
(8,  'BAJ-01', 2500.00, 1),
(9,  'AMP-01', 3000.00, 1),
(9,  'MIC-01', 1000.00, 1),
(10, 'BAT-02', 4000.00, 1),
(10, 'AMP-03', 3500.00, 2),
(10, 'MIC-02',  900.00, 2),
(12, 'AMP-01', 3000.00, 2),
(12, 'MIC-01', 1000.00, 3),
(13, 'PED-01',  600.00, 2),
(13, 'PED-02',  800.00, 1),
(14, 'BAT-01', 4000.00, 1),
(14, 'MIC-02',  900.00, 3),
(14, 'AMP-02', 2500.00, 1);

-- =====================================================
-- PAGOS (una sola fila por reserva, por el UNIQUE en nro_reserva)
-- monto = horas x precio de la sala + suma de cantidad x precio_unit
-- Sin pago: la 6 (cancelada) y las futuras 13 y 14 (pendientes).
-- =====================================================
INSERT INTO pago (fecha, monto, medio_de_pago, nro_reserva) VALUES
('2026-10-05', 35000.00, 'Efectivo',      1),
('2026-10-04', 29000.00, 'Transferencia', 2),
('2026-10-08', 30700.00, 'Débito',        3),
('2026-10-09', 51600.00, 'Credito',       4),
('2026-10-12', 30000.00, 'Efectivo',      5),
('2026-10-12', 50800.00, 'Transferencia', 7),
('2026-10-17', 29000.00, 'Efectivo',      8),
('2026-10-20', 31000.00, 'Débito',        9),
('2026-10-23', 78800.00, 'Credito',      10),
('2026-10-28', 30000.00, 'Transferencia',11),
('2026-10-30', 39000.00, 'Transferencia',12);

-- Controles de inventario
INSERT INTO control_inventario (dni_empleado, id_item_inventario, fecha, observacion) VALUES
('28987654', 'AMP-01', '2026-10-01', 'Revisión general: funciona correctamente'),
('28987654', 'MIC-01', '2026-10-01', 'Cables en buen estado'),
('27345678', 'AMP-02', '2026-10-02', 'Perilla de volumen floja, ajustada'),
('27345678', 'MIC-02', '2026-10-02', NULL),
('31876543', 'BAT-01', '2026-10-15', 'Parche del tom reemplazado'),
('31876543', 'BAT-02', '2026-10-15', 'Platillo con fisura leve, a monitorear'),
('28987654', 'AMP-03', '2026-10-20', 'Válvulas revisadas'),
('27345678', 'GTR-01', '2026-10-26', 'Cuerdas nuevas'),
('31876543', 'PED-02', '2026-10-29', 'Sin observaciones');


-- ==========================
-- PRUEBAS DE LOS TRIGGERS ==
-- ==========================

-- 1) Solapamiento: la Sala Master ya está reservada el 2026-11-03 de 18 a 20
-- INSERT INTO reserva (fecha, hora_inicio, hora_fin, confirmada, sala_precio_x_hora, dni_persona, nro_sala)
-- VALUES ('2026-11-03', '19:00:00', '21:00:00', 1, 15000.00, '35123456', 1);

-- 2) Stock: solo hay 1 batería Pearl (BAT-02) y se piden 2
-- INSERT INTO reserva_inventario (nro_reserva, id_item_inventario, precio_unit, cantidad)
-- VALUES (13, 'BAT-02', 4000.00, 2);