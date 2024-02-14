/*1. Generar una relación con una columna que contenga los títulos y otra que contenga los
ingresos previstos para cada título. Dichos ingresos serán calculados mediante el producto de
las ventas previstas por el precio asignado a cada título. */

select TITULO,precio*VENTAS_PREVISTAS as ganancia from TITULOS;

/*2. Mostrar los títulos cuyas ventas previstas estén entre 200 y 5000 unidades*/

select TITULO,VENTAS_PREVISTAS from TITULOS where VENTAS_PREVISTAS<=5000 and VENTAS_PREVISTAS>=200;

/*3. Mostrar los nombres, apellidos y teléfonos de todos los autores ordenados en primer lugar por
el nombre de forma ascendente y luego por el apellido en forma descendente*/

select AU_NOMBRE,AU_APELLIDO,AU_TELEFONO from AUTORES order by AU_NOMBRE;

select AU_NOMBRE,AU_APELLIDO,AU_TELEFONO from AUTORES order by AU_APELLIDO desc ;

/*4. Mostrar los nombres y apellidos de los autores que no tienen teléfono (es decir, es nulo)*/

select AU_NOMBRE,AU_APELLIDO from AUTORES where AU_TELEFONO IS NULL order by AU_NOMBRE;

/*5. Mostrar los nombres, apellidos y teléfonos de todos los autores, indicando “sin teléfono” para
aquellos que no tienen teléfono. Formular la consulta utilizando la función NVL*/

select AU_NOMBRE,AU_APELLIDO,NVL(AU_TELEFONO,'Sin teléfono') as telefono from AUTORES   order by AU_NOMBRE;

/*6. Mostrar el identificador de los títulos, el propio título y las ventas previstas para cada uno de
los títulos cuyo tipo es bases de datos (BD) o programación (PROG). Ordenar los datos
descendentemente por precio. Formular la consulta de dos formas diferentes*/

select TITULO_ID,TITULO,VENTAS_PREVISTAS  from TITULOS where TIPO='BD' or TIPO='PROG' order by  precio desc;


Select TITULO_ID,TITULO,VENTAS_PREVISTAS from (
(select TITULO_ID,TITULO,VENTAS_PREVISTAS,precio  from TITULOS where TIPO='BD')
 Union
(select TITULO_ID,TITULO,VENTAS_PREVISTAS,precio  from TITULOS where TIPO='PROG')) order by precio desc;

/*7. Mostrar todos los autores cuyo teléfono comience con el prefijo ‘456’.*/

select * from AUTORES where AU_TELEFONO like '456%';

/*8. Mostrar el precio medio de los títulos almacenados en la tabla TITULOS. Mostrar el precio
medio para los títulos cuyo tipo es bases de datos. Formalizar la consulta de dos formas diferentes. */

/*8.1*/
select Round(Avg(precio),2) from TITULOS;

select Avg(precio) from (Select * from TITULOS);

/*8.2*/
select Avg(precio) from TITULOS where TIPO='BD';

select avg(precio) from(Select * from TITULOS where TIPO='BD');

/*9. Mostrar el número de títulos que tiene cada editorial. Indicar también el número de títulos que
pertenecen a cada tipo para cada editorial.*/

/*9.1*/

select TITULOS.ED_ID,count(EDITORIALES.ED_ID) total from EDITORIALES join TITULOS on EDITORIALES.ED_ID = TITULOS.ED_ID group by TITULOS.ED_ID;

/*9.2*/

select TITULOS.ED_ID,TIPO,count(EDITORIALES.ED_ID) total from EDITORIALES join TITULOS on EDITORIALES.ED_ID = TITULOS.ED_ID group by TITULOS.ED_ID,TIPO;

/*10. Mostrar para cada tipo de título el número de ejemplares existentes.*/

select TIPO, count(TITULO) cantidad  from TITULOS group by TIPO order by cantidad desc;

/*11. Mostrar el precio medio para cada tipo de título cuya fecha de publicación sea posterior al año
2000 (>=01/01/2000).*/

SELECT * from TITULOS where F_PUBLICACION>=TO_DATE('01/01/2000','dd/mm/YYYY');

SELECT *  from TITULOS Minus (SELECT * from TITULOS where F_PUBLICACION<TO_DATE('01/01/2000','dd/mm/YYYY'));

