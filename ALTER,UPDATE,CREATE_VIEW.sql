/*9. Agregar a la tabla propiedad la columna fecha_inauguración de tipo datetime.
Asignar a todas las filas el valor de fecha una semana posterior a la actual*/
ALTER TABLE propiedad ADD COLUMN fecha_inaguracion DATETIME

UPDATE propiedad SET fecha_inaguracion = DATE_ADD(NOW(),INTERVAL 1 WEEK)



/*5.	Agregar a  la tabla Jugadores la columna “Estado” de tipo varchar(10).

Asignar para todos los  jugadores cuyo equipo no han realizado ningun partido ponerle ‘libre’ en la columna “Estado”
*/
ALTER TABLE jugadores ADD COLUMN estado2 VARCHAR(10)

UPDATE jugadores SET estado2 = 'libre' WHERE nombre_equipo NOT IN (SELECT DISTINCT equipo FROM partidos) 
/*4.	Crear una vista con los puntos de cada equipo en los partidos  llamada Puntos_equipos_partidos.
*/
CREATE VIEW puntos_equipos_partidos AS 
SELECT p.equipo,p.puntos FROM partidos p; 

/*3. Crear una vista, ciudad_recomendada, que muestre:
a. id de ciudad
b. nombre de ciudad,
c. nombre de estado o la cadena “SIN ESTADO”, en caso de que no lo tenga
d. cantidad de propiedades en esa ciudad*/
CREATE VIEW ciudad_recomendada AS SELECT c.id_ciudad AS CiudadId, c.nombre AS CiudadNombre,  
CASE WHEN e.nombre IS NULL THEN 'SIN ESTADO' ELSE e.nombre END AS EstadoNombre, COUNT(p.id_propiedad) AS CantidadPropiedades 
FROM ciudad c LEFT JOIN estado e ON c.estado = e.id_estado LEFT JOIN Propiedad p ON c.id_ciudad = p.Ciudad GROUP BY c.id_ciudad, c.nombre, e.nombre;
