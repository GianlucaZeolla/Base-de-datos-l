USE parcial_db
/*1. Color de bote y cantidad de remeros que lo hayan alquilado, siempre el promedio
de edad de los remeros que lo hayan alquilado sea menor a 23*/
SELECT b.color AS 'Color del Bote', COUNT(DISTINCT r.id) AS 'Cantidad de Remeros'
FROM bote b
INNER JOIN alquiler a ON b.id = a.id_bote
INNER JOIN remero r ON a.id_remero = r.id
GROUP BY b.color
HAVING AVG(r.edad) < 23;

/*2. Nombre de remero y cantidad de alquileres que realizó para remeros mayores a
21 años, siempre que hayan alquilado 2 o más botes distintos*/
SELECT r.nombre AS 'Nombre del Remero', COUNT(DISTINCT a.id_bote) AS 'Cantidad de Botes Alquilados'
FROM remero r
INNER JOIN alquiler a ON r.id = a.id_remero
WHERE r.edad > 21
GROUP BY r.id, r.nombre
HAVING COUNT(DISTINCT a.id_bote) >= 2;
/*3. Nombre de remeros que hayan alquilado botes rojos*/
SELECT DISTINCT r.nombre AS 'Nombre del Remero'
FROM remero r
INNER JOIN alquiler a ON r.id = a.id_remero
INNER JOIN bote b ON a.id_bote = b.id
WHERE b.color = 'rojo';
/*4. Color de bote y cantidad de alquileres que tuvo*/
SELECT b.color AS 'Color del Bote', COUNT(a.id) AS 'Cantidad de Alquileres'
FROM bote b
INNER JOIN alquiler a ON b.id = a.id_bote
GROUP BY b.color;
/*5. Nombre de remero que no haya alquilado botes (puede no haber resultados)*/
SELECT r.nombre 
FROM remero r
LEFT JOIN alquiler a ON r.id = a.id_remero
WHERE a.id_remero IS NULL;
/*6. ¿Cómo puedo verificar, con los datos que hay en cada tabla, el resultado de la
consulta anterior? (Se espera una explicación, consultas, lo que sea necesario
para demostrar cómo justificar el resultado que tiene la consulta anterior) */
SELECT * FROM remero;
