/*Funciones de FECHAS*/

/* para conocer la edad del autor
podemos hacer la diferencia entre la fecha de hoy y la fecha de nacimiento.*/
SELECT NOW();

SELECT a.nombre, a.fecha_nacimiento, DATEDIFF(NOW(), a.fecha_nacimiento)
FROM autor a

/*Esto nos devuelve la diferencia en días.
Tenemos los años*/
SELECT a.nombre, a.fecha_nacimiento, DATEDIFF(NOW(), a.fecha_nacimiento)/365
FROM autor a

/*Existe la función period_diff (YYMM or YYYYMM.)
nos devuelve la diferencia de meses*/

Select period_diff(201703, 201803);

/* función es sumar y restar datos a una fecha.*/

SELECT DATE_ADD(NOW(), INTERVAL 1 WEEK);
SELECT DATE_ADD(NOW(), INTERVAL 1 YEAR);
SELECT DATE_ADD(NOW(), INTERVAL 1 DAY);
SELECT DATE_ADD(NOW(), INTERVAL 1 weekday);

/*Puedo darle el formato que necesite. */
SELECT DATE_FORMAT (NOW(), '%d-%m-%Y')


/*Existe este auxiliar para el formato de diferentes locations.*/
Select date_format('2022-12-25', get_format(DATE,'USA'));


Create temporary table numero (num int not null primary KEY);

Insert into numero (num) values (1), (2), (3),(4), (5);
SELECT * FROM numero;

Select date_add(now(), interval num day ) from numero;

SELECT DATE_ADD(NOW(), INTERVAL num DAY)
FROM numero
WHERE num<=3;
