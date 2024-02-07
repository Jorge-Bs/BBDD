/*Creacion de la tabla Alumno*/
create table alumno (
dnia VARCHAR(8),
noma VARCHAR(20),
apella VARCHAR(20),
domicilioa VARCHAR(40),
f_nacimiento date,
f_ingreso date,
constraint pk_alumno primary key(dnia)
);

/*creacion de la tabla asignatura*/

create table asignatura (
codasig VARCHAR(8),
nomasig VARCHAR(20),
curso decimal(1,0) not null,
creditos decimal(2,0),
tipo varchar(20) not null,
codcar VARCHAR(8) not null,
constraint pk_asignatura primary key(codasig),
constraint uq_asignatura_nomasig unique (nomasig),/*llave candidata*/
constraint ck_asigantura_tipo CHECK (tipo in ('obligatoria','optativa','libre')),
constraint fk_asignatura_carrera foreign key (codcar) REFERENCES carrera(codcar)
);


/*tabla de relacion*/
create table esta_matriculado(
dnia VARCHAR(8),
codasig VARCHAR(8),
CONSTRAINT pk_esta_matriculado primary key(dnia,codasig),
CONSTRAINT fk_esta_matriculado_alumno FOREIGN KEY (dnia) REFERENCES alumno(dnia),
CONSTRAINT fk_esta_matriculado_asignatura FOREIGN KEY (codasig) REFERENCES asignatura(codasig)
);

/*tabla carrera*/
create table carrera (
codcar VARCHAR(8),
nombrec VARCHAR(20),
duracion decimal(1,0),
constraint pk_carrera primary key(codcar)
);

/*borra la tabla*/
drop table asignatura;

/*profesor*/
create table profesor (
dnip VARCHAR(8),
nombrep VARCHAR(20),
apelidop VARCHAR(20),
domiciliop VARCHAR(20),
constraint pk_profesor primary key(dnip)
);

/*relacion profesor asignatura*/
create table imparte(
codasig VARCHAR(8),
dnip VARCHAR(8),
constraint pk_imparte primary key (codasig,dnip),
CONSTRAINT fk_imparte_profesor FOREIGN KEY (dnip) REFERENCES profesor(dnip),
CONSTRAINT fk_imparte_asignatura FOREIGN KEY (codasig) REFERENCES asignatura(codasig)
);


create table califica(
codasig VARCHAR(8),
dnip VARCHAR(8) not null,
dnia VARCHAR(8),
nota decimal(3,1),
fecha_calificacion date,
constraint pk_califica primary key (dnia,codasig),
CONSTRAINT fk_califica_profesor FOREIGN KEY (dnip) REFERENCES profesor(dnip),
CONSTRAINT fk_califica_asignatura FOREIGN KEY (codasig) REFERENCES asignatura(codasig),
CONSTRAINT fk_califica_alumno FOREIGN KEY (dnia) REFERENCES alumno(dnia)
);


create table calificam2(
codasig VARCHAR(8),
dnip VARCHAR(8) not null,
dnia VARCHAR(8),
nota decimal(3,1),
fecha_calificacion date,
constraint pk_calificam2 primary key (dnia,codasig,dnip),
CONSTRAINT fk_calificam2_imparte FOREIGN KEY (dnip,codasig) REFERENCES imparte(dnip,codasig),
CONSTRAINT fk_calificam2_alumno FOREIGN KEY (dnia) REFERENCES alumno(dnia)
);