create DATABASE final_db;
use final_db;

create table instrumento (
nombre varchar(50),
tipo varchar(50)
);
create table toca (
  nombreMusico varchar(50)
  nombreInstrumento varchar(50)
  );
create table musico (
  nombre varchar(50),
  origen varchar(50)
  ),
  create table pertenece (
  nombreMusico varchar(50),
  nombreBanda varchar(150)
  );



/*actualizar el genero de todas las bandas de "punk rock" al genero "punk"*/
UPDATE bandas
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
FROM bandas b
INNER JOIN shows s ON b.nombre = s.nombreBanda
INNER JOIN estadio e ON s.nombreEstadio = e.nombre
WHERE e.ubicacion = 'Estadio de La Plata'
GROUP BY b.nombre
HAVING COUNT(DISTINCT e.ubicacion) = 1;
/*obtener el nombre de los musicos que hayan ticadi en algun estadio ubicado en su ciudad de origen */

