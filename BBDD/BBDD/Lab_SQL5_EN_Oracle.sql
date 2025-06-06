ALTER TABLE "DEPARTMENTS" DROP CONSTRAINT FK_DEPARTMENTS_EMPLOYEES;
drop table employees;
drop table departments;
drop table jobs;
drop table locations; 

CREATE TABLE "LOCATIONS" (
	location_id    decimal(4,0),
	street_address VARCHAR(40),
	postal_code    VARCHAR(12), 
	city       VARCHAR(30),
	state_province VARCHAR(25),
	country_id     CHAR(2),
	CONSTRAINT PK_LOCATION PRIMARY KEY (location_id)
);

CREATE TABLE "DEPARTMENTS" (
	department_id    decimal(4,0),
	department_name  VARCHAR(30),
	manager_id       decimal(6,0),
	location_id      decimal(4,0) NOT NULL,
	CONSTRAINT PK_DEPARTMENTS PRIMARY KEY (department_id),	
	CONSTRAINT FK_DEPARTMENTS_LOCATIONS FOREIGN KEY (location_id) REFERENCES "LOCATIONS" (location_id)
);

CREATE TABLE "JOBS" (
	job_id         VARCHAR(10),
	job_title      VARCHAR(35),
	min_salary     decimal(6,0),
	max_salary     decimal(6,0),
	CONSTRAINT PK_JOBS PRIMARY KEY (job_id)
);

CREATE TABLE "EMPLOYEES" (
	employee_id    decimal(6,0),
	first_name     VARCHAR(20),
	last_name      VARCHAR(25),
	email          VARCHAR(25),
	phone_number  VARCHAR(20),
	hire_date      DATE,
	salary         decimal(8,2),
	commission_pct decimal(2,2),
	job_id         VARCHAR(10),
	manager_id     decimal(6,0),
	department_id  decimal(4,0),
	CONSTRAINT PK_EMPLOYEES PRIMARY KEY (employee_id),
	CONSTRAINT FK_EMPLOYEES_JOBS FOREIGN KEY (job_id) REFERENCES "JOBS" (job_id),
	CONSTRAINT FK_EMPLOYEES_EMPLOYEES FOREIGN KEY (manager_id) REFERENCES "EMPLOYEES" (employee_id),
	CONSTRAINT FK_EMPLOYEES_DEPARTMENTS FOREIGN KEY (department_id) REFERENCES "DEPARTMENTS" (department_id)
);

ALTER TABLE "DEPARTMENTS" ADD CONSTRAINT FK_DEPARTMENTS_EMPLOYEES FOREIGN KEY (manager_id) REFERENCES "EMPLOYEES" (employee_id);

INSERT INTO "LOCATIONS" VALUES(1000,'1297 Via Cola di Rie','00989','Roma',NULL,'IT');
INSERT INTO "LOCATIONS" VALUES(1100,'93091 Calle della Testa','10934','Venice',NULL,'IT');
INSERT INTO "LOCATIONS" VALUES(1200,'2017 Shinjuku-ku','1689','Tokyo','Tokyo Prefecture','JP');
INSERT INTO "LOCATIONS" VALUES(1300,'9450 Kamiya-cho','6823','Hiroshima',NULL,'JP');
INSERT INTO "LOCATIONS" VALUES(1400,'2014 Jabberwocky Rd','26192','Southlake','Texas','US');
INSERT INTO "LOCATIONS" VALUES(1500,'2011 Interiors Blvd','99236','South San Francisco','California','US');
INSERT INTO "LOCATIONS" VALUES(1600,'2007 Zagora St','50090','South Brunswick','New Jersey','US');
INSERT INTO "LOCATIONS" VALUES(1700,'2004 Charade Rd','98199','Seattle','Washington','US');
INSERT INTO "LOCATIONS" VALUES(1800,'147 Spadina Ave','M5V 2L7','Toronto','Ontario','CA');
INSERT INTO "LOCATIONS" VALUES(1900,'6092 Boxwood St','YSW 9T2','Whitehorse','Yukon','CA');
INSERT INTO "LOCATIONS" VALUES(2000,'40-5-12 Laogianggen','190518','Beijing',NULL,'CN');
INSERT INTO "LOCATIONS" VALUES(2100,'1298 Vileparle (E);','490231','Bombay','Maharashtra','IN');
INSERT INTO "LOCATIONS" VALUES(2200,'12-98 Victoria Street','2901','Sydney','New South Wales','AU');
INSERT INTO "LOCATIONS" VALUES(2300,'198 Clementi North','540198','Singapore',NULL,'SG');
INSERT INTO "LOCATIONS" VALUES(2400,'8204 Arthur St',NULL,'London',NULL,'UK');
INSERT INTO "LOCATIONS" VALUES(2500,'Magdalen Centre,The Oxford Science Park','OX9 9ZB','Oxford','Oxford','UK');
INSERT INTO "LOCATIONS" VALUES(2600,'9702 Chester Road','09629850293','Stretford','Manchester','UK');
INSERT INTO "LOCATIONS" VALUES(2700,'Schwanthalerstr. 7031','80925','Munich','Bavaria','DE');
INSERT INTO "LOCATIONS" VALUES(2800,'Rua Frei Caneca 1360 ','01307-002','Sao Paulo','Sao Paulo','BR');
INSERT INTO "LOCATIONS" VALUES(2900,'20 Rue des Corps-Saints','1730','Geneva','Geneve','CH');
INSERT INTO "LOCATIONS" VALUES(3000,'Murtenstrasse 921','3095','Bern','BE','CH');
INSERT INTO "LOCATIONS" VALUES(3100,'Pieter Breughelstraat 837','3029SK','Utrecht','Utrecht','NL');
INSERT INTO "LOCATIONS" VALUES(3200,'Mariano Escobedo 9991','11932','Mexico City','Distrito Federal,','MX');

