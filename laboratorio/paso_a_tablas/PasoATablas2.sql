/**Documento Paso A tablas 2**/

create table entrada
(
codentrada varchar(8),
precio decimal(2,2),
constraint pk_entrada primary key (codentrada)
);

create table pelicula(
codpelicula varchar(8),
titulo varchar(20),
duracion decimal(3,0),
tipo varchar(8),
constraint pk_pelicula primary key (codpelicula),
constraint uq_titulo unique(titulo),
constraint in_tipo check ( tipo in ('ficcion', 'aventuras' , 'terror'))
);

create table sala(
codsala varchar(8),
aforo decimal(2,0),
constraint pk_sala primary key (codsala)
);

create table cine(
codcine varchar(8),
localidad varchar(20),
constraint pk_cine primary key (codcine)
);

create table proyecta(
sesion varchar(8),
fecha DATE,
codsala varchar(8),
codpelicula varchar(8),
entrada_vendidas varchar(8),
constraint pk_proyecta primary key (sesion,fecha,codsala,codpelicula),
constraint fg_proyecta_sala foreign key (codsala) references sala(codsala),
constraint fg_proyecta_pelicula foreign key (codpelicula) references pelicula(codpelicula),
constraint ck_proyecta_sesion check ( sesion in ('5','7','10') )
);

create table vendida(
codentrada varchar(8),
sesion varchar(8) not null,
fecha DATE  not null,
codsala varchar(8) not null,
codpelicula varchar(8)  not null,
constraint pk_vendida primary key (codentrada),
constraint fg_vendida_entrada foreign key (codentrada) references entrada(codentrada),
constraint fg_vendida_proyecta foreign key (sesion,fecha,codsala,codpelicula) references proyecta(sesion,fecha,codsala,codpelicula)
);

create table esta_dividido(
codsala varchar(8),
codcine varchar(8) not null,
constraint pk_esta_dividido primary key (codsala),
constraint fg_esta_dividido_sala foreign key (codsala) references sala(codsala),
constraint fg_esta_dividido_cine foreign key (codcine) references cine(codcine)
);

create table es_secuela(
codpelicula varchar(8),
codpeliculaOriginal varchar(8),
constraint pk_es_secuela primary key (codpelicula),
constraint fg_es_secuela foreign key (codpeliculaOriginal) references pelicula(codpelicula),
constraint fg_es_secuela_original foreign key (codpelicula) references pelicula(codpelicula)
);

create table cine3d(
codcine varchar(8),
numsalas varchar(8),
constraint pk_cine3d primary key (codcine),
constraint fg_cine3d_cine foreign key (codcine) references cine(codcine)
);

