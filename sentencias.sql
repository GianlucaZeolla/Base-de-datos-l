/*En primer lugar seleccionamos la base de datos con la que vamos a trabajar*/
USE bd1_practica1;
SHOW tables;

/* Podemos desplegar las columnas..*/
DESCRIBE libro;

/*Crear una base de datos*/
CREATE table revista (
isrn INT NOT NULL PRIMARY KEY,
titulo VARCHAR(90) null,
id_editorial INT NULL,
precio DECIMAL(8,2) );

/*Clave Primaria compuesta*/
CREATE TABLE a (
da1 INT NOT NULL,
da2 INT NOT NULL,
descripcion VARCHAR(90),
PRIMARY KEY (da1, da2)
);

DESCRIBE a;

/*Modificar una tabla-
ALTER*/
/*modificación de la columna*/
ALTER TABLE a
modify column descripcion VARCHAR(1000);

/*podemos decirle que no sea nulo */
ALTER TABLE a
modify column descripcion VARCHAR(1000) not null;

/*Eliminar una columna:*/
ALTER table a
DROP COLUMN descripcion;

/*Agregar una columna*/
ALTER table a
add COLUMN nombre VARCHAR(100) null;

/*Eliminar una tabla*/
Drop table a;

/*Crear con auto-incremente*/
CREATE TABLE a (
da1 INT NOT NULL auto_increment ,
descripcion VARCHAR(90),
PRIMARY KEY (da1)
);

/*VISTAS*/
CREATE VIEW libro_completo AS
SELECT l.isbn, l.titulo, l.precio, e.nombre, e.ciudad
FROM libro l INNER JOIN editorial e
ON l.id_editorial=e.id_editorial;

SELECT l.ciudad, l.precio
FROM libro_completo l
WHERE l.ciudad="Buenos Aires";

SELECT l.ciudad, sum(l.precio) suma
FROM libro_completo l
GROUP BY l.ciudad;

/*Modificar la vista*/

ALTER VIEW libro_completo AS
SELECT l.titulo, l.precio, e.nombre, e.ciudad
FROM libro l INNER JOIN editorial e
ON l.id_editorial=e.id_editorial;



/*Si se modifica la tabla se modifica los datos de la vista*/
Select * from editorial;
Update editorial set ciudad='Cordoba' where id_editorial=4;
/*Y se cambio la vista..*/
Select * from libro_completo order by ciudad;

/*Eliminar la vista */
DROP VIEW libro_completo;

/*INSERT*/

DESCRIBE revista;

INSERT INTO revista (isrn, titulo, id_editorial, precio)
VALUE(1234, 'revista 1', 1, 10);

Estamos insertando 1 dato, explícitamente, 
escribimos los datos que van a haber en cada fila que se inserta.
INSERT INTO revista
VALUE(2345, 'revista 2', 1, 20);

/*Que pasa si no indico las columnas, si agrego una columna, 
que no debería haber ningún conveniente para consultas Y 
hago un insert me va a decir que hay un error que hay distinta cantidad de columnas
entre lo que estoy insertando y el esquema de la tabla.*/
ALTER TABLE revista
ADD COLUMN ciudad VARCHAR(50);

INSERT INTO revista (isrn, titulo, id_editorial, precio)
VALUES (5677, 'revista 3', 1, 10);

/*Puedo insertar más de una fila*/

INSERT INTO revista (isrn, titulo, id_editorial, precio)
VALUES (7899, 'revista 4', 2, 20),
(3444, 'revista 5', 3, 25);

/*El comando INSERT también se puede usar para insertar datos 
en una tabla de otra tabla. 

INSERT INTO table_1 SELECT * FROM table_2;*/


INSERT INTO revista (isrn, titulo, id_editorial, precio)
SELECT isbn, titulo, id_editorial, precio
FROM libro;

/*También le podría poner una restricción*/
INSERT INTO revista (isrn, titulo, id_editorial, precio)
SELECT isbn, titulo, id_editorial, precio
FROM libro where tipo='revista'

/*UPDATE:
La sentencia UPDATE se utiliza para modificar valores en una tabla.
La sintaxis de SQL UPDATE es:
UPDATE nombre_tabla
SET columna1 = valor1, columna2 = valor2
WHERE columna3 = valor3*/

UPDATE revista
SET ciudad='Buenos Aires' WHERE isrn=1234;

UPDATE revista
SET ciudad='Buenos Aires'

UPDATE revista
SET ciudad=CONCAT(titulo, ' ','Buenos Aires') WHERE isrn=1234;

UPDATE revista
SET precio=precio*2;


UPDATE revista r SET ciudad = (
SELECT e.ciudad
from editorial e
WHERE e.id_editorial=r.id_editorial);

/*DELETE
Para eliminar una o más filas de una tabla por completo, usamos DELETE
la siguiente declaración eliminará todas las filas de revista:*/
DELETE FROM revista

/*Eliminar algunas filas con un ejemplo de condición*/
Delete from revista where isrn<3000;

CREATE table revista2 (
id INT NOT NULL auto_increment PRIMARY key,
isrn INT NOT NULL ,
titulo VARCHAR(90) null,
id_editorial INT NULL,
precio DECIMAL(8,2) );

INSERT INTO revista2 (isrn, titulo, id_editorial, precio)
VALUES (7899, 'revista 4', 2, 20);
SELECT * FROM revista2;

DELETE from revista2 WHERE id=1;

INSERT INTO revista2 (isrn, titulo, id_editorial, precio)
VALUES (7899, 'revista 4', 2, 20):

/*Sigue con la numeración de los id.*/

Truncate table revista2;

INSERT INTO revista2 (isrn, titulo, id_editorial, precio)
VALUES (7899, 'revista 4', 2, 20)

/*La tabla reinicia el ID*/
