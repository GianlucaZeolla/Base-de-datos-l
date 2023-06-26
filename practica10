CREATE DATABASE db_practica10;
USE db_practica10;

/*1. Crear las tablas, incluyendo Foreign Key graficadas (entre ciudad y propiedad y
entre ciudad y país)*/
CREATE TABLE pais (
id_pais CHAR(2) PRIMARY KEY,
nombre VARCHAR(70),
codigo_telefonico CHAR(3)
);

CREATE TABLE ciudad (
id_ciudad INT(11) PRIMARY KEY,
nombre VARCHAR(50),
estado CHAR(2),
pais CHAR(2), 
FOREIGN KEY(pais) REFERENCES pais(id_pais)
);

CREATE TABLE propiedad (
id_propiedad INT(11) PRIMARY KEY,
nombre VARCHAR(50),
ciudad INT(11),
FOREIGN KEY(ciudad) REFERENCES ciudad(id_ciudad),
descripcion VARCHAR(255),
estrellas INT(11)
);

create table estado (
 id_estado CHAR(2) PRIMARY KEY,
 nombre VARCHAR(100) 
);

/*2. Insertar 3 países, 2 ciudades y 1 estado. Luego, insertar 5 propiedades. Una de
las ciudades debe tener estado definido, la otra, no.*/
INSERT INTO pais VALUES (1,'argentina', 011);
INSERT INTO pais VALUES (2,'brasil',012);
INSERT INTO pais VALUES (3,'uruguay',013);
SELECT * FROM pais;

INSERT INTO ciudad VALUES (1,'buenos_aires',1,1);
INSERT INTO ciudad VALUES (2,'sucre',2,2);
UPDATE ciudad SET estado = NULL WHERE estado = 'sucre';
SELECT * FROM ciudad;

INSERT INTO propiedad VALUES (1,'propiedad1',2,'descripcion1',5);
INSERT INTO propiedad VALUES (2,'propiedad2',1,'descripcion2',4);
INSERT INTO propiedad VALUES (3,'propiedad3',1,'descripcion3',5);
INSERT INTO propiedad VALUES (4,'propiedad4',2,'descripcion4',5);
INSERT INTO propiedad VALUES (5,'propiedad5',1,'descripcion5',3);
SELECT * FROM propiedad;

/*3. Crear una vista, ciudad_recomendada, que muestre:
a. id de ciudad
b. nombre de ciudad,
c. nombre de estado o la cadena “SIN ESTADO”, en caso de que no lo tenga
d. cantidad de propiedades en esa ciudad*/
CREATE VIEW ciudad_recomendada AS SELECT c.id_ciudad AS CiudadId, c.nombre AS CiudadNombre,  
CASE WHEN e.nombre IS NULL THEN 'SIN ESTADO' ELSE e.nombre END AS EstadoNombre, COUNT(p.id_propiedad) AS CantidadPropiedades 
FROM ciudad c LEFT JOIN estado e ON c.estado = e.id_estado LEFT JOIN Propiedad p ON c.id_ciudad = p.Ciudad GROUP BY c.id_ciudad, c.nombre, e.nombre;

/*4. Agregar a la tabla propiedad la columna aeropuerto_cercano de tipo char(3)*/
ALTER TABLE propiedad ADD COLUMN aeropuerto_cercano CHAR(3);
SELECT * FROM propiedad;

/*5. Crear:
a. una tabla Facilidad con campos
i. id int
ii. descripcion varchar(50)
b. una tabla propiedad_facilidad con campos:
i. id int autonumerico
ii. id_facilidad int
iii. id_propiedad int
Insertar 5 facilidades y filas en propiedad_facilidad para todas las propiedades y
facilidades
*/
CREATE TABLE facilidad (
id INT PRIMARY KEY,
descripcion VARCHAR(50)
);
CREATE TABLE propiedad_facilidad (
id INT primary key AUTO_INCREMENT,
id_facilidad INT,
id_propiedad INT
); 
INSERT INTO facilidad VALUES (1,'descripcion1');
INSERT INTO facilidad VALUES (2,'descripcion2');
INSERT INTO facilidad VALUES (3,'descripcion3');
INSERT INTO facilidad VALUES (4,'descripcion4');
INSERT INTO facilidad VALUES (5,'descripcion5');

INSERT INTO propiedad_facilidad (id_facilidad,id_propiedad) VALUES (1,1);
INSERT INTO propiedad_facilidad (id_facilidad,id_propiedad) VALUES (2,1);
INSERT INTO propiedad_facilidad (id_facilidad,id_propiedad) VALUES (3,1);
INSERT INTO propiedad_facilidad (id_facilidad,id_propiedad) VALUES (4,1);
INSERT INTO propiedad_facilidad (id_facilidad,id_propiedad) VALUES (5,1);

SELECT * from propiedad_facilidad;

/*6. Agregar foreign keys que relacionen a propiedad_facilidad con las dos tablas con
las que se relaciona*/
ALTER TABLE propiedad_facilidad
ADD CONSTRAINT fk_facilidad FOREIGN KEY (id_facilidad) REFERENCES facilidad(id);

ALTER TABLE propiedad_facilidad
ADD CONSTRAINT fk_propiedad FOREIGN KEY (id_propiedad) REFERENCES propiedad(id_propiedad);

/*7. Crear una vista con el id de propiedad y el nombre de propiedad, para aquellas
que tengan todas las facilidades asignadas*/
CREATE VIEW id_propiedadynombre_propiedad AS 
SELECT p.id_propiedad, p.nombre FROM propiedad p WHERE EXISTS(SELECT * FROM facilidad f WHERE p.id_propiedad = f.id);

/*8. Eliminar la columna estrellas de la tabla propiedad*/
ALTER TABLE propiedad DROP COLUMN estrellas;
SELECT * FROM propiedad;

/*9. Agregar a la tabla propiedad la columna fecha_inauguración de tipo datetime.
Asignar a todas las filas el valor de fecha una semana posterior a la actual*/
ALTER TABLE propiedad ADD COLUMN fecha_inaguracion DATETIME;
UPDATE propiedad SET fecha_inaguracion = DATE_ADD(NOW(), INTERVAL 1 WEEK);