ALTER TABLE "DEPARTMENTS" DISABLE CONSTRAINT FK_DEPARTMENTS_EMPLOYEES;
INSERT INTO "DEPARTMENTS" VALUES(10,'Administration',200,1700);
INSERT INTO "DEPARTMENTS" VALUES(20,'Marketing',201,1800);
INSERT INTO "DEPARTMENTS" VALUES(30,'Purchasing',114,1700);
INSERT INTO "DEPARTMENTS" VALUES(40,'Human Resources',203,2400);
INSERT INTO "DEPARTMENTS" VALUES(50,'Shipping',121,1500);
INSERT INTO "DEPARTMENTS" VALUES(60,'IT',103,1400);
INSERT INTO "DEPARTMENTS" VALUES(70,'Public Relations',204,2700);
INSERT INTO "DEPARTMENTS" VALUES(80,'Sales',145,2500);
INSERT INTO "DEPARTMENTS" VALUES(90,'Executive',100,1700);
INSERT INTO "DEPARTMENTS" VALUES(100,'Finance',108,1700);
INSERT INTO "DEPARTMENTS" VALUES(110,'Accounting',205,1700);
INSERT INTO "DEPARTMENTS" VALUES(120,'Treasury',NULL,1700);
INSERT INTO "DEPARTMENTS" VALUES(130,'Corporate Tax',NULL,1700);
INSERT INTO "DEPARTMENTS" VALUES(140,'Control And Credit',NULL,1700);
INSERT INTO "DEPARTMENTS" VALUES(150,'Shareholder Services',NULL,1700);
INSERT INTO "DEPARTMENTS" VALUES(160,'Benefits',NULL,1700);
INSERT INTO "DEPARTMENTS" VALUES(170,'Manufacturing',NULL,1700);
INSERT INTO "DEPARTMENTS" VALUES(180,'Construction',NULL,1700);
INSERT INTO "DEPARTMENTS" VALUES(190,'Contracting',NULL,1700);
INSERT INTO "DEPARTMENTS" VALUES(200,'Operations',NULL,1700);
INSERT INTO "DEPARTMENTS" VALUES(210,'IT Support',NULL,1700);
INSERT INTO "DEPARTMENTS" VALUES(220,'NOC',NULL,1700);
INSERT INTO "DEPARTMENTS" VALUES(230,'IT Helpdesk',NULL,1700);
INSERT INTO "DEPARTMENTS" VALUES(240,'Government Sales',NULL,1700);
INSERT INTO "DEPARTMENTS" VALUES(250,'Retail Sales',NULL,1700);
INSERT INTO "DEPARTMENTS" VALUES(260,'Recruiting',NULL,1700);
INSERT INTO "DEPARTMENTS" VALUES(270,'Payroll',NULL,1700);
ALTER TABLE "DEPARTMENTS" DISABLE CONSTRAINT FK_DEPARTMENTS_EMPLOYEES;


