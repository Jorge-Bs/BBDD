create table estacion(
    enombre varchar(20),
    transformadores decimal(3,0),
    constraint pk_estacion primary key (enombre)
);

create table red_distribucion(
    numred decimal(3,0),
    longitudmaxima decimal(3,0),
    enombre varchar(20) not null ,
    constraint pk_red_distribucion primary key (numred),
    constraint fg_red_distribucion_estacion foreign key (enombre)
                             references estacion(enombre),
    constraint ck_longitud_maxima check (longitudmaxima>=0)
);

create table envia_energia(
    numred_red_emisora decimal(3,0),
    numred_red_receptora decimal(3,0),
    volumen decimal(5,0) not null,
    constraint pk_envia_energia primary key (numred_red_emisora,numred_red_receptora),
    constraint fg_envia_energia_red_emisora foreign key (numred_red_emisora) references red_distribucion(numred),
    constraint fg_envia_energia_red_receptora foreign key (numred_red_receptora) references red_distribucion(numred)
);

create table compania(
    cnombre varchar(20),
    capitalsocial varchar(20) not null,
    constraint pk_compania primary key (cnombre)
);

create table pertenece(
    cnombre varchar(20),
    numred decimal(3,0),
    numacciones decimal(3,0),
    constraint pk_pertenece primary key (numred,cnombre),
    constraint fk_pertenece_red_distribucion foreign key (numred) references red_distribucion(numred),
    constraint fk_pertenece_compania foreign key (cnombre) references compania(cnombre),
    constraint ck_acciones check ( numacciones > 0 )
);

create table linea(
    nlinea decimal (3,0),
    longitud decimal (3,0) not null,
    numred decimal (3,0),
    constraint pk_linea primary key (nlinea,numred),
    constraint fg_linea_red_distribucion foreign key (numred) references red_distribucion(numred),
    constraint ck_longitud check ( longitud>= 0 )
);

create table subestacion(
    nsubestacion varchar(8),
    capacidad decimal(3,0) not null,
    nlinea decimal (3,0),
    numred decimal (3,0),
    constraint pk_subestacion primary key (nsubestacion),
    constraint fg_subestacion_linea foreign key (nlinea,numred) references linea(nlinea,numred),
    constraint ch_capacidad check ( capacidad >=0 )
);

create table zona(
    zcodigo varchar(20),
    consumomedio decimal(5,2) not null,
    consIntituciones decimal(5,2) not null,
    consParticulares decimal (5,2) not null,
    consEmpresas decimal(5,2) not null,
    pcodigo varchar(8) not null,
    constraint pk_zona primary key (zcodigo),
    constraint ch_consumomedio check ( consumomedio >=0 ),
    constraint ch_consIntituciones check ( consIntituciones >=0 ),
    constraint ch_consParticulares check ( consParticulares ),
    constraint ch_consEmpresas check ( consEmpresas >=0 ),
    constraint fk_zona_provincia foreign key (pcodigo) references provincia(pcodigo)
);

create table distribuye(
    nsubestacion varchar(8),
    zcodigo varchar(20),
    cantidad decimal (6,2) not null,
    fecha date not null,
    constraint pk_distribuye primary key (nsubestacion,zcodigo),
    constraint fg_distribuye_zona foreign key (zcodigo) references zona(zcodigo),
    constraint fg_distribuye_subestacion foreign key (nsubestacion) references distribuye(nsubestacion)
);


create table provincia(
    pcodigo varchar(8),
    nombre varchar(40) not null,
    constraint pk_provincia primary key (pcodigo)
);

create table productor(
    pnombre varchar(20),
    prodmedia decimal(8,0) not null,
    prodmaxima decimal(8,0) not null,
    fecha date not null,
    constraint pk_productor primary key (pnombre),
    constraint ch_prodmedia check ( prodmedia>=0 ),
    constraint ch_prodmaxima check ( prodmaxima >=0 )
);

create table entrega(
    pnombre varchar(20),
    enombre varchar(20),
    cantidad decimal(8,2) not null,
    fecha date not null,
    constraint pk_entrega primary key (pnombre,enombre),
    constraint fg_entrega_estacion foreign key (enombre) references estacion(enombre),
    constraint fg_entrega_productor foreign key (pnombre) references productor(pnombre),
    constraint ch_cantidad check ( cantidad >=0 )
);

create table hidroelectrica(
    pnombre varchar(20),
    ocupacion decimal(5,2) not  null,
    capmaxima decimal(5,2) not null,
    numturbinas decimal(3) not null,
    constraint pk_hidroelectrica primary key (pnombre),
    constraint fg_hidroelectrica foreign key (pnombre) references productor(pnombre)
);

create table nuclear(
    pnombre varchar(20),
    numreactores decimal(3,0) not null ,
    plutonio decimal(3,0) not null ,
    residuos decimal(3,0) not null ,
    constraint pk_nuclear primary key (pnombre),
    constraint fg_nuclear foreign key (pnombre) references productor(pnombre)
);

create table solar(
    pnombre varchar(20),
    paneles decimal(3,0) not null,
    horassol decimal(3,0) not null,
    tipo varchar(8),
    constraint pk_solar primary key (pnombre),
    constraint fg_solar foreign key (pnombre) references productor(pnombre),
    constraint ch_tipo check ( tipo in ('fotovoltaica','termodinamica') )
);

create table termica(
    pnombre varchar(20),
    hornos decimal(3,0) not null,
    carbon decimal(3,0) not null,
    gases decimal(3,0) not null,
    constraint pk_termica primary key (pnombre),
    constraint fg_termica foreign key (pnombre) references productor(pnombre)
);

create table transportista(
    tnombre varchar(20),
    matricula varchar(20),
    horasconducidas decimal(8,2) not null,
    constraint pk_transportista primary key (tnombre,matricula),
    constraint ch_horasconducidas check ( horasconducidas>=0 )
);

create table suministrador(
    snombre varchar(20),
    pais varchar(20),
    stock decimal(8,2) not null ,
    constraint pk_suministrador primary key (snombre,pais),
    constraint ch_stock check ( stock>=0 )
);

create table compra(
    pnombre varchar(20),
    tnombre varchar(20),
    matricula varchar(20),
    snombre varchar(20),
    pais varchar(20),
    cantidad decimal(8,0) not null,
    constraint pk_compra primary key (pnombre,tnombre,matricula,snombre,pais),
    constraint fg_compra_productor foreign key (pnombre) references productor(pnombre),
    constraint fg_compra_trasnportista foreign key (tnombre,matricula) references transportista(tnombre,matricula),
    constraint fg_compra_suministrador foreign key (snombre,pais) references suministrador(snombre,pais)
);