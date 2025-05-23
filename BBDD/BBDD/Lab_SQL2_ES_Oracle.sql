drop table ventas;
drop table distribucion;
drop table marco;
drop table clientes;
drop table concesionarios;
drop table coches;
drop table marcas;


CREATE TABLE "MARCAS" (
	CIFM VARCHAR(255),
	NOMBREM VARCHAR(255),
	CIUDADM VARCHAR(255),
	CONSTRAINT PK_MARCAS PRIMARY KEY (CIFM)
);

CREATE TABLE "COCHES" (
	CODCOCHE INTEGER,
	NOMBRECH VARCHAR(255),
	MODELO VARCHAR(255),
	CONSTRAINT PK_COCHES PRIMARY KEY (CODCOCHE)
);

CREATE TABLE "CONCESIONARIOS" (
	CIFC VARCHAR(255),
	NOMBREC VARCHAR(255),
	CIUDADC VARCHAR(255),
	CONSTRAINT PK_CONCESIONARIOS PRIMARY KEY (CIFC)
);

CREATE TABLE "CLIENTES" (
	DNI VARCHAR(9),
	NOMBRE VARCHAR(40),
	APELLIDO VARCHAR(40),
	CIUDAD VARCHAR(25),
	CONSTRAINT PK_CLIENTES PRIMARY KEY (DNI)
);

CREATE TABLE "MARCO" (
	CIFM VARCHAR(255),
	CODCOCHE INTEGER,
	CONSTRAINT PK_MARCO PRIMARY KEY (CIFM,CODCOCHE),
	CONSTRAINT FK_MARCO_MARCAS FOREIGN KEY (CIFM) REFERENCES MARCAS (CIFM),
	CONSTRAINT FK_MARCO_COCHES FOREIGN KEY (CODCOCHE) REFERENCES COCHES (CODCOCHE)
);

CREATE TABLE "DISTRIBUCION" (
	CIFC VARCHAR(255),
	CODCOCHE INTEGER,
	CANTIDAD DECIMAL(20),
	CONSTRAINT PK_DISTRIBUCION PRIMARY KEY (CIFC,CODCOCHE),
	CONSTRAINT FK_DISTRIBUCION_CONCESIONARIOS FOREIGN KEY (CIFC) REFERENCES CONCESIONARIOS (CIFC),
	CONSTRAINT FK_DISTRIBUCION_COCHES FOREIGN KEY (CODCOCHE) REFERENCES COCHES (CODCOCHE)
);

CREATE TABLE "VENTAS" (
	CIFC VARCHAR(255),
	DNI VARCHAR(255),
	CODCOCHE INTEGER,
	COLOR VARCHAR(255),
	CONSTRAINT PK_VENTAS PRIMARY KEY (CIFC,DNI,CODCOCHE),
	CONSTRAINT FK_VENTAS_CONCESIONARIOS FOREIGN KEY (CIFC) REFERENCES CONCESIONARIOS (CIFC),
	CONSTRAINT FK_VENTAS_CLIENTES FOREIGN KEY (DNI) REFERENCES CLIENTES (DNI),
	CONSTRAINT FK_VENTAS_COCHES FOREIGN KEY (CODCOCHE) REFERENCES COCHES (CODCOCHE)
);

INSERT INTO "MARCAS" VALUES('1','seat','madrid');
INSERT INTO "MARCAS" VALUES('2','renault','barcelona');
INSERT INTO "MARCAS" VALUES('3','citroen','valencia');
INSERT INTO "MARCAS" VALUES('4','audi','madrid');
INSERT INTO "MARCAS" VALUES('5','open','bilbao');
INSERT INTO "MARCAS" VALUES('6','bmw','barcelona');

INSERT INTO "COCHES" VALUES(1,'ibiza','glx');
INSERT INTO "COCHES" VALUES(10,'zx','16V');
INSERT INTO "COCHES" VALUES(11,'zx','td');
INSERT INTO "COCHES" VALUES(12,'xantia','gtd');
INSERT INTO "COCHES" VALUES(13,'a4','1.8');
INSERT INTO "COCHES" VALUES(14,'a4','2.8');
INSERT INTO "COCHES" VALUES(15,'astra','caravan');
INSERT INTO "COCHES" VALUES(16,'astra','gti');
INSERT INTO "COCHES" VALUES(17,'corsa','1.4');
INSERT INTO "COCHES" VALUES(18,'300','316i');
INSERT INTO "COCHES" VALUES(19,'500','525i');
INSERT INTO "COCHES" VALUES(2,'ibiza','gti');
INSERT INTO "COCHES" VALUES(20,'700','750i');
INSERT INTO "COCHES" VALUES(3,'ibiza','gtd');
INSERT INTO "COCHES" VALUES(4,'toledo','gtd');
INSERT INTO "COCHES" VALUES(5,'cordoba','gti');
INSERT INTO "COCHES" VALUES(6,'megane','1.6');
INSERT INTO "COCHES" VALUES(7,'megane','gti');
INSERT INTO "COCHES" VALUES(8,'laguna','gtd');
INSERT INTO "COCHES" VALUES(9,'laguna','td');

