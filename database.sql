-- Paso 1: Crear base de datos
CREATE DATABASE IF NOT EXISTS gestion_academica_universidad CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE gestion_academica_universidad;

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

-- Paso 4: Consultas básicas
-- Estudiantes con sus cursos
/* SELECT e.nombre, e.apellido, c.nombre AS curso, i.calificacion_final
FROM estudiantes e
JOIN inscripciones i ON e.id_estudiante = i.id_estudiante
JOIN cursos c ON c.id_curso = i.id_curso; */

-- Cursos con docentes con más de 5 años experiencia
/* SELECT c.nombre, d.nombre, d.apellido
FROM cursos c
JOIN docentes d ON d.id_docente = c.id_docente
WHERE d.anios_experiencia > 5; */

-- Promedio por curso
/* SELECT c.nombre, AVG(i.calificacion_final) AS promedio
FROM cursos c
JOIN inscripciones i ON c.id_curso = i.id_curso
GROUP BY c.nombre;
 */
-- Estudiantes inscritos en más de un curso
/* SELECT e.nombre, COUNT(*) AS total_inscripciones
FROM estudiantes e
JOIN inscripciones i ON e.id_estudiante = i.id_estudiante
GROUP BY e.id_estudiante
HAVING COUNT(*) > 1;
 */
-- Agregar columna estado_academico
/* ALTER TABLE estudiantes ADD estado_academico VARCHAR(50);
 */
-- Eliminar un docente
/* DELETE FROM docentes WHERE id_docente = 2; */

-- Cursos con más de 2 estudiantes inscritos
/* SELECT c.nombre, COUNT(*) AS total_inscritos
FROM cursos c
JOIN inscripciones i ON c.id_curso = i.id_curso
GROUP BY c.id_curso
HAVING COUNT(*) > 2; */

-- Paso 5: Subconsultas y funciones
-- Estudiantes con promedio superior al general
/* SELECT e.nombre, e.apellido
FROM estudiantes e
JOIN inscripciones i ON e.id_estudiante = i.id_estudiante
GROUP BY e.id_estudiante
HAVING AVG(i.calificacion_final) > (
  SELECT AVG(calificacion_final) FROM inscripciones
); */

-- Carreras con cursos del semestre 2 o posterior
/* SELECT DISTINCT ca.carrera
FROM carreras ca
JOIN estudiantes es ON es.id_carrera = ca.id_carrera
JOIN inscripciones i ON i.id_estudiante = es.id_estudiante
JOIN cursos cu ON cu.id_curso = i.id_curso
WHERE cu.semestre >= '2';
 */
-- Uso de funciones agregadas
/* SELECT 
  ROUND(AVG(calificacion_final), 2) AS promedio,
  MAX(calificacion_final) AS maximo,
  MIN(calificacion_final) AS minimo,
  SUM(calificacion_final) AS suma,
  COUNT(*) AS total
FROM inscripciones;
 */
-- Paso 6: Crear vista
/* CREATE VIEW vista_historial_academico AS
SELECT 
  e.nombre AS estudiante,
  c.nombre AS curso,
  d.nombre AS docente,
  c.semestre,
  i.calificacion_final
FROM inscripciones i
JOIN estudiantes e ON i.id_estudiante = e.id_estudiante
JOIN cursos c ON i.id_curso = c.id_curso
JOIN docentes d ON c.id_docente = d.id_docente;
 */
-- Paso 7: Control de acceso y transacciones
/* CREATE ROLE revisor_academico;
GRANT SELECT ON vista_historial_academico TO revisor_academico;
REVOKE INSERT, UPDATE, DELETE ON inscripciones FROM revisor_academico;
 */
-- Simulación de transacción
/* START TRANSACTION;
UPDATE inscripciones SET calificacion_final = 95 WHERE id_inscripcion = 1;
SAVEPOINT antes_cambio;
UPDATE inscripciones SET calificacion_final = 60 WHERE id_inscripcion = 2;
ROLLBACK TO antes_cambio;
COMMIT;
 */
