/*13. Incrementar en 10 unidades el número de transformadores de aquellas estaciones en las
que alguna de las centrales nucleares que les entregan energía genera un volumen de
residuos superior a 30000*/


SELECT * from entrega
where ENTREGA.PNOMBRE in (select NUCLEAR.PNOMBRE nom from nuclear where RESIDUOS>=30000);

update ESTACION set  TRANSFORMADORES=TRANSFORMADORES+10
where ENOMBRE in (SELECT ENTREGA.ENOMBRE from entrega
where ENTREGA.PNOMBRE in (select NUCLEAR.PNOMBRE nom from nuclear where RESIDUOS>=30000));

select * from ESTACION where ENOMBRE='YS-021';

/*2. Obtener el nombre de las compañías que comienza por la letra ‘C’ que poseen redes de
distribución que envían energía a otras redes, pero no reciben energía de ninguna otra red.*/

select NUMRED_ENVIA from ENVIA_ENERGIA
where NUMRED_ENVIA not in (select NUMRED_RECIBE from ENVIA_ENERGIA);

select distinct CNOMBRE from RED_DISTRIBUCION join
(select NUMRED_ENVIA from ENVIA_ENERGIA
where NUMRED_ENVIA not in (select NUMRED_RECIBE from ENVIA_ENERGIA)) i
on i.NUMRED_ENVIA=RED_DISTRIBUCION.NUMRED
join PERTENECE on RED_DISTRIBUCION.NUMRED = PERTENECE.NUMRED
where PERTENECE.CNOMBRE like 'C%';

select distinct CNOMBRE from PERTENECE where CNOMBRE like 'C%'
and NUMRED in (select NUMRED_ENVIA from ENVIA_ENERGIA)
and NUMRED not in (select NUMRED_RECIBE from ENVIA_ENERGIA);

/*6. Obtener el nombre, la producción media y el número de reactores de los productores
nucleares que compran plutonio a suministradores con mayor stock de todos.*/



select nuclear.PNOMBRE, PRODMEDIA, NUMREACTORES from PRODUCTOR,NUCLEAR,compra,SUMINISTRADOR
WHERE PRODUCTOR.PNOMBRE=NUCLEAR.PNOMBRE and NUCLEAR.PNOMBRE=COMPRA.PNOMBRE and COMPRA.SNOMBRE=SUMINISTRADOR.SNOMBRE and
COMPRA.PAIS=SUMINISTRADOR.PAIS and STOCK=(select max(STOCK) from SUMINISTRADOR);

/*3. Obtener para cada envío de energía entre redes de distribución, el número de red de la red
que envía energía y de la que la recibe, así como el volumen de energía del envío siempre y
cuando la estación de cabecera de la red que envía energía tenga un número de
transformadores mayor que el número de transformadores de la red que recibe la energía y
el volumen de energía enviado sea mayor de 16000W.*/

select numred_envia, numred_recibe, volumen from ENVIA_ENERGIA ee join RED_DISTRIBUCION r1
on ee.NUMRED_ENVIA=r1.NUMRED
join ESTACION e1
on r1.ENOMBRE = e1.ENOMBRE
join RED_DISTRIBUCION r2 on r2.NUMRED=NUMRED_RECIBE
join ESTACION e2 on r2.ENOMBRE=e2.ENOMBRE where
VOLUMEN>16000 and e1.TRANSFORMADORES>e2.TRANSFORMADORES;

