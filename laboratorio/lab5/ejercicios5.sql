/*1. Muestra el apellido, puesto de trabajo, salario y % de comisión de aquellos empleados que
ganan comisiones. Ordena los datos por el puesto de trabajo en orden ascendente y por el
salario de forma descendente. */

select LAST_NAME,JOB_ID,SALARY,COMMISSION_PCT from EMPLOYEES
where COMMISSION_PCT is not null
order by JOB_ID asc, salary desc;

/*2. Muestra aquellos empleados que tienen un apellido que empieza por J, K, L o M*/

select * from EMPLOYEES where LAST_NAME like 'J%' or LAST_NAME like 'K%' or  LAST_NAME like 'L%' or LAST_NAME like 'M%';

/*3. Muestra para todos los empleados el apellido y número de empleado, junto al apellido y
número de empleado de su manager.*/

select empleado.LAST_NAME,empleado.EMPLOYEE_ID,manager.LAST_NAME, manager.EMPLOYEE_ID
from EMPLOYEES empleado join EMPLOYEES manager
on empleado.MANAGER_ID=manager.EMPLOYEE_ID;

/*4. Muestra el apellido y fecha de contratación de todos los empleados contratados después del
empleado apellidado ‘Davies’*/

Select LAST_NAME,HIRE_DATE from EMPLOYEES
where HIRE_DATE >(Select HIRE_DATE from EMPLOYEES where LAST_NAME='Davies');

/*5. Muestra los nombres y fechas de contratación de todos los empleados que fueron contratados
antes que sus managers. Muestra también el apellido de su manager y su fecha de contratación.*/

select empleado.LAST_NAME, empleado.HIRE_DATE
from EMPLOYEES empleado join EMPLOYEES manager
on empleado.MANAGER_ID=manager.EMPLOYEE_ID
where empleado.HIRE_DATE<manager.HIRE_DATE;

/*6. Muestra el número de departamento (department_id) y su salario mínimo para aquel
departamento con mayor salario medio.*/

select distinct DEPARTMENT_ID, SALARY from EMPLOYEES where DEPARTMENT_ID in
(select DEPARTMENT_ID from
(select DEPARTMENT_ID, avg(SALARY) sl from EMPLOYEES group by DEPARTMENT_ID)
order by sl desc
fetch first rows with ties)
order by SALARY
fetch first rows only;
