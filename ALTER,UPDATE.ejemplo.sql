/*9. Agregar a la tabla propiedad la columna fecha_inauguración de tipo datetime.
Asignar a todas las filas el valor de fecha una semana posterior a la actual*/
ALTER TABLE propiedad ADD COLUMN fecha_inaguracion DATETIME

UPDATE propiedad SET fecha_inaguracion = DATE_ADD(NOW(),INTERVAL 1 WEEK)



/*5.	Agregar a  la tabla Jugadores la columna “Estado” de tipo varchar(10).

Asignar para todos los  jugadores cuyo equipo no han realizado ningun partido ponerle ‘libre’ en la columna “Estado”
*/
ALTER TABLE jugadores ADD COLUMN estado2 VARCHAR(10)

UPDATE jugadores SET estado2 = 'libre' WHERE nombre_equipo NOT IN (SELECT DISTINCT equipo FROM partidos) 