Select tipo,ROUND(avg(PRECIO),2) Precio_Medio from (SELECT * from TITULOS where F_PUBLICACION>=TO_DATE('01/01/2000','dd/mm/YYYY')) group by tipo;

/*12. Mostrar para cada tipo de título el número de ejemplares que existen siempre que éste sea
superior a una unidad.*/

Select  * from(Select tipo,count(TITULO)  cantidad from TITULOS group by  tipo) where cantidad>1;

/*13. Mostrar para cada tipo de título el precio medio siempre que éste sea superior a 35.*/

Select TIPO,avg(PRECIO) from TITULOS group by TIPO;

Select * from (Select TIPO,avg(PRECIO) Precio_medio from TITULOS group by TIPO) where Precio_medio>35;

/*14. Mostrar para cada editorial el precio medio de sus títulos siempre que el identificador de la
editorial sea superior a ‘2’ y el precio medio sea superior a 60. El resultado debe aparecer
ordenado de forma ascendente por el identificador de la editorial*/

SELECT * from (Select EDITORIALES.ED_ID ,avg(Precio) precio from EDITORIALES JOIN TITULOS on EDITORIALES.ED_ID = TITULOS.ED_ID group by EDITORIALES.ED_ID) where ED_ID>2 and precio>60;

/*15. Mostrar el nombre, apellidos y orden de los editores para el título cuyo identificador es ‘1’. */

Select EDITOR_NOMBRE,EDITOR_APELLIDO,ORDEN_EDITORES from TITULOSEDITORES join EDITORES on TITULOSEDITORES.EDITOR_ID = EDITORES.EDITOR_ID where TITULO_ID=1;

/*16. Mostrar los nombres de los editores y de las editoriales de la misma ciudad.*/

Select EDITOR_NOMBRE,ED_NOMBRE,ED_CIUDAD from EDITORIALES,EDITORES where ED_CIUDAD=EDITOR_CIUDAD;

/*17. Mostrar los títulos de todos los libros del tipo bases de datos (BD) y los nombres de sus
autores, así como el orden en el que figuran. */

SELECT TITULO,AU_NOMBRE from TITULOS join TITULOSAUTORES join AUTORES on TITULOSAUTORES.AU_ID = AUTORES.AU_ID on TITULOS.TITULO_ID = TITULOSAUTORES.TITULO_ID where tipo='BD';

/*18. Mostrar el nombre y apellidos de los editores, así como el nombre de su editor jefe.*/

SElECT  ed1.EDITOR_NOMBRE,ed1.EDITOR_APELLIDO,ed2.EDITOR_NOMBRE jefe from EDITORES ed1 join EDITORES ed2 on ed1.EDITOR_JEFE=ed2.EDITOR_ID;

/*19. Mostrar los datos de los autores (au_id, au_nombre y au_apellido) en los que coinciden su
apellido. */

Select autores1.AU_ID,autores1.AU_NOMBRE,autores1.AU_APELLIDO from AUTORES autores1 join AUTORES autores2 on autores1.AU_APELLIDO=autores2.AU_APELLIDO where autores1.AU_ID!=autores2.AU_ID;

/*20. Mostrar los nombres de las editoriales que publican títulos de programación. Formalizar la
consulta de dos formas diferentes al menos*/

Select EDITORIALES.ed_nombre from EDITORIALES, TITULOS where EDITORIALES.ED_ID=TITULOS.ED_ID and TITULOS.tipo='PROG';

Select EDITORIALES.ed_nombre from EDITORIALES join  TITULOS on EDITORIALES.ED_ID = TITULOS.ED_ID where TITULOS.tipo='PROG';

/*21. Mostrar el título y el precio de los libros cuyo precio coincida con el del libro más barato.
Hacer lo mismo con el más caro. */

Select total.TITULO,total.PRECIO from TItulos total join (SELECT Min(Precio) minimo from TITULOS ) t2 on total.PRECIO=t2.minimo;

Select total.TITULO,total.PRECIO from TItulos total join (SELECT MAx(Precio) minimo from TITULOS ) t2 on total.PRECIO=t2.minimo;

/*22. Mostrar los nombres y la ciudad de los autores que viven en la misma ciudad que ‘Abraham
Silberschatz.’*/

SELECT AU_CIUDAD from AUTORES where AU_NOMBRE='Abraham' and AU_APELLIDO='Silberschatz';

