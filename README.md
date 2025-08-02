# Entrenamiento M4S2 - Sergio Cortes

## Consultas

### Obtener el listado de todos los estudiantes junto con sus inscripciones y cursos

<img src="./images/consulta_1.png" />

---

### Listar los cursos dictados por docentes con más de 5 años de experiencia.

<img src="./images/consulta_2.png" />

---

### Obtener el promedio de calificaciones por curso (GROUP BY + AVG).

<img src="./images/consulta_3.png" />

---

### Mostrar los estudiantes que están inscritos en más de un curso (HAVING COUNT(*) > 1).

<img src="./images/consulta_4.png" />

---

### Agregar una nueva columna estado_academico a la tabla estudiantes (ALTER TABLE).

<img src="./images/consulta_5.png" />

---

### Eliminar un docente y observar el efecto en la tabla cursos (uso de ON DELETE en FK).

Al intentar eliminar al docente Jose no me deja debido a que la taba `cursos` tiene una llave foránea vinculada a él.

<img src="./images/consulta_6-1.png" />

Reviso la tabla de `cursos` para saber el nombre de la llave foránea.

<img src="./images/consulta_6-2.png" />

Elimino la llave foránea.

<img src="./images/consulta_6-3.png" />

Intento añadir una nueva llave foránea pero agregandole `ON DELETE SET NULL` para que al eliminar el docente, en la tabla `cursos` el campo del `id_docente` cambie a `NULL`.

No me lo permite debido a que `id_docente` tiene `NOT NULL`.

<img src="./images/consulta_6-4.png" />

Edito la columna `id_docente` para permitir valores `NULL`.

<img src="./images/consulta_6-5.png" />

Añado la clave foránea con `ON DELETE SET NULL`.

<img src="./images/consulta_6-6.png" />

Elimino al docente.

<img src="./images/consulta_6-7.png" />

Reviso si alguna fila de `cursos` tiene `NULL` en `id_docente`.

<img src="./images/consulta_6-8.png" />

<img src="./images/consulta_6-9.png" />

---

### Consultar los cursos en los que se han inscrito más de 2 estudiantes (GROUP BY + COUNT + HAVING).

`SELECT` general para mostrar la tabla completa.

<img src="./images/consulta_7-1.png" />

#### `HAVING COUNT(*) > 2`

<img src="./images/consulta_7-2.png" />

### Obtener el promedio de calificaciones por estudiante (GROUP BY + AVG).

<img src="./images/consulta_8.png" />

## Subconsultas

### Obtener los estudiantes cuya calificación promedio es superior al promedio general (AVG() + subconsulta).

<img src="./images/subconsulta_1.png" />

---

### Mostrar los nombres de las carreras con estudiantes inscritos en cursos del semestre 2 o posterior (IN o EXISTS).

<img src="./images/subconsulta_2.png" />

---

### Utiliza funciones como ROUND, SUM, MAX, MIN y COUNT para explorar distintos indicadores del sistema.

#### 1. Cantidad total de estudiantes

<img src="./images/subconsulta_3-1.png" />

####  2. Cantidad de estudiantes por carrera

<img src="./images/subconsulta_3-2.png" />

#### 3. Suma total de créditos inscritos por estudiante

<img src="./images/subconsulta_3-3.png" />

#### 4. Promedio de calificaciones por curso (con ROUND)

<img src="./images/subconsulta_3-4.png" />

#### 5. Máxima y mínima calificación obtenida por cada estudiante

<img src="./images/subconsulta_3-5.png" />

#### 6. Carrera con mejor promedio de calificación

<img src="./images/subconsulta_3-6.png" />

#### 7. Cantidad de cursos por semestre

<img src="./images/subconsulta_3-7.png" />

## Crear una vista

<img src="./images/crear_vista.png" />

## Control de acceso y transacciones

### 1. Asigna permisos de solo lectura a un rol llamado revisor_academico sobre la vista *vista_historial_academico (GRANT SELECT)*

<img src="./images/acceso_transacciones_1.png" />

### 2. Revoca los permisos de modificación de datos sobre la tabla inscripciones a este rol (REVOKE).


<img src="./images/acceso_transacciones_2.png" />

### 3. Simula una operación de actualización de calificaciones usando BEGIN, SAVEPOINT, ROLLBACK y COMMIT.

<img src="./images/acceso_transacciones_3-1.png" />

<img src="./images/acceso_transacciones_3-2.png" />

<img src="./images/acceso_transacciones_3-3.png" />