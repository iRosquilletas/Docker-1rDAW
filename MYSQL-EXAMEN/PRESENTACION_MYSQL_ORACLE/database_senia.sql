CREATE DATABASE IES_La_SENIA;
USE IES_La_SENIA;
CREATE TABLE asignaturas (
    id_asignatura INT AUTO_INCREMENT PRIMARY KEY,
    nombre varchar(100),
	descripcion text
);

CREATE TABLE 1ro_de_DAW (
    IdPrincipal  int AUTO_INCREMENT PRIMARY key,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) not null,
    dni VARCHAR(10) not null
);
CREATE TABLE profesores (
    id_profesor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    asignatura_id INT,
    FOREIGN KEY (asignatura_id) references asignaturas(id_asignatura)
);
INSERT INTO 1ro_de_DAW (nombre, apellido, dni)
VALUES
    ('Maximo', 'Escarti', '12345678A'),
    ('Alvaro', 'PardoEscarti', '87654321B'),
    ('Sergi', 'Escarti', '98765432C');
    
INSERT INTO asignaturas (nombre, descripcion)
VALUES
    ('Matemáticas', 'Sumas y Restas'),
    ('Bases de datos', "Java"),
    ("Programación", 'Selects');



INSERT INTO profesores (nombre, apellido, asignatura_id)
VALUES
    ('Visent', 'Escarti', 1),
    ('Cristian', 'Escarti', 2),
    ('Antonio', 'Calabuig', 3);