INSERT INTO "CONCESIONARIOS" VALUES('1','acar','madrid');
INSERT INTO "CONCESIONARIOS" VALUES('2','bcar','madrid');
INSERT INTO "CONCESIONARIOS" VALUES('3','ccar','barcelona');
INSERT INTO "CONCESIONARIOS" VALUES('4','dcar','valencia');
INSERT INTO "CONCESIONARIOS" VALUES('5','ecar','bilbao');

INSERT INTO "CLIENTES" VALUES('1','luis','garcia','madrid');
INSERT INTO "CLIENTES" VALUES('2','antonio','lopez','valencia');
INSERT INTO "CLIENTES" VALUES('3','juan','martin','madrid');
INSERT INTO "CLIENTES" VALUES('4','maria','garcia','madrid');
INSERT INTO "CLIENTES" VALUES('5','javier','gonzalez','barcelona');
INSERT INTO "CLIENTES" VALUES('6','ana','lopez','barcelona');

INSERT INTO "MARCO" VALUES('1',1);
INSERT INTO "MARCO" VALUES('1',2);
INSERT INTO "MARCO" VALUES('1',3);
INSERT INTO "MARCO" VALUES('1',4);
INSERT INTO "MARCO" VALUES('1',5);
INSERT INTO "MARCO" VALUES('2',6);
INSERT INTO "MARCO" VALUES('2',7);
INSERT INTO "MARCO" VALUES('2',8);
INSERT INTO "MARCO" VALUES('2',9);
INSERT INTO "MARCO" VALUES('3',10);
INSERT INTO "MARCO" VALUES('3',12);
INSERT INTO "MARCO" VALUES('3',11);
INSERT INTO "MARCO" VALUES('4',13);
INSERT INTO "MARCO" VALUES('4',14);
INSERT INTO "MARCO" VALUES('5',15);
INSERT INTO "MARCO" VALUES('5',16);
INSERT INTO "MARCO" VALUES('5',17);
INSERT INTO "MARCO" VALUES('6',19);
INSERT INTO "MARCO" VALUES('6',18);
INSERT INTO "MARCO" VALUES('6',20);

INSERT INTO "DISTRIBUCION" VALUES('1',1,3);
INSERT INTO "DISTRIBUCION" VALUES('1',5,7);
INSERT INTO "DISTRIBUCION" VALUES('1',6,7);
INSERT INTO "DISTRIBUCION" VALUES('2',6,5);
INSERT INTO "DISTRIBUCION" VALUES('2',8,10);
INSERT INTO "DISTRIBUCION" VALUES('2',9,10);
INSERT INTO "DISTRIBUCION" VALUES('3',10,5);
INSERT INTO "DISTRIBUCION" VALUES('3',12,5);
INSERT INTO "DISTRIBUCION" VALUES('3',11,3);
INSERT INTO "DISTRIBUCION" VALUES('4',13,10);
INSERT INTO "DISTRIBUCION" VALUES('4',14,5);
INSERT INTO "DISTRIBUCION" VALUES('5',16,20);
INSERT INTO "DISTRIBUCION" VALUES('5',15,10);
INSERT INTO "DISTRIBUCION" VALUES('5',17,8);

INSERT INTO "VENTAS" VALUES('1','2',5,'rojo');
INSERT INTO "VENTAS" VALUES('1','1',1,'amarillo');
INSERT INTO "VENTAS" VALUES('1','1',3,'blanco');
INSERT INTO "VENTAS" VALUES('2','1',2,'gris');
INSERT INTO "VENTAS" VALUES('2','3',8,'blanco');
INSERT INTO "VENTAS" VALUES('2','1',6,'rojo');
INSERT INTO "VENTAS" VALUES('3','4',11,'rojo');
INSERT INTO "VENTAS" VALUES('4','5',14,'verde');
INSERT INTO "VENTAS" VALUES('4','6',12,'azul');
commit;