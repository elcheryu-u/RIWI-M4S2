-- Paso 1: Crear base de datos
CREATE DATABASE IF NOT EXISTS gestion_academica_universidad_sergio_cortes CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE gestion_academica_universidad_sergio_cortes;

-- Forzar codificación correcta para el cliente
SET NAMES utf8mb4;

-- Paso 2: Crear tablas
CREATE TABLE departamentos_academicos (
	id_departamento_academico INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	departamento_academico VARCHAR(50) NOT NULL,
	PRIMARY KEY(id_departamento_academico)
);

CREATE TABLE generos (
	id_genero INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	genero VARCHAR(50) NOT NULL,
	PRIMARY KEY(id_genero)
);

CREATE TABLE carreras (
	id_carrera INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	carrera VARCHAR(50) NOT NULL,
	id_departamento INTEGER NOT NULL,
	PRIMARY KEY(id_carrera)
);

CREATE TABLE docentes (
	id_docente INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	nombre VARCHAR(50) NOT NULL,
	segundo_nombre VARCHAR(50),
	apellido VARCHAR(50) NOT NULL,
	segundo_apellido VARCHAR(50),
	correo_institucional VARCHAR(100) NOT NULL,
	id_departamento_academico INTEGER NOT NULL,
	anios_experiencia INTEGER NOT NULL CHECK(anios_experiencia > 0),
	PRIMARY KEY(id_docente)
);

CREATE TABLE estudiantes (
	id_estudiante INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	nombre VARCHAR(50) NOT NULL,
	segundo_nombre VARCHAR(50),
	apellido VARCHAR(50) NOT NULL,
	segundo_apellido VARCHAR(50),
	correo VARCHAR(50) NOT NULL UNIQUE,
	id_genero INTEGER,
	identificacion VARCHAR(50) NOT NULL UNIQUE,
	id_carrera INTEGER NOT NULL,
	fecha_nacimiento DATE NOT NULL,
	fecha_ingreso DATE NOT NULL,
	PRIMARY KEY(id_estudiante)
);

CREATE TABLE cursos (
	id_curso INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	nombre VARCHAR(50) NOT NULL,
	codigo VARCHAR(50) NOT NULL UNIQUE,
	creditos INTEGER NOT NULL,
	semestre VARCHAR(6) NOT NULL,
	id_docente INTEGER NOT NULL,
	PRIMARY KEY(id_curso)
);

CREATE TABLE inscripciones (
	id_inscripcion INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	id_estudiante INTEGER NOT NULL,
	id_curso INTEGER NOT NULL,
	fecha_inscripcion DATE NOT NULL,
	calificacion_final INTEGER NOT NULL,
	PRIMARY KEY(id_inscripcion)
);

-- Relaciones
ALTER TABLE cursos ADD FOREIGN KEY(id_docente) REFERENCES docentes(id_docente);
ALTER TABLE inscripciones ADD FOREIGN KEY(id_estudiante) REFERENCES estudiantes(id_estudiante);
ALTER TABLE inscripciones ADD FOREIGN KEY(id_curso) REFERENCES cursos(id_curso);
ALTER TABLE estudiantes ADD FOREIGN KEY(id_genero) REFERENCES generos(id_genero);
ALTER TABLE estudiantes ADD FOREIGN KEY(id_carrera) REFERENCES carreras(id_carrera);
ALTER TABLE docentes ADD FOREIGN KEY(id_departamento_academico) REFERENCES departamentos_academicos(id_departamento_academico);
ALTER TABLE carreras ADD FOREIGN KEY(id_departamento) REFERENCES departamentos_academicos(id_departamento_academico);

-- Paso 3: Inserciones de ejemplo
INSERT INTO departamentos_academicos (departamento_academico) VALUES
('Ingeniería'), ('Ciencias Sociales'), ('Humanidades');

INSERT INTO generos (genero) VALUES
('Masculino'), ('Femenino'), ('Otro');

INSERT INTO carreras (carrera, id_departamento) VALUES
('Ingeniería de Software', 1),
('Psicología', 2),
('Filosofía', 3);

INSERT INTO docentes (nombre, segundo_nombre, apellido, segundo_apellido, correo_institucional, id_departamento_academico, anios_experiencia) VALUES
('Carlos', 'Andrés', 'Pérez', 'Gómez', 'cperez@uni.edu', 1, 6),
('Laura', 'Isabel', 'Martínez', NULL, 'lmartinez@uni.edu', 2, 4),
('José', NULL, 'Ramírez', 'Lopez', 'jramirez@uni.edu', 3, 10);

INSERT INTO estudiantes (nombre, segundo_nombre, apellido, segundo_apellido, correo, id_genero, identificacion, id_carrera, fecha_nacimiento, fecha_ingreso) VALUES
('Ana', 'María', 'Gómez', 'Torres', 'ana.gomez@uni.edu', 2, '1001', 1, '2002-03-15', '2020-01-15'),
('Luis', 'Fernando', 'Rodríguez', 'López', 'luis.rodriguez@uni.edu', 1, '1002', 2, '2001-06-20', '2020-01-15'),
('Carla', 'Andrea', 'Suárez', NULL, 'carla.suarez@uni.edu', 2, '1003', 3, '2000-10-05', '2019-01-15'),
('Miguel', NULL, 'Álvarez', 'Mendoza', 'miguel.alvarez@uni.edu', 1, '1004', 1, '2002-12-01', '2021-01-15'),
('Paula', 'Juliana', 'Castaño', 'Ríos', 'paula.castano@uni.edu', 2, '1005', 2, '2003-01-10', '2021-01-15');

INSERT INTO cursos (nombre, codigo, creditos, semestre, id_docente) VALUES
('Bases de Datos', 'BD101', 4, '2', 1),
('Psicología General', 'PS201', 3, '1', 2),
('Ética Profesional', 'ET301', 2, '2', 3),
('Programación Web', 'PW401', 4, '3', 1);

INSERT INTO inscripciones (id_estudiante, id_curso, fecha_inscripcion, calificacion_final) VALUES
(1, 1, '2023-01-20', 85),
(1, 4, '2023-01-22', 90),
(2, 2, '2023-01-20', 75),
(2, 3, '2023-01-21', 88),
(3, 2, '2023-01-25', 95),
(4, 1, '2023-01-20', 65),
(4, 4, '2023-01-22', 78),
(5, 3, '2023-01-23', 82);