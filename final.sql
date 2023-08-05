create DATABASE final_db;
use final_db;

create table instrumento (
nombre varchar(50) PRIMARY KEY,
tipo varchar(50)
);

create table toca (
nombreMusico varchar(50),
FOREIGN KEY (nombreMusico) REFERENCES musico (nombre),
nombreInstrumento varchar(50),
FOREIGN KEY (nombreInstrumento) REFERENCES instrumento(nombre)
);

CREATE TABLE toca (
nombreMusico VARCHAR(50),
nombreInstrumento VARCHAR(50),
FOREIGN KEY (nombreMusico) REFERENCES musico (nombre),
FOREIGN KEY (nombreInstrumento) REFERENCES instrumento (nombre)
);

create table musico (
nombre varchar(50) PRIMARY KEY,
origen varchar(50)
);

create table pertenece (
nombreMusico varchar(50) PRIMARY KEY,
FOREIGN KEY (nombreMusico) REFERENCES musico (nombre),
nombreBanda varchar(150) PRIMARY KEY,
FOREIGN KEY (nombreBanda) REFERENCES banda (nombre)
);

CREATE TABLE banda (
nombre VARCHAR(150) PRIMARY KEY,
origen VARCHAR(150),
genero VARCHAR(150),
fechaFormacion DATE
);
SELECT * FROM banda;

CREATE TABLE shows (
idShows INT PRIMARY KEY,
nombreBanda VARCHAR(150),
FOREIGN KEY (nombreBanda) REFERENCES banda(nombre),
nombreEstadio VARCHAR(150),
FOREIGN KEY (nombreEstadio) REFERENCES estadio(nombre),
fecha DATE
);

CREATE TABLE estadio (
nombre VARCHAR(150) PRIMARY KEY,
ubicacion VARCHAR(150),
capacidad INT
);

ALTER TABLE shows ADD COLUMN fecha DATE;

INSERT INTO banda (nombre,origen,genero,fechaFormacion) VALUES ('losRamones','eeuu','punk rock',1974-01-01);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
INSERT INTO musico (nombre,origen) VALUES ('pepe','orlando');
INSERT INTO musico (nombre,origen) VALUES ('juan','texas');

INSERT INTO toca(nombreMusico,nombreInstrumento) VALUES('pepe','guitarra');
INSERT INTO toca(nombreMusico,nombreInstrumento) VALUES('juan','trompeta');

INSERT INTO instrumento (nombre, tipo) VALUES ('guitarra','cuerda');
INSERT INTO instrumento (nombre, tipo) VALUES ('saxofon','aire');
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
INSERT INTO shows (idShows,nombreBanda,nombreEstadio,fecha) VALUES (1,'losRamones','estadio unico',2010);

INSERT INTO estadio (nombre,ubicacion,capacidad) VALUES ('estadio unico','la plata',70000);

/*actualizar el genero de todas las bandas de "punk rock" al genero "punk"*/
UPDATE banda
SET genero = 'punk'
WHERE genero = 'punk rock';
/*obtener el nombre de los musicos que tocan instrumentos de cuerda*/
SELECT m.nombre
FROM musico m
INNER JOIN toca t ON m.nombre = t.nombreMusico
INNER JOIN instrumento i ON t.nombreInstrumento = i.nombre  
WHERE i.tipo = 'cuerda';
/*obtener el nombre de las bandas que solo hayan tocado en estadios de la plata*/
SELECT b.nombre
FROM banda b
INNER JOIN shows s ON b.nombre = s.nombreBanda
INNER JOIN estadio e ON s.nombreEstadio = e.nombre
WHERE e.ubicacion = 'Estadio de La Plata'
GROUP BY b.nombre
HAVING COUNT(DISTINCT e.ubicacion) = 1;
/*obtener el nombre de los musicos que hayan tocado en algun estadio ubicado en su ciudad de origen */
SELECT DISTINCT m.nombre AS nombreMusico
FROM musico m

inner JOIN pertenece p ON m.nombre = p.nombreMusico
inner JOIN banda b ON p.nombreBanda = b.nombre
inner JOIN shows s ON b.nombre = s.nombreBanda
inner JOIN estadio e ON s.nombreEstadio = e.nombre

WHERE m.origen = e.ubicacion;

/*realizar una vista "VISTASHOW" con el "nombre de la banda", "nombre estadio" y la fecha del show, edad de la banda y un dato estado para determinar el estado de cada show:
+si la fecha del show es mayor o igual a '2023-01-01', se asigna el estado "futuro"
+si la decha del show es menor a '2023-02-02' se asigna el estado "pasado" 
+si ninguna de estas condiciones se cumple, se asigna el estado "desconocido"*/
CREATE VIEW VISTASHOW AS
SELECT 
    b.nombre AS nombreBanda,
    s.nombreEstadio,
    s.fecha AS fechaShow,
    YEAR(CURDATE()) - YEAR(b.fechaFormacion) AS edadBanda,
    CASE
        WHEN s.fecha >= '2023-01-01' THEN 'futuro'
        WHEN s.fecha < '2023-02-02' THEN 'pasado'
        ELSE 'desconocido'
    END AS estado
FROM
    shows s
JOIN banda b ON s.nombreBanda = b.nombre
JOIN estadio e ON s.nombreEstadio = e.nombre;

select * from vistaShow;