SELECT au1.AU_NOMBRE,au1.AU_APELLIDO,au1.AU_CIUDAD from AUTORES au1 join (SELECT AU_CIUDAD from AUTORES where AU_NOMBRE='Abraham' and AU_APELLIDO='Silberschatz') ciudad on au1.AU_CIUDAD=ciudad.AU_CIUDAD;

/*23. Mostrar el nombre y apellido de los autores que son autores individuales
(porcentaje_participacion=1) y coautores(porcentaje_participacion<1).*/

SELECT t1.AU_ID from TITULOSAUTORES t1 join TITULOSAUTORES t2 on t2.AU_ID=t1.AU_ID where t1.PORCENTAJE_PARTICIPACION=1 and t2.PORCENTAJE_PARTICIPACION<1;

Select AU_NOMBRE,AU_APELLIDO from AUTORES join (SELECT t1.AU_ID from TITULOSAUTORES t1 join TITULOSAUTORES t2 on t2.AU_ID=t1.AU_ID where t1.PORCENTAJE_PARTICIPACION=1 and t2.PORCENTAJE_PARTICIPACION<1) au2 on au2.AU_ID In AUTORES.AU_ID;

/*24. Mostrar los tipos de libros que son comunes a más de una editorial. Formalizar la consulta de dos
formas diferentes*/

SELECT Distinct t1.TIPO from TITULOS t1 join TITULOS t2 on t1.TIPO=t2.tipo and t1.ED_ID!=t2.ED_ID;

/*25. Mostrar los tipos de libros cuyo precio máximo es al menos un 10% más caro que el precio
medio para ese tipo. Y un 20%. ? preguntar */

select tipo,round(avg(Precio),2) precio_medio from TITULOS group by tipo;

select tipo,max(precio) from TITULOS group by tipo;

select pre_medio.TIPO from (select tipo,round(avg(Precio),2) precio_medio from TITULOS group by tipo) pre_medio join (select tipo,max(precio) precio_maximo from TITULOS group by tipo) pre_max on pre_max.TIPO=pre_medio.TIPO where precio_maximo*0.9>=precio_medio;

/*26. Mostrar los libros que tienen una pre-publicación mayor que la mayor pre-publicación que
tiene la editorial ‘Prentice Hall’.*/

select max(PRE_PUBLICACION) max_pre_pu from EDITORIALES join TITULOS T on EDITORIALES.ED_ID = T.ED_ID where ED_NOMBRE='Prentice Hall';

select TITULO from TITULOS where PRE_PUBLICACION>(select max(PRE_PUBLICACION) max_pre_pu from EDITORIALES join TITULOS T on EDITORIALES.ED_ID = T.ED_ID where ED_NOMBRE='Prentice Hall');

/*27. Mostrar los títulos de los libros publicados por una editorial localizada en una ciudad que
comienza por la letra ‘B’*/

SELECT TITULO from TITULOS join EDITORIALES on TITULOS.ED_ID = EDITORIALES.ED_ID where ED_CIUDAD like 'B%';

/*28. Mostrar los nombres de las editoriales que no publican libros cuyo tipo sea bases de datos.
Formalizar la consulta de dos formas diferentes*/

Select EDITORIALES.ED_NOMBRE,EDITORIALES.ED_ID from EDITORIALES join TITULOS on EDITORIALES.ED_ID = TITULOS.ED_ID where TIPO='BD';

SELECT ED_NOMBRE,ED_ID from EDITORIALES minus (Select EDITORIALES.ED_NOMBRE,EDITORIALES.ED_ID from EDITORIALES join TITULOS on EDITORIALES.ED_ID = TITULOS.ED_ID where TIPO='BD');

SELECT ED_NOMBRE from(SELECT ED_NOMBRE,ED_ID from EDITORIALES minus (Select EDITORIALES.ED_NOMBRE,EDITORIALES.ED_ID from EDITORIALES join TITULOS on EDITORIALES.ED_ID = TITULOS.ED_ID where TIPO='BD'));

Select ED_NOMBRE from EDITORIALES where ED_ID not in (Select EDITORIALES.ED_ID from EDITORIALES join TITULOS on EDITORIALES.ED_ID = TITULOS.ED_ID where TIPO='BD');



select distinct clientes.nombre,clientes.apellido from ventas join clientes on ventas.dni=clientes.dni where ventas.cifc in (Select ventas.cifc from ventas join clientes on ventas.dni = clientes.dni where clientes.dni='2') and clientes.dni<>'2';