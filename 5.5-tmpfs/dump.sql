CREATE DATABASE IF NOT EXISTS test;
USE test;

CREATE TABLE IF NOT EXISTS posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    contenido TEXT,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO posts (titulo, contenido) VALUES
('Primer post', 'Contenido del primer post de prueba'),
('Segundo post', 'Contenido del segundo post de prueba'),
('Tercer post', 'Contenido del tercer post de prueba'),
('Cuarto post', 'Contenido del cuarto post de prueba'),
('Quinto post', 'Contenido del quinto post de prueba');