INSERT INTO "JOBS" VALUES('AC_ACCOUNT','Public Accountant',4200,9000);
INSERT INTO "JOBS" VALUES('AC_MGR','Accounting Manager',8200,16000);
INSERT INTO "JOBS" VALUES('AD_ASST','Administration Assistant',3000,6000);
INSERT INTO "JOBS" VALUES('AD_PRES','President',20000,40000);
INSERT INTO "JOBS" VALUES('AD_VP','Administration Vice President',15000,30000);
INSERT INTO "JOBS" VALUES('FI_ACCOUNT','Accountant',4200,9000);
INSERT INTO "JOBS" VALUES('FI_MGR','Finance Manager',8200,16000);
INSERT INTO "JOBS" VALUES('HR_REP','Human Resources Representative',4000,9000);
INSERT INTO "JOBS" VALUES('IT_PROG','Programmer',4000,10000);
INSERT INTO "JOBS" VALUES('MK_MAN','Marketing Manager',9000,15000);
INSERT INTO "JOBS" VALUES('MK_REP','Marketing Representative',4000,9000);
INSERT INTO "JOBS" VALUES('PR_REP','Public Relations Representative',4500,10500);
INSERT INTO "JOBS" VALUES('PU_CLERK','Purchasing Clerk',2500,5500);
INSERT INTO "JOBS" VALUES('PU_MAN','Purchasing Manager',8000,15000);
INSERT INTO "JOBS" VALUES('SA_MAN','Sales Manager',10000,20000);
INSERT INTO "JOBS" VALUES('SA_REP','Sales Representative',6000,12000);
INSERT INTO "JOBS" VALUES('SH_CLERK','Shipping Clerk',2500,5500);
INSERT INTO "JOBS" VALUES('ST_CLERK','Stock Clerk',2000,5000);
INSERT INTO "JOBS" VALUES('ST_MAN','Stock Manager',5500,8500);

