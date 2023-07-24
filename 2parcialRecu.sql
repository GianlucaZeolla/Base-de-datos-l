CREATE DATABASE parcial_db;
USE parcial_db;

CREATE TABLE partidos (
codigo INT,
equipo VARCHAR(20),
puntos INT,
temporada VARCHAR(5),
fecha_partido DATETIME
);

CREATE TABLE equipos (
nombre VARCHAR(20),
ciudad VARCHAR(20),
conferencia VARCHAR(4),
division VARCHAR(9)
);

CREATE TABLE jugadores (
codigo INT,
nombre VARCHAR(30),
fecha_nacimiento DATETIME,
peso INT,
posicion VARCHAR(5),
nombre_equipo VARCHAR(20),
salario DECIMAL(8,2)
);

/*2. Insertar en la tabla al jugador Garcia J. con un sueldo de $3.000.000, número
1234, fecha de nacimiento 03-07-2000, equipo Boca, altura 165, peso, 70kg, juega
de delantero (DELAN) .
10 puntos*/
INSERT INTO jugadores (codigo, nombre, fecha_nacimiento, peso, posicion, nombre_equipo, salario)
VALUES (1, 'Garcia J.', '2000-07-03', 70, 'DELAN', 'Boca', 300000000);

/*3. Cambiar al jugador número 1234 a un nuevo equipo ‘River’
10 puntos*/
UPDATE jugadores
SET nombre_equipo = 'River'
WHERE numero = 1234;
/*Crear una vista “cantidad_partidos” con la cantidad de partidos jugados de cada
equipo, la ciudad del equipo y la división a la que pertenece .*/
CREATE VIEW cantidad_partidos AS
SELECT e.nombre AS 'Nombre del Equipo', e.ciudad AS 'Ciudad del Equipo', e.division AS 'División del Equipo', COUNT(p.codigo) AS 'Cantidad de Partidos Jugados'
FROM equipos e
INNER JOIN partidos p ON e.nombre = p.equipo
GROUP BY e.nombre, e.ciudad, e.division;

/*5. Agregar a la tabla Jugadores la columna “anios” de tipo decimal(8,2).*/
ALTER TABLE jugadores
ADD column anios DECIMAL(8,2);

/*Siguiendo la lógica de las Foreign Keys, ejecutar todos los pasos necesarios para
eliminar un equipo a elección. Justifique los pasos realizados.*/


