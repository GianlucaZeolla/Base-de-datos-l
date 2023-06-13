CREATE DATABASE practica9;
USE practica9;

/*1.	Crear las tablas*/

CREATE TABLE empleado (
emp_id INT,
emp_nombre VARCHAR(255),
emp_edad INT);

CREATE TABLE proyecto (
pro_id INT,
pro_descripcion VARCHAR(255));

CREATE TABLE asignacion (
asi_id INT AUTO_INCREMENT PRIMARY KEY,
emp_id INT,
pro_id INT,
asi_fecha DATETIME,
asi_cant_horas DOUBLE );

/*2.	Insertar 5 empleados y 4 proyectos*/

INSERT INTO empleado (emp_id, emp_nombre, emp_edad) VALUES (1, 'alejandro', 20);
INSERT INTO empleado (emp_id, emp_nombre, emp_edad) VALUES (2, 'gian', 18);
INSERT INTO empleado (emp_id, emp_nombre, emp_edad) VALUES (3, 'enzo', 21);
INSERT INTO empleado (emp_id, emp_nombre, emp_edad) VALUES (4, 'lautaro', 23);
INSERT INTO empleado (emp_id, emp_nombre, emp_edad) VALUES (5, 'matias', 26);
SELECT * FROM empleado;

INSERT INTO proyecto (pro_id, pro_descripcion) VALUES (1, 'descripcion1');
INSERT INTO proyecto (pro_id, pro_descripcion) VALUES (2, 'descripcion2');
INSERT INTO proyecto (pro_id, pro_descripcion) VALUES (3, 'descripcion3');
INSERT INTO proyecto (pro_id, pro_descripcion) VALUES (4, 'descripcion4');
SELECT * FROM proyecto;

/*3.	Crear una tabla temporal SEMANA_COMPLETA, que tenga una fila por día de una semana laboral a elección. Queda a criterio del alumno la definición de las columnas que necesite.
Se espera que tenga 5 filas que contengan como mínimo la fecha de cada día de una semana.*/

CREATE temporary TABLE semana_completa (
id INT AUTO_INCREMENT PRIMARY KEY,
fecha DATETIME);

INSERT INTO semana_completa (fecha) VALUES (DATE_ADD(NOW(), INTERVAL 1 DAY));
INSERT INTO semana_completa (fecha) VALUES (DATE_ADD(NOW(), INTERVAL 2 DAY));
INSERT INTO semana_completa (fecha) VALUES (DATE_ADD(NOW(), INTERVAL 3 DAY));
INSERT INTO semana_completa (fecha) VALUES (DATE_ADD(NOW(), INTERVAL 4 DAY));
INSERT INTO semana_completa (fecha) VALUES (DATE_ADD(NOW(), INTERVAL 5 DAY));
SELECT * FROM semana_completa;

/*4.	Insertar para 2 proyectos y para 3 empleados, asignaciones de 4 horas durante la semana representada en el punto 3*/
INSERT INTO asignacion (emp_id, pro_id,asi_fecha, asi_cant_horas)
SELECT e.emp_id, p.pro_id, sc.fecha, 4 
FROM empleado e, proyecto p, semana_completa sc
WHERE e.emp_id IN (1,2,3)
AND p.pro_id IN (1,2)
AND sc.fecha IN (SELECT fecha FROM semana_completa); 

SELECT * FROM asignacion;
/*5.Insertar para los 2 proyectos restantes y los 2 empleados restantes asignaciones de 4 horas durante la semana representada en el punto 3.*/
INSERT INTO asignacion (emp_id, pro_id,asi_fecha, asi_cant_horas)
SELECT e.emp_id, p.pro_id, sc.fecha, 4 
FROM empleado e, proyecto p, semana_completa sc
WHERE e.emp_id IN (4,5)
AND p.pro_id IN (3,4)
AND sc.fecha IN (SELECT fecha FROM semana_completa); 

