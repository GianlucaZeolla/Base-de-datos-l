Ejemplos de consultas útiles:
Ejemplo con length:
INSERT INTO partidos (equipo,puntos,temporada,fecha_partido)
SELECT e.nombre,(LENGTH(e.nombre)%5+1),'2023',f.dia FROM equipos e , fecha f;


Ejemplo de tabla view:
CREATE VIEW Puntos_equipos_partidos AS
SELECT p.equipo,p.puntos FROM partidos p;

Ejemplo de agregar columna:
ALTER TABLE jugadores ADD COLUMN Estado2 VARCHAR(10)

Ejemplo de borrar columna:
ALTER TABLE propiedad DROP COLUMN estrellas;

Ejemplo de borrar tablas con fk:
DELETE FROM jugadores WHERE nombre_equipo = 'Boca' 
DELETE FROM partidos WHERE equipo = 'Boca'
DELETE FROM equipos WHERE nombre = 'Boca' 

Ejemplo de agregar intervalos con fechas:
INSERT into fecha(dia) values
(DATE_ADD(NOW(),INTERVAL 1 WEEK)),
(DATE_ADD(NOW(),INTERVAL 2 WEEK)),
(DATE_ADD(NOW(),INTERVAL 3 WEEK)),
(DATE_ADD(NOW(),INTERVAL 4 WEEK)),
(DATE_ADD(NOW(),INTERVAL 5 WEEK)); 

Creacion de tablas con FK:

CREATE TABLE jugadores(
codigo INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(30),
precedencia VARCHAR(20),
altura VARCHAR(4),
peso INT,
posicion VARCHAR(5),
nombre_equipo VARCHAR(20),
estado VARCHAR(20),
FOREIGN KEY (nombre_equipo) REFERENCEs equipos(nombre)
);

CREATE TABLE equipos(
nombre VARCHAR(20) PRIMARY KEY,
ciudad VARCHAR(20),
conferencia VARCHAR(4),
division VARCHAR(9)
);

CREATE TABLE partidos(
codigo INT PRIMARY KEY AUTO_INCREMENT,
equipo VARCHAR(20),
puntos INT,
temporada VARCHAR(5),
fecha_partido DATETIME,
FOREIGN KEY (equipo) REFERENCES equipos(nombre)
);

Ejemplo de view con consulta y uso de case when:
CREATE VIEW ciudad_recomendada as
SELECT c.id_ciudad AS IDciudad,c.nombre AS nombre_ciudad,
case when e.nombre IS NULL 
then 'sin estado'
ELSE e.nombre END AS Estados ,COUNT(p.id_propiedad) AS cantidad_propiedad FROM ciudad c inner JOIN estado e ON c.estado = e.id_estado inner JOIN
propiedad p ON c.id_ciudad = p.Ciudad
GROUP BY c.id_ciudad, c.nombre, e.nombre;

Ejemplo de consulta con where not exists:
SELECT e.emp_id FROM empleado e WHERE NOT EXISTS(SELECT * FROM asignacion a WHERE e.emp_id = a.emp_id);

Ejemplo de asignacion a una columna con una condicion:
UPDATE alumnos SET Estado = 'con aplazo' WHERE NombreYApellido IN (SELECT distinct nombre FROM examenes WHERE nota <4)

Ejemplo de inserción con concat:
INSERT INTO alumnos(NombreYApellido)
SELECT CONCAT(n.nombre," ",a.apellido) AS Nombre_apellido FROM nombres n,apellidos a

Ejemplo de inserción con consulta:

INSERT INTO libro_autor (isbn,id_autor) 
SELECT rsbn,7 FROM revista;

Ejemplo de delete con condicion:
DELETE FROM libro WHERE precio < 400;

Ejemplo de uso de union:
CREATE view editoriales_sin_publicacion AS
SELECT nombre FROM editorial e WHERE NOT EXISTS (SELECT * FROM libro l WHERE e.id_editorial = l.id_editorial)
UNION
SELECT nombre FROM editorial e WHERE NOT EXISTS (SELECT * FROM Revista r WHERE e.id_editorial = r.id_editotial)



Ejemplo de uso case when con update:
UPDATE examenes SET descripcion = 'Recuperatorio' WHERE nota <4 ;
UPDATE examenes 
SET descripcion = CASE WHEN nota >= 4 
then 'Aprobado' 
when nota < 4
then 'Recuperatorio'
ELSE descripcion 
END;

Ejemplo de creacion de tabla temporal:
CREATE temporary TABLE semana_completa (
dias INT,
fecha DATE);
INSERT INTO semana_completa (dias) VALUES (1),(2),(3),(4),(5);
UPDATE semana_completa SET fecha = DATE_ADD(NOW(), INTERVAL dias DAY);



