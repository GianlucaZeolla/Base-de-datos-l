CREATE DATABASE db_parcial2;
USE db_parcial2;

/*1. Crear las tablas del esquema, incluyendo Foreign Keys Crear la tabla temporal
FECHA.*/

CREATE TABLE jugadores (
codigo INT(11) PRIMARY KEY,
nombre VARCHAR(30),
procedencia VARCHAR(20),
altura VARCHAR(4),
peso INT(11),
posicion VARCHAR(5),
nombre_equipo VARCHAR(20),
FOREIGN KEY (nombre_equipo) REFERENCES equipos(nombre),
estado VARCHAR(20)
);

CREATE TABLE equipos (
nombre VARCHAR(20) PRIMARY KEY,
ciudad VARCHAR(20),
conferencia VARCHAR(4),
division VARCHAR(9)
);

CREATE TABLE partidos (
codigo INT(11) PRIMARY KEY,
equipo VARCHAR(20),
FOREIGN KEY (equipo) REFERENCES equipos(nombre),
puntos INT(11),
temporada VARCHAR(5),
fecha_partido DATETIME
);
CREATE TEMPORARY table fecha (
id INT AUTO_INCREMENT PRIMARY KEY,
fecha DATETIME
);

/*2. Insertar 5 equipos, 4 jugadores. 5 semanas consecutivas a elección en la tabla
FECHA.*/
INSERT INTO equipos VALUES ('river','nuñez',1,1);
INSERT INTO equipos VALUES ('platense','vicente_lopez',2,1);
INSERT INTO equipos VALUES ('tigre','victoria',3,1);
INSERT INTO equipos VALUES ('arsenal','sarandi',4,1);
INSERT INTO equipos VALUES ('racing','avellaneda',5,1);
INSERT INTO equipos VALUES ('quilmes','quilmes',6,2);
SELECT * FROM equipos;
INSERT INTO jugadores VALUES (1,'gianluca','nuñez',187,80,'dfc','river',1);
INSERT INTO jugadores VALUES (2,'lucas','vicente_lopez',180,68,'dc','platense',1);
INSERT INTO jugadores VALUES (3,'martin','victoria',185,82,'mc','tigre',1);
INSERT INTO jugadores VALUES (4,'juan','avellaneda',187,80,'ed','racing',1);
SELECT * FROM jugadores;
INSERT INTO fecha VALUES (2,DATE_ADD(NOW(), INTERVAL 1 WEEK));
INSERT INTO fecha VALUES (1,DATE_ADD(NOW(), INTERVAL 2 WEEK));
INSERT INTO fecha VALUES (3,DATE_ADD(NOW(), INTERVAL 3 WEEK));
INSERT INTO fecha VALUES (4,DATE_ADD(NOW(), INTERVAL 4 WEEK));
INSERT INTO fecha VALUES (5,DATE_ADD(NOW(), INTERVAL 5 WEEK));
SELECT * FROM fecha;

/*3. Insertar partidos para todos los equipos, para todas las fechas, temporada 2023.
Los puntos pueden calcularse con la cantidad de letras (length) del equipo, y un
cálculo que termine (........)%5 +1 (de modo que vaya de 1 a 5)
Todas las combinaciones posibles.*/
INSERT INTO partidos VALUES (1,'river',5,'2023','2023-07-07 17:33:30');
INSERT INTO partidos VALUES (2,'platense',8,'2023','2023-07-03 20:20:08');
INSERT INTO partidos VALUES (3,'quilmes',7,'2023','2023-07-24 20:21:37');
INSERT INTO partidos VALUES (4,'racing',6,'2023','2023-07-17 20:21:37');
INSERT INTO partidos VALUES (5,'arsenal',7,'2023','2023-07-31 20:21:37');
INSERT INTO partidos VALUES (6,'tigre',5,'2023','2023-07-03 20:20:08');
SELECT * FROM partidos;

SELECT e.nombre AS equipo,
(LENGTH(e.nombre) % 5 + 1) AS puntos,
'2023' AS temporada,
f.fecha AS fecha_partido FROM equipos e INNER JOIN fecha f;

/*4. Crear una vista con los puntos de cada equipo en los partidos llamada
Puntos_equipos_partidos.*/
CREATE VIEW Puntos_equipos_partidos AS
SELECT
  equipo,
  SUM(puntos) AS total_puntos
FROM
  partidos
GROUP BY
  equipo;
SELECT * FROM Puntos_equipos_partidos;

/*5. Agregar a la tabla Jugadores la columna “Estado” de tipo varchar(10).
Asignar para todos los jugadores cuyo equipo no han realizado ningun partido
ponerle ‘libre’ en la columna “Estado”*/

ALTER TABLE jugadores ADD COLUMN estado VARCHAR(10);

UPDATE jugadores
SET estado = 'libre'
WHERE nombre_equipo NOT IN (
  SELECT DISTINCT equipo
  FROM partidos
);
SELECT * FROM jugadores;

/*6. Siguiendo la lógica de las Foreign Keys, ejecutar todos los pasos necesarios para
eliminar un equipo a elección.*/
DELETE FROM jugadores WHERE nombre_equipo = 'river';

DELETE FROM partidos WHERE equipo = 'river';

DELETE FROM equipos WHERE nombre = 'river';

SELECT * FROM partidos;
SELECT * FROM equipos;