INSERT INTO "EMPLOYEES" VALUES(100,'Steven','King','SKING','515.123.4567',TO_DATE('1987-06-17','yyyy-mm-dd'),24000.00,NULL,'AD_PRES',NULL,90);
INSERT INTO "EMPLOYEES" VALUES(101,'Neena','Kochhar','NKOCHHAR','515.123.4568',TO_DATE('1989-09-21','yyyy-mm-dd'),17000.00,NULL,'AD_VP',100,90);
INSERT INTO "EMPLOYEES" VALUES(102,'Lex','De Haan','LDEHAAN','515.123.4569',TO_DATE('1993-01-13','yyyy-mm-dd'),17000.00,NULL,'AD_VP',100,90);
INSERT INTO "EMPLOYEES" VALUES(103,'Alexander','Hunold','AHUNOLD','590.423.4567',TO_DATE('1990-01-03','yyyy-mm-dd'),9000.00,NULL,'IT_PROG',102,60);
INSERT INTO "EMPLOYEES" VALUES(104,'Bruce','Ernst','BERNST','590.423.4568',TO_DATE('1991-05-21','yyyy-mm-dd'),6000.00,NULL,'IT_PROG',103,60);
INSERT INTO "EMPLOYEES" VALUES(105,'David','Austin','DAUSTIN','590.423.4569',TO_DATE('1997-06-25','yyyy-mm-dd'),4800.00,NULL,'IT_PROG',103,60);
INSERT INTO "EMPLOYEES" VALUES(106,'Valli','Pataballa','VPATABAL','590.423.4560',TO_DATE('1998-02-05','yyyy-mm-dd'),4800.00,NULL,'IT_PROG',103,60);
INSERT INTO "EMPLOYEES" VALUES(107,'Diana','Lorentz','DLORENTZ','590.423.5567',TO_DATE('1999-02-07','yyyy-mm-dd'),4200.00,NULL,'IT_PROG',103,60);
INSERT INTO "EMPLOYEES" VALUES(108,'Nancy','Greenberg','NGREENBE','515.124.4569',TO_DATE('1994-08-17','yyyy-mm-dd'),12000.00,NULL,'FI_MGR',101,100);
INSERT INTO "EMPLOYEES" VALUES(109,'Daniel','Faviet','DFAVIET','515.124.4169',TO_DATE('1994-08-16','yyyy-mm-dd'),9000.00,NULL,'FI_ACCOUNT',108,100);
INSERT INTO "EMPLOYEES" VALUES(110,'John','Chen','JCHEN','515.124.4269',TO_DATE('1997-09-28','yyyy-mm-dd'),8200.00,NULL,'FI_ACCOUNT',108,100);
INSERT INTO "EMPLOYEES" VALUES(111,'Ismael','Sciarra','ISCIARRA','515.124.4369',TO_DATE('1997-09-30','yyyy-mm-dd'),7700.00,NULL,'FI_ACCOUNT',108,100);
INSERT INTO "EMPLOYEES" VALUES(112,'Jose Manuel','Urman','JMURMAN','515.124.4469',TO_DATE('1998-03-07','yyyy-mm-dd'),7800.00,NULL,'FI_ACCOUNT',108,100);
INSERT INTO "EMPLOYEES" VALUES(113,'Luis','Popp','LPOPP','515.124.4567',TO_DATE('1999-12-07','yyyy-mm-dd'),6900.00,NULL,'FI_ACCOUNT',108,100);
INSERT INTO "EMPLOYEES" VALUES(114,'Den','Raphaely','DRAPHEAL','515.127.4561',TO_DATE('1994-12-07','yyyy-mm-dd'),11000.00,NULL,'PU_MAN',100,30);
INSERT INTO "EMPLOYEES" VALUES(115,'Alexander','Khoo','AKHOO','515.127.4562',TO_DATE('1995-05-18','yyyy-mm-dd'),3100.00,NULL,'PU_CLERK',114,30);
INSERT INTO "EMPLOYEES" VALUES(116,'Shelli','Baida','SBAIDA','515.127.4563',TO_DATE('1997-12-24','yyyy-mm-dd'),2900.00,NULL,'PU_CLERK',114,30);
INSERT INTO "EMPLOYEES" VALUES(117,'Sigal','Tobias','STOBIAS','515.127.4564',TO_DATE('1997-07-24','yyyy-mm-dd'),2800.00,NULL,'PU_CLERK',114,30);
INSERT INTO "EMPLOYEES" VALUES(118,'Guy','Himuro','GHIMURO','515.127.4565',TO_DATE('1998-11-15','yyyy-mm-dd'),2600.00,NULL,'PU_CLERK',114,30);
INSERT INTO "EMPLOYEES" VALUES(119,'Karen','Colmenares','KCOLMENA','515.127.4566',TO_DATE('1999-08-10','yyyy-mm-dd'),2500.00,NULL,'PU_CLERK',114,30);
INSERT INTO "EMPLOYEES" VALUES(120,'Matthew','Weiss','MWEISS','650.123.1234',TO_DATE('1996-07-18','yyyy-mm-dd'),8000.00,NULL,'ST_MAN',100,50);
INSERT INTO "EMPLOYEES" VALUES(121,'Adam','Fripp','AFRIPP','650.123.2234',TO_DATE('1997-04-10','yyyy-mm-dd'),8200.00,NULL,'ST_MAN',100,50);
INSERT INTO "EMPLOYEES" VALUES(122,'Payam','Kaufling','PKAUFLIN','650.123.3234',TO_DATE('1995-05-01','yyyy-mm-dd'),7900.00,NULL,'ST_MAN',100,50);
INSERT INTO "EMPLOYEES" VALUES(123,'Shanta','Vollman','SVOLLMAN','650.123.4234',TO_DATE('1997-10-10','yyyy-mm-dd'),6500.00,NULL,'ST_MAN',100,50);
INSERT INTO "EMPLOYEES" VALUES(124,'Kevin','Mourgos','KMOURGOS','650.123.5234',TO_DATE('1999-11-16','yyyy-mm-dd'),5800.00,NULL,'ST_MAN',100,50);
INSERT INTO "EMPLOYEES" VALUES(125,'Julia','Nayer','JNAYER','650.124.1214',TO_DATE('1997-07-16','yyyy-mm-dd'),3200.00,NULL,'ST_CLERK',120,50);
INSERT INTO "EMPLOYEES" VALUES(126,'Irene','Mikkilineni','IMIKKILI','650.124.1224',TO_DATE('1998-09-28','yyyy-mm-dd'),2700.00,NULL,'ST_CLERK',120,50);
INSERT INTO "EMPLOYEES" VALUES(127,'James','Landry','JLANDRY','650.124.1334',TO_DATE('1999-01-14','yyyy-mm-dd'),2400.00,NULL,'ST_CLERK',120,50);
INSERT INTO "EMPLOYEES" VALUES(128,'Steven','Markle','SMARKLE','650.124.1434',TO_DATE('2000-03-08','yyyy-mm-dd'),2200.00,NULL,'ST_CLERK',120,50);
INSERT INTO "EMPLOYEES" VALUES(129,'Laura','Bissot','LBISSOT','650.124.5234',TO_DATE('1997-08-20','yyyy-mm-dd'),3300.00,NULL,'ST_CLERK',121,50);
INSERT INTO "EMPLOYEES" VALUES(130,'Mozhe','Atkinson','MATKINSO','650.124.6234',TO_DATE('1997-10-30','yyyy-mm-dd'),2800.00,NULL,'ST_CLERK',121,50);
INSERT INTO "EMPLOYEES" VALUES(131,'James','Marlow','JAMRLOW','650.124.7234',TO_DATE('1997-02-16','yyyy-mm-dd'),2500.00,NULL,'ST_CLERK',121,50);
INSERT INTO "EMPLOYEES" VALUES(132,'TJ','Olson','TJOLSON','650.124.8234',TO_DATE('1999-04-10','yyyy-mm-dd'),2100.00,NULL,'ST_CLERK',121,50);
INSERT INTO "EMPLOYEES" VALUES(133,'Jason','Mallin','JMALLIN','650.127.1934',TO_DATE('1996-06-14','yyyy-mm-dd'),3300.00,NULL,'ST_CLERK',122,50);
INSERT INTO "EMPLOYEES" VALUES(134,'Michael','Rogers','MROGERS','650.127.1834',TO_DATE('1998-08-26','yyyy-mm-dd'),2900.00,NULL,'ST_CLERK',122,50);
INSERT INTO "EMPLOYEES" VALUES(135,'Ki','Gee','KGEE','650.127.1734',TO_DATE('1999-12-12','yyyy-mm-dd'),2400.00,NULL,'ST_CLERK',122,50);
INSERT INTO "EMPLOYEES" VALUES(136,'Hazel','Philtanker','HPHILTAN','650.127.1634',TO_DATE('2000-02-06','yyyy-mm-dd'),2200.00,NULL,'ST_CLERK',122,50);
INSERT INTO "EMPLOYEES" VALUES(137,'Renske','Ladwig','RLADWIG','650.121.1234',TO_DATE('1995-07-14','yyyy-mm-dd'),3600.00,NULL,'ST_CLERK',123,50);
INSERT INTO "EMPLOYEES" VALUES(138,'Stephen','Stiles','SSTILES','650.121.2034',TO_DATE('1997-10-26','yyyy-mm-dd'),3200.00,NULL,'ST_CLERK',123,50);
INSERT INTO "EMPLOYEES" VALUES(139,'John','Seo','JSEO','650.121.2019',TO_DATE('1998-02-12','yyyy-mm-dd'),2700.00,NULL,'ST_CLERK',123,50);
INSERT INTO "EMPLOYEES" VALUES(140,'Joshua','Patel','JPATEL','650.121.1834',TO_DATE('1998-04-06','yyyy-mm-dd'),2500.00,NULL,'ST_CLERK',123,50);
INSERT INTO "EMPLOYEES" VALUES(141,'Trenna','Rajs','TRAJS','650.121.8009',TO_DATE('1995-10-17','yyyy-mm-dd'),3500.00,NULL,'ST_CLERK',124,50);
INSERT INTO "EMPLOYEES" VALUES(142,'Curtis','Davies','CDAVIES','650.121.2994',TO_DATE('1997-01-29','yyyy-mm-dd'),3100.00,NULL,'ST_CLERK',124,50);
INSERT INTO "EMPLOYEES" VALUES(143,'Randall','Matos','RMATOS','650.121.2874',TO_DATE('1998-03-15','yyyy-mm-dd'),2600.00,NULL,'ST_CLERK',124,50);
INSERT INTO "EMPLOYEES" VALUES(144,'Peter','Vargas','PVARGAS','650.121.2004',TO_DATE('1998-07-09','yyyy-mm-dd'),2500.00,NULL,'ST_CLERK',124,50);
INSERT INTO "EMPLOYEES" VALUES(145,'John','Russell','JRUSSEL','011.44.1344.429268',TO_DATE('1996-10-01','yyyy-mm-dd'),14000.00,0.40,'SA_MAN',100,80);
INSERT INTO "EMPLOYEES" VALUES(146,'Karen','Partners','KPARTNER','011.44.1344.467268',TO_DATE('1997-01-05','yyyy-mm-dd'),13500.00,0.30,'SA_MAN',100,80);
INSERT INTO "EMPLOYEES" VALUES(147,'Alberto','Errazuriz','AERRAZUR','011.44.1344.429278',TO_DATE('1997-03-10','yyyy-mm-dd'),12000.00,0.30,'SA_MAN',100,80);
INSERT INTO "EMPLOYEES" VALUES(148,'Gerald','Cambrault','GCAMBRAU','011.44.1344.619268',TO_DATE('1999-10-15','yyyy-mm-dd'),11000.00,0.30,'SA_MAN',100,80);
INSERT INTO "EMPLOYEES" VALUES(149,'Eleni','Zlotkey','EZLOTKEY','011.44.1344.429018',TO_DATE('2000-01-29','yyyy-mm-dd'),10500.00,0.20,'SA_MAN',100,80);
INSERT INTO "EMPLOYEES" VALUES(150,'Peter','Tucker','PTUCKER','011.44.1344.129268',TO_DATE('1997-01-30','yyyy-mm-dd'),10000.00,0.30,'SA_REP',145,80);
INSERT INTO "EMPLOYEES" VALUES(151,'David','Bernstein','DBERNSTE','011.44.1344.345268',TO_DATE('1997-03-24','yyyy-mm-dd'),9500.00,0.25,'SA_REP',145,80);
INSERT INTO "EMPLOYEES" VALUES(152,'Peter','Hall','PHALL','011.44.1344.478968',TO_DATE('1997-08-20','yyyy-mm-dd'),9000.00,0.25,'SA_REP',145,80);
INSERT INTO "EMPLOYEES" VALUES(153,'Christopher','Olsen','COLSEN','011.44.1344.498718',TO_DATE('1998-03-30','yyyy-mm-dd'),8000.00,0.20,'SA_REP',145,80);
INSERT INTO "EMPLOYEES" VALUES(154,'Nanette','Cambrault','NCAMBRAU','011.44.1344.987668',TO_DATE('1998-12-09','yyyy-mm-dd'),7500.00,0.20,'SA_REP',145,80);
INSERT INTO "EMPLOYEES" VALUES(155,'Oliver','Tuvault','OTUVAULT','011.44.1344.486508',TO_DATE('1999-11-23','yyyy-mm-dd'),7000.00,0.15,'SA_REP',145,80);
INSERT INTO "EMPLOYEES" VALUES(156,'Janette','King','JKING','011.44.1345.429268',TO_DATE('1996-01-30','yyyy-mm-dd'),10000.00,0.35,'SA_REP',146,80);
INSERT INTO "EMPLOYEES" VALUES(157,'Patrick','Sully','PSULLY','011.44.1345.929268',TO_DATE('1996-03-04','yyyy-mm-dd'),9500.00,0.35,'SA_REP',146,80);
INSERT INTO "EMPLOYEES" VALUES(158,'Allan','McEwen','AMCEWEN','011.44.1345.829268',TO_DATE('1996-08-01','yyyy-mm-dd'),9000.00,0.35,'SA_REP',146,80);
INSERT INTO "EMPLOYEES" VALUES(159,'Lindsey','Smith','LSMITH','011.44.1345.729268',TO_DATE('1997-03-10','yyyy-mm-dd'),8000.00,0.30,'SA_REP',146,80);
INSERT INTO "EMPLOYEES" VALUES(160,'Louise','Doran','LDORAN','011.44.1345.629268',TO_DATE('1997-12-15','yyyy-mm-dd'),7500.00,0.30,'SA_REP',146,80);
INSERT INTO "EMPLOYEES" VALUES(161,'Sarath','Sewall','SSEWALL','011.44.1345.529268',TO_DATE('1998-11-03','yyyy-mm-dd'),7000.00,0.25,'SA_REP',146,80);
INSERT INTO "EMPLOYEES" VALUES(162,'Clara','Vishney','CVISHNEY','011.44.1346.129268',TO_DATE('1997-11-11','yyyy-mm-dd'),10500.00,0.25,'SA_REP',147,80);
INSERT INTO "EMPLOYEES" VALUES(163,'Danielle','Greene','DGREENE','011.44.1346.229268',TO_DATE('1999-03-19','yyyy-mm-dd'),9500.00,0.15,'SA_REP',147,80);
INSERT INTO "EMPLOYEES" VALUES(164,'Mattea','Marvins','MMARVINS','011.44.1346.329268',TO_DATE('2000-01-24','yyyy-mm-dd'),7200.00,0.10,'SA_REP',147,80);
INSERT INTO "EMPLOYEES" VALUES(165,'David','Lee','DLEE','011.44.1346.529268',TO_DATE('2000-02-23','yyyy-mm-dd'),6800.00,0.10,'SA_REP',147,80);
INSERT INTO "EMPLOYEES" VALUES(166,'Sundar','Ande','SANDE','011.44.1346.629268',TO_DATE('2000-03-24','yyyy-mm-dd'),6400.00,0.10,'SA_REP',147,80);
INSERT INTO "EMPLOYEES" VALUES(167,'Amit','Banda','ABANDA','011.44.1346.729268',TO_DATE('2000-04-21','yyyy-mm-dd'),6200.00,0.10,'SA_REP',147,80);
INSERT INTO "EMPLOYEES" VALUES(168,'Lisa','Ozer','LOZER','011.44.1343.929268',TO_DATE('1997-03-11','yyyy-mm-dd'),11500.00,0.25,'SA_REP',148,80);
INSERT INTO "EMPLOYEES" VALUES(169,'Harrison','Bloom','HBLOOM','011.44.1343.829268',TO_DATE('1998-03-23','yyyy-mm-dd'),10000.00,0.20,'SA_REP',148,80);
INSERT INTO "EMPLOYEES" VALUES(170,'Tayler','Fox','TFOX','011.44.1343.729268',TO_DATE('1998-01-24','yyyy-mm-dd'),9600.00,0.20,'SA_REP',148,80);
INSERT INTO "EMPLOYEES" VALUES(171,'William','Smith','WSMITH','011.44.1343.629268',TO_DATE('1999-02-23','yyyy-mm-dd'),7400.00,0.15,'SA_REP',148,80);
INSERT INTO "EMPLOYEES" VALUES(172,'Elizabeth','Bates','EBATES','011.44.1343.529268',TO_DATE('1999-03-24','yyyy-mm-dd'),7300.00,0.15,'SA_REP',148,80);
INSERT INTO "EMPLOYEES" VALUES(173,'Sundita','Kumar','SKUMAR','011.44.1343.329268',TO_DATE('2000-04-21','yyyy-mm-dd'),6100.00,0.10,'SA_REP',148,80);
INSERT INTO "EMPLOYEES" VALUES(174,'Ellen','Abel','EABEL','011.44.1644.429267',TO_DATE('1996-05-11','yyyy-mm-dd'),11000.00,0.30,'SA_REP',149,80);
INSERT INTO "EMPLOYEES" VALUES(175,'Alyssa','Hutton','AHUTTON','011.44.1644.429266',TO_DATE('1997-03-19','yyyy-mm-dd'),8800.00,0.25,'SA_REP',149,80);
INSERT INTO "EMPLOYEES" VALUES(176,'Jonathon','Taylor','JTAYLOR','011.44.1644.429265',TO_DATE('1998-03-24','yyyy-mm-dd'),8600.00,0.20,'SA_REP',149,80);
INSERT INTO "EMPLOYEES" VALUES(177,'Jack','Livingston','JLIVINGS','011.44.1644.429264',TO_DATE('1998-04-23','yyyy-mm-dd'),8400.00,0.20,'SA_REP',149,80);
INSERT INTO "EMPLOYEES" VALUES(178,'Kimberely','Grant','KGRANT','011.44.1644.429263',TO_DATE('1999-05-24','yyyy-mm-dd'),7000.00,0.15,'SA_REP',149,80);
INSERT INTO "EMPLOYEES" VALUES(179,'Charles','Johnson','CJOHNSON','011.44.1644.429262',TO_DATE('2000-01-04','yyyy-mm-dd'),6200.00,0.10,'SA_REP',149,80);
INSERT INTO "EMPLOYEES" VALUES(180,'Winston','Taylor','WTAYLOR','650.507.9876',TO_DATE('1998-01-24','yyyy-mm-dd'),3200.00,NULL,'SH_CLERK',120,50);
INSERT INTO "EMPLOYEES" VALUES(181,'Jean','Fleaur','JFLEAUR','650.507.9877',TO_DATE('1998-02-23','yyyy-mm-dd'),3100.00,NULL,'SH_CLERK',120,50);
INSERT INTO "EMPLOYEES" VALUES(182,'Martha','Sullivan','MSULLIVA','650.507.9878',TO_DATE('1999-06-21','yyyy-mm-dd'),2500.00,NULL,'SH_CLERK',120,50);
INSERT INTO "EMPLOYEES" VALUES(183,'Girard','Geoni','GGEONI','650.507.9879',TO_DATE('2000-02-03','yyyy-mm-dd'),2800.00,NULL,'SH_CLERK',120,50);
INSERT INTO "EMPLOYEES" VALUES(184,'Nandita','Sarchand','NSARCHAN','650.509.1876',TO_DATE('1996-01-27','yyyy-mm-dd'),4200.00,NULL,'SH_CLERK',121,50);
INSERT INTO "EMPLOYEES" VALUES(185,'Alexis','Bull','ABULL','650.509.2876',TO_DATE('1997-02-20','yyyy-mm-dd'),4100.00,NULL,'SH_CLERK',121,50);
INSERT INTO "EMPLOYEES" VALUES(186,'Julia','Dellinger','JDELLING','650.509.3876',TO_DATE('1998-06-24','yyyy-mm-dd'),3400.00,NULL,'SH_CLERK',121,50);
INSERT INTO "EMPLOYEES" VALUES(187,'Anthony','Cabrio','ACABRIO','650.509.4876',TO_DATE('1999-02-07','yyyy-mm-dd'),3000.00,NULL,'SH_CLERK',121,50);
INSERT INTO "EMPLOYEES" VALUES(188,'Kelly','Chung','KCHUNG','650.505.1876',TO_DATE('1997-06-14','yyyy-mm-dd'),3800.00,NULL,'SH_CLERK',122,50);
INSERT INTO "EMPLOYEES" VALUES(189,'Jennifer','Dilly','JDILLY','650.505.2876',TO_DATE('1997-08-13','yyyy-mm-dd'),3600.00,NULL,'SH_CLERK',122,50);
INSERT INTO "EMPLOYEES" VALUES(190,'Timothy','Gates','TGATES','650.505.3876',TO_DATE('1998-07-11','yyyy-mm-dd'),2900.00,NULL,'SH_CLERK',122,50);
INSERT INTO "EMPLOYEES" VALUES(191,'Randall','Perkins','RPERKINS','650.505.4876',TO_DATE('1999-12-19','yyyy-mm-dd'),2500.00,NULL,'SH_CLERK',122,50);
INSERT INTO "EMPLOYEES" VALUES(192,'Sarah','Bell','SBELL','650.501.1876',TO_DATE('1996-02-04','yyyy-mm-dd'),4000.00,NULL,'SH_CLERK',123,50);
INSERT INTO "EMPLOYEES" VALUES(193,'Britney','Everett','BEVERETT','650.501.2876',TO_DATE('1997-03-03','yyyy-mm-dd'),3900.00,NULL,'SH_CLERK',123,50);
INSERT INTO "EMPLOYEES" VALUES(194,'Samuel','McCain','SMCCAIN','650.501.3876',TO_DATE('1998-07-01','yyyy-mm-dd'),3200.00,NULL,'SH_CLERK',123,50);
INSERT INTO "EMPLOYEES" VALUES(195,'Vance','Jones','VJONES','650.501.4876',TO_DATE('1999-03-17','yyyy-mm-dd'),2800.00,NULL,'SH_CLERK',123,50);
INSERT INTO "EMPLOYEES" VALUES(196,'Alana','Walsh','AWALSH','650.507.9811',TO_DATE('1998-04-24','yyyy-mm-dd'),3100.00,NULL,'SH_CLERK',124,50);
INSERT INTO "EMPLOYEES" VALUES(197,'Kevin','Feeney','KFEENEY','650.507.9822',TO_DATE('1998-05-23','yyyy-mm-dd'),3000.00,NULL,'SH_CLERK',124,50);
INSERT INTO "EMPLOYEES" VALUES(198,'Donald','OConnell','DOCONNEL','650.507.9833',TO_DATE('1999-06-21','yyyy-mm-dd'),2600.00,NULL,'SH_CLERK',124,50);
INSERT INTO "EMPLOYEES" VALUES(199,'Douglas','Grant','DGRANT','650.507.9844',TO_DATE('2000-01-13','yyyy-mm-dd'),2600.00,NULL,'SH_CLERK',124,50);
INSERT INTO "EMPLOYEES" VALUES(200,'Jennifer','Whalen','JWHALEN','515.123.4444',TO_DATE('1987-09-17','yyyy-mm-dd'),4400.00,NULL,'AD_ASST',101,10);
INSERT INTO "EMPLOYEES" VALUES(201,'Michael','Hartstein','MHARTSTE','515.123.5555',TO_DATE('1996-02-17','yyyy-mm-dd'),13000.00,NULL,'MK_MAN',100,20);
INSERT INTO "EMPLOYEES" VALUES(202,'Pat','Fay','PFAY','603.123.6666',TO_DATE('1997-08-17','yyyy-mm-dd'),6000.00,NULL,'MK_REP',201,20);
INSERT INTO "EMPLOYEES" VALUES(203,'Susan','Mavris','SMAVRIS','515.123.7777',TO_DATE('1994-06-07','yyyy-mm-dd'),6500.00,NULL,'HR_REP',101,40);
INSERT INTO "EMPLOYEES" VALUES(204,'Hermann','Baer','HBAER','515.123.8888',TO_DATE('1994-06-07','yyyy-mm-dd'),10000.00,NULL,'PR_REP',101,70);
INSERT INTO "EMPLOYEES" VALUES(205,'Shelley','Higgins','SHIGGINS','515.123.8080',TO_DATE('1994-06-07','yyyy-mm-dd'),12000.00,NULL,'AC_MGR',101,110);
INSERT INTO "EMPLOYEES" VALUES(206,'William','Gietz','WGIETZ','515.123.8181',TO_DATE('1994-06-07','yyyy-mm-dd'),8300.00,NULL,'AC_ACCOUNT',205,110);

ALTER TABLE "DEPARTMENTS" ENABLE CONSTRAINT FK_DEPARTMENTS_EMPLOYEES;
commit;
