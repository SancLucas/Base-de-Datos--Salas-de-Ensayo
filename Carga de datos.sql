USE salas_de_ensayo_db;

-- Cargar personas base (clientes y empleados)
INSERT INTO persona (dni, correo, nombre, telefono) VALUES 
('35123456', 'juan.perez@email.com', 'Juan Pérez', '1155443322'),
('28987654', 'maria.gomez@email.com', 'María Gómez', '1166778899');

-- Cargar empleado (debe existir previamente en persona)
INSERT INTO empleado (dni_persona, contraseña) VALUES 
('28987654', 'ar-09/');

-- Cargar salas de ensayo
INSERT INTO sala (nombre, capacidad, habilitada, precio_x_hora) VALUES 
('Sala Master', 5, 1, 15000.00),
('Sala Deluxe', 4, 1, 12000.00);

-- Cargar categorías de inventario
INSERT INTO categoria (descripcion, id_categoria_padre) VALUES 
('Amplificadores', NULL),
('Micrófonos', NULL);

-- Cargar fabricantes
INSERT INTO fabricante (nombre) VALUES 
('Marshall'),
('Shure');

-- Cargar ítems de inventario
INSERT INTO item_inventario (id, stock, descripcion, costo_alquiler, id_categoria, id_fabricante) VALUES 
('AMP-01', 3, 'Amplificador de guitarra Marshall JCM900', 3000.00, 1, 1),
('MIC-01', 5, 'Micrófono dinámico Shure SM58', 1000.00, 2, 2);