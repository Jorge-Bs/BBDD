-- noinspection LossyEncodingForFile

/*1. Obtener el nombre de las estaciones y su n�mero de transformadores, para las estaciones
en las que alguna de las centrales nucleares que les entregan energ�a genera m�s de 25000 
residuos.*/

select pnombre,numreactores from nuclear where residuos>25000;

select distinct estacion.enombre,estacion.transformadores from estacion 
join entrega on estacion.enombre=entrega.enombre
join (select pnombre,numreactores from nuclear where residuos>25000) sl on sl.pnombre=entrega.pnombre;

/*Obtener el nombre de las compa��as que comienza por la letra �C� que poseen redes de 
distribuci�n que env�an energ�a a otras redes, pero no reciben energ�a de ninguna otra red.*/

select numred_recibe from envia_energia; --centrales que envian reciben

select distinct numred_envia from envia_energia where numred_envia not in (select numred_recibe from envia_energia); -- centrales que envian y no reciben energia

select distinct cnombre from pertenece 
join (select envia_energia.numred_envia idvalue from envia_energia where numred_envia not in (select numred_recibe from envia_energia)) sl
on pertenece.numred=sl.idvalue where cnombre like 'C%';

/*3. Obtener para cada env�o de energ�a entre redes de distribuci�n, el n�mero de red de la red 
que env�a energ�a y de la que la recibe, as� como el volumen de energ�a del env�o siempre y 
cuando la estaci�n de cabecera de la red que env�a energ�a tenga un n�mero de 
transformadores mayor que el n�mero de transformadores de la red que recibe la energ�a y 
el volumen de energ�a enviado sea mayor de 16000W.*/



select * from envia_energia where volumen>16000;

select envia.numred,recibe.numred,volumen from envia_energia 
join red_distribucion envia on envia.numred=envia_energia.numred_envia
join red_distribucion recibe on recibe.numred=envia_energia.numred_recibe 
join estacion estenvia on estenvia.enombre=envia.enombre 
join estacion estrecibe on estrecibe.enombre=recibe.enombre
where volumen>16000 and estenvia.transformadores > estrecibe.transformadores;

/*4. Obtener el nombre y el n�mero de transformadores de las estaciones que tengan m�s de 
800 transformadores y que sean cabeceras de redes de distribuci�n que no abastecen a 
subestaciones con un n�mero total acumulado de consumidores particulares mayor que el 
n�mero total acumulado de consumidores de empresas.*/


select * from estacion where transformadores>800;

select * from linea join red_distribucion on red_distribucion.numred=linea.numred
join estacion on red_distribucion.enombre=estacion.enombre
where estacion.transformadores>800;

select distinct linea.numred, red_distribucion.enombre from linea,red_distribucion where linea.numred=red_distribucion.numred;


/*5. Obtener el nombre y el número de reactores de los productores nucleares (ordenados de
forma descendente por residuos generados) cuyo nombre comienza por 'C' y se trate de
productores que entregan energía a estaciones con más de 300 transformadores y que sean
cabecera de redes de distribución de longitud máxima superior a 125000 y que dichas redes
dispongan de al menos una línea instalada.*/

select NUCLEAR.PNOMBRE,NUMREACTORES from nuclear join ENTREGA on nuclear.PNOMBRE=ENTREGA.PNOMBRE
join estacion on ENTREGA.ENOMBRE=ESTACION.ENOMBRE
where entrega.ENOMBRE in (select enombre from RED_DISTRIBUCION where LONGITUDMAXIMA>125000
and numred in (select NUMRED from linea)) and ESTACION.TRANSFORMADORES>300 and NUCLEAR.PNOMBRE like 'C%'
order by NUCLEAR.RESIDUOS desc;

/*6. Obtener el nombre, la producción media y el número de reactores de los productores
nucleares que compran plutonio a suministradores con mayor stock de todos*/

select snombre,pais from SUMINISTRADOR order by STOCK desc fetch first row with ties; --sumistradores con mayor stock

select nuclear.PNOMBRE,PRODMEDIA,NUMREACTORES from NUCLEAR join compra2 on NUCLEAR.PNOMBRE=COMPRA2.PNOMBRE
join PRODUCTOR on PRODUCTOR.PNOMBRE=NUCLEAR.PNOMBRE
where (snombre,pais) in (select snombre,pais from SUMINISTRADOR order by STOCK desc fetch first row with ties);


/*7. Obtener el nombre y capital social de las compañías de más de 50 M de dicho capital, así
como el número total de acciones que poseen dichas compañías en redes de distribución
que ni envían ni reciben energía de ninguna otra red de distribución y siempre y cuando
dicho número total de acciones sea mayor que 25000.*/

select sl.CNOMBRE,COMPANIA.CAPITALSOCIAL,sl.acc from(
select PERTENECE.CNOMBRE, sum(NUMACCIONES) acc from PERTENECE join COMPANIA on PERTENECE.CNOMBRE = COMPANIA.CNOMBRE where CAPITALSOCIAL > 50
and PERTENECE.NUMRED in(select numred from RED_DISTRIBUCION where NUMRED not in (select NUMRED_ENVIA from ENVIA_ENERGIA) and NUMRED not in (select NUMRED_RECIBE from ENVIA_ENERGIA))
group by  PERTENECE.CNOMBRE)sl join COMPANIA on COMPANIA.CNOMBRE=sl.CNOMBRE
where acc>25000;

select * from RED_DISTRIBUCION where NUMRED not in (select NUMRED_ENVIA from ENVIA_ENERGIA) and NUMRED not in (select NUMRED_RECIBE from ENVIA_ENERGIA);

/*8. Obtener el nombre de las estaciones junto con su número de transformadores para
aquellas estaciones que son cabecera de las redes de distribución cuyas líneas abastecen las
subestaciones que distribuyen energía solo a zonas cuyo consumo en instituciones es
mayor que el consumo de particulares.*/


-------------------------

select Zcodigo from zona where CONSPARTICULARES>=CONSINSTITUCIONES;


select RED_DISTRIBUCION.ENOMBRE,TRANSFORMADORES from (
select NUMRED from linea where NUMRED not in(
select numred from(
(select NLINEA,NUMRED from linea)
minus
(select NLINEA,NUMRED from DISTRIBUYE join SUBESTACION on SUBESTACION.NSUBESTACION=DISTRIBUYE.NSUBESTACION
where DISTRIBUYE.ZCODIGO in (select Zcodigo from zona where CONSPARTICULARES>=CONSINSTITUCIONES))))) sl, RED_DISTRIBUCION,ESTACION
where sl.NUMRED=RED_DISTRIBUCION.NUMRED and RED_DISTRIBUCION.ENOMBRE=ESTACION.ENOMBRE;

/*9. Obtener el nombre de las provincias que tienen más de una zona cuyas empresas
consumen (consEmpresas) más que las instituciones (consInstituciones). Además, solo
deben salir las provincias cuyo consumo medio máximo de dichas zonas sea superior a
20000. Muestra el resultado ordenado de forma descendente por el nombre de las
provincias.*/

select nombre from PROVINCIA join
(select PCODIGO from zona where CONSEMPRESAS>CONSINSTITUCIONES group by PCODIGO having max(CONSUMOMEDIO)>20000 and count(*)>1) sl
on sl.PCODIGO=PROVINCIA.PCODIGO order by NOMBRE desc;


/*10. Obtener el nombre y el número de transformadores de las estaciones cuyo nombre
empiece por M y que son cabecera de al menos una red que envía y recibe energía (ambas
cosas).*/

select distinct ESTACION.ENOMBRE,TRANSFORMADORES
from RED_DISTRIBUCION, ESTACION where NUMRED in (select NUMRED_ENVIA from ENVIA_ENERGIA) and NUMRED in (select NUMRED_RECIBE from ENVIA_ENERGIA)
and RED_DISTRIBUCION.ENOMBRE=ESTACION.ENOMBRE and ESTACION.ENOMBRE like 'M%';

/*11. Obtener el nombre de los productores nucleares que compran plutonio a algún
suministrador y que solo entregan energía a estaciones que no son cabecera de ninguna red
de distribución.*/

select distinct ENOMBRE from ESTACION where ENOMBRE not in (select ENOMBRE from RED_DISTRIBUCION);

select distinct PNOMBRE from NUCLEAR where PNOMBRE in (select PNOMBRE from compra2);

select ENTREGA.PNOMBRE from ESTACION,ENTREGA,NUCLEAR where ENTREGA.ENOMBRE=ESTACION.ENOMBRE and NUCLEAR.PNOMBRE=ENTREGA.PNOMBRE
and ESTACION.ENOMBRE in (select distinct ENOMBRE from ESTACION where ENOMBRE not in (select ENOMBRE from RED_DISTRIBUCION))
and NUCLEAR.PNOMBRE in (select distinct PNOMBRE from NUCLEAR where PNOMBRE in (select PNOMBRE from compra2));

/*12. Obtener el número de red junto con sus líneas (nlinea) y la longitud de éstas para aquellas
redes de distribución que envían energía a otras redes de distribución cuya estación de
cabecera es la que recibe menos cantidad de energía de los productores.*/


select ENOMBRE from(

select ESTACION.enombre, sum(cantidad) cn
from ESTACION,ENTREGA
where ESTACION.ENOMBRE=ENTREGA.ENOMBRE
and estacion.ENOMBRE
        in (select ENOMBRE from ENVIA_ENERGIA,RED_DISTRIBUCION
                           where ENVIA_ENERGIA.NUMRED_ENVIA=RED_DISTRIBUCION.NUMRED) group by ESTACION.enombre)
order by cn fetch first row with ties;

select ENOMBRE from ENVIA_ENERGIA,RED_DISTRIBUCION where ENVIA_ENERGIA.NUMRED_ENVIA=RED_DISTRIBUCION.NUMRED;

select * from linea,RED_DISTRIBUCION where LINEA.NUMRED=RED_DISTRIBUCION.NUMRED and ENOMBRE in (select ENOMBRE from(

select ESTACION.enombre, sum(cantidad) cn
from ESTACION,ENTREGA
where ESTACION.ENOMBRE=ENTREGA.ENOMBRE
and estacion.ENOMBRE
        in (select ENOMBRE from ENVIA_ENERGIA,RED_DISTRIBUCION
                           where ENVIA_ENERGIA.NUMRED_ENVIA=RED_DISTRIBUCION.NUMRED) group by ESTACION.enombre)
order by cn fetch first row with ties);

------------------------------------------------------------------------------------------------------------------------

select ESTACION.ENOMBRE,sum(CANTIDAD) from estacion, ENTREGA where ESTACION.ENOMBRE=ENTREGA.ENOMBRE group by ESTACION.ENOMBRE

select enombre from ESTACION where ENOMBRE not in ( select enombre from entrega)