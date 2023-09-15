-- Fichero creado para MYSQL.

CREATE DATABASE AD6_Grupo_08;
USE AD6_Grupo_08;


CREATE TABLE VISITANTE(   
DNI 				char(9) not null,   
Nombre 				varchar(15),   
Domicilio 			varchar(25),   
Profesion			varchar(30)   
);
-- Indices de la tabla VISITANTE

ALTER TABLE VISITANTE ADD PRIMARY KEY (DNI);

CREATE TABLE COMUNIDADAUTONOMA(   
CodCA				int(5) not null,    
Nombre	 			varchar(20),   
OrgResponsable		varchar(10) 
);
-- Indices de la tabla COMUNIDADAUTONOMA

ALTER TABLE COMUNIDADAUTONOMA ADD PRIMARY KEY (CodCA);
------------------------------------------------------

CREATE TABLE PARQUENATURAL(   
CodPN				int(5) not null,    
Nombre	 			varchar(30),      
FechaDeclaracion 	date   
);
-- Indices de la tabla PARQUENATURAL

ALTER TABLE PARQUENATURAL ADD PRIMARY KEY (CodPN);
-------------------------------------------------------

CREATE TABLE ESPECIE(   
CodEspecie			int(5) not null,    
NombreCientifico 	varchar(25),   
NombreVulgar 		varchar(25)   
);
-- Indices de la tabla ESPECIE

ALTER TABLE ESPECIE ADD PRIMARY KEY (CodEspecie);
-------------------------------------------------------
CREATE TABLE ALOJAMIENTO(   
CodAlojamiento		int(5) not null,    
Categoria 			varchar(20),   
Capacidad 			int(2),   
CodPN				int(5)
);
-- Indices de la tabla ALOJAMIENTO

ALTER TABLE ALOJAMIENTO ADD PRIMARY KEY (CodAlojamiento);
ALTER TABLE ALOJAMIENTO ADD CONSTRAINT PARQUENATURAL_FK FOREIGN KEY (CodPN) REFERENCES PARQUENATURAL(CodPN);
------------------------------------------------------

CREATE TABLE EXCURSION(   
CodExcursion		int(5) not null,    
Fecha 				date,   
Hora 				date,   
aPie				char(1),
CodAlojamiento		int(5)	
);
-- Indices de la tabla EXCURSION
ALTER TABLE EXCURSION 
  ADD CONSTRAINT Y_or_N_aPie 
  CHECK (aPie = 'Y' or aPie = 'N');
ALTER TABLE EXCURSION ADD PRIMARY KEY (CodExcursion);
ALTER TABLE EXCURSION ADD CONSTRAINT ALOJAMIENTO_FK FOREIGN KEY (CodAlojamiento) REFERENCES ALOJAMIENTO(CodAlojamiento);

---------------------------------------------------------------

CREATE TABLE E_V(   
CodExcursion		int(5) not null,   
DNI  				char(9) 
);
-- Indices de la tabla E_V(TABLA RENACIDA)
ALTER TABLE E_V ADD PRIMARY KEY(CodExcursion,DNI);

-- Filtros para la tabla E_V
ALTER TABLE E_V
ADD CONSTRAINT EXCURSION_FK FOREIGN KEY (CodExcursion) REFERENCES EXCURSION(CodExcursion),
ADD CONSTRAINT VISITANTE1_FK FOREIGN KEY(DNI) REFERENCES VISITANTE(DNI);  

----------------------------------------------------------
CREATE TABLE A_V(   
CodAlojamiento		int(5) not null,    
DNI					char(9),   
FechaInicio			date,   
FechaFin			date
);
-- Indices de la tabla A_V(TABLA RENACIDA)
ALTER TABLE A_V ADD PRIMARY KEY (FechaInicio,CodAlojamiento,DNI);

-- Filtros para la tabla A_V
ALTER TABLE A_V
ADD CONSTRAINT ALOJAMIENTO1_FK FOREIGN KEY (CodAlojamiento) REFERENCES ALOJAMIENTO(CodAlojamiento) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT VISITANTE_FK FOREIGN KEY(DNI) REFERENCES VISITANTE(DNI) ON DELETE NO ACTION ON UPDATE NO ACTION;  
--------------------------------------------------------

CREATE TABLE CA_PN(   
CodCA				int(5) not null,    
CodPN	 			int(5),   
Capacidad 			varchar(20) 
);
-- Indices de la tabla CA_PN(TABLA RENACIDA)
ALTER TABLE CA_PN ADD PRIMARY KEY(CodCA,CodPN);

-- Filtros para la tabla CA_PN
ALTER TABLE CA_PN
ADD CONSTRAINT COMUNIDADAUTONOMA_FK FOREIGN KEY (CodCA) REFERENCES COMUNIDADAUTONOMA(CodCA) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT PARQUENATURAL4_FK FOREIGN KEY(CodPN) REFERENCES PARQUENATURAL(CodPN) ON DELETE NO ACTION ON UPDATE NO ACTION;
---------------------------------------------------

CREATE TABLE ENTRADA(   
CodEntrada			int(5) not null,    
CodPN		 		int(5)  
);
-- Indices de la tabla ENTRADA
ALTER TABLE ENTRADA ADD PRIMARY KEY (CodEntrada);
ALTER TABLE ENTRADA ADD CONSTRAINT PARQUENATURAL1_FK FOREIGN KEY (CodPN) REFERENCES PARQUENATURAL(CodPN);

--------------------------------------------------

CREATE TABLE PERSONAL(   
DNI					char(9) not null,    
NSS			 		varchar(10),  
Nombre	 			varchar(15),  
Direccion 			varchar(15),  
TfnoDomicilio		int(10),  
TfnoMovil	 		int(10),
Sueldo	 			float(5),
CodPN				int(5)
);

-- Indices de la tabla PERSONAL

ALTER TABLE PERSONAL ADD PRIMARY KEY (DNI);
ALTER TABLE PERSONAL
	ADD CONSTRAINT PARQUENATURAL2_FK FOREIGN KEY (CodPN) REFERENCES PARQUENATURAL(CodPN);
ALTER TABLE PERSONAL
	ADD CONSTRAINT PERSONAL_UQ UNIQUE (NSS);
---------------------------------------------------

CREATE TABLE AREA(   
NombreA				int(5) not null,    
Extension			varchar(25) ,
CodPN				int(5)
);
-- Indices de la tabla AREA
ALTER TABLE AREA ADD PRIMARY KEY (NombreA);
ALTER TABLE AREA
	ADD CONSTRAINT PARQUENATURAL3_FK FOREIGN KEY (CodPN) REFERENCES PARQUENATURAL(CodPN);
----------------------------------------------------

CREATE TABLE CONSERVADOR(   
DNI 				char(9) not null, 
Tarea				varchar(25),   
NombreA			 	int(5) 
);
-- Indices de la tabla CONSERVADOR   

ALTER TABLE CONSERVADOR ADD PRIMARY KEY (DNI);
ALTER TABLE CONSERVADOR
	ADD CONSTRAINT AREA_FK FOREIGN KEY (NombreA) REFERENCES AREA (NombreA),
	ADD CONSTRAINT PERSONAL_FK FOREIGN KEY (DNI) REFERENCES PERSONAL(DNI);

---------------------------------------------------

CREATE TABLE VIGILANTE(   
DNI  				char(9) not null,    
NombreA			 	int(5)
);
-- Indices de la tabla VIGILANTE

ALTER TABLE VIGILANTE ADD PRIMARY KEY (DNI);
ALTER TABLE VIGILANTE
	ADD CONSTRAINT AREA1_FK FOREIGN KEY (NombreA) REFERENCES AREA (NombreA),
	ADD CONSTRAINT PERSONAL1_FK FOREIGN KEY (DNI) REFERENCES PERSONAL(DNI);
-----------------------------------------------------
    
CREATE TABLE INVESTIGADOR(   
DNI  				char(9) not null,    
Titulacion		 	varchar(25)
);
-- Indices de la tabla INVESTIGADOR

ALTER TABLE INVESTIGADOR ADD PRIMARY KEY (DNI);
ALTER TABLE INVESTIGADOR
	ADD CONSTRAINT PERSONAL2_FK FOREIGN KEY (DNI) REFERENCES PERSONAL(DNI);
---------------------------------------------------------

CREATE TABLE GESTOR(   
DNI  				char(9) not null,    
CodEntrada			int(5)
);
-- Indices de la tabla GESTOR

ALTER TABLE GESTOR ADD PRIMARY KEY (DNI);
ALTER TABLE GESTOR
	ADD CONSTRAINT PERSONAL3_FK FOREIGN KEY (DNI) REFERENCES PERSONAL(DNI),
    ADD CONSTRAINT ENTRADA_FK FOREIGN KEY (CodEntrada) REFERENCES ENTRADA(CodEntrada);

------------------------------------------

CREATE TABLE E_A(   
CodEspecie			int(5) not null,    
CodArea				int(5),   
CantIndividuos 		int(4)   
);
-- Indices de la tabla E_A(TABLA RENACIDA)
ALTER TABLE E_A ADD PRIMARY KEY(CodEspecie,CodArea);
-- Filtros para la tabla E_A
ALTER TABLE E_A
ADD CONSTRAINT ESPECIE4_FK FOREIGN KEY (CodEspecie) REFERENCES ESPECIE(CodEspecie) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT AREA2_FK FOREIGN KEY(CodArea) REFERENCES AREA(NombreA) ON DELETE NO ACTION ON UPDATE NO ACTION;
---------------------------------------------------

CREATE TABLE ANIMAL(   
CodEspecie			int(5) not null,    
Alimentacion 		varchar(50),   
PeriodoCelo 		varchar(25)   
);
 -- Indices de la tabla ANIMAL
 
ALTER TABLE ANIMAL ADD PRIMARY KEY (CodEspecie);
ALTER TABLE ANIMAL
	ADD CONSTRAINT ESPECIE1_FK FOREIGN KEY (CodEspecie) REFERENCES ESPECIE(CodEspecie);
----------------------------------------------------

CREATE TABLE VEGETAL(   
CodEspecie			int(5) not null,    
Floracion 			varchar(25),   
PeriodoFloracion 	varchar(25)   
);
-- Indices de la tabla VEGETAL

ALTER TABLE VEGETAL ADD PRIMARY KEY (CodEspecie);
ALTER TABLE VEGETAL
	ADD CONSTRAINT ESPECIE2_FK FOREIGN KEY (CodEspecie) REFERENCES ESPECIE(CodEspecie);
--------------------------------------------------

CREATE TABLE MINERAL(   
CodEspecie			int(5) not null,    
Tipo			 	varchar(25) 
);
-- Indices de la tabla MINERAL

ALTER TABLE MINERAL ADD PRIMARY KEY (CodEspecie);
ALTER TABLE MINERAL
	ADD CONSTRAINT ESPECIE3_FK FOREIGN KEY (CodEspecie) REFERENCES ESPECIE(CodEspecie);
---------------------------------------------------

CREATE TABLE VEHICULO(   
Matricula			char(5) not null,    
Tipo			 	varchar(25),
DNI					char(9)
);
-- Indices de la tabla VEHICULO

ALTER TABLE VEHICULO ADD PRIMARY KEY (Matricula);
ALTER TABLE VEHICULO
	ADD CONSTRAINT PERSONAL4_FK FOREIGN KEY (DNI) REFERENCES PERSONAL(DNI);
ALTER TABLE VEHICULO
	ADD CONSTRAINT VEHICULO_UQ UNIQUE(DNI);

CREATE TABLE PROYECTO(   
CodProy  			int(5) not null,    
Presupuesto			float(9),
FechaInicio			date,
FechaFin			date,
CodEspecie			int(5)
);
-- Indices de la tabla PROYECTO

ALTER TABLE PROYECTO ADD PRIMARY KEY (CodProy);
ALTER TABLE PROYECTO ADD CONSTRAINT ESPECIE_FK FOREIGN KEY (CodEspecie) REFERENCES ESPECIE(CodEspecie);
--------------------------------------------------

CREATE TABLE I_P(   
CodProy  			int(5) not null,    
DNI					char(9)
);

-- Indices de la tabla I_P(TABLA RENACIDA)
ALTER TABLE I_P ADD PRIMARY KEY (CodProy, DNI);
-- Filtros para la tabla I_P
ALTER TABLE I_P ADD CONSTRAINT CodProy_FK FOREIGN KEY (CodProy) REFERENCES Proyecto(CodProy) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT DNI_FK FOREIGN KEY (DNI) REFERENCES Personal(DNI) ON DELETE NO ACTION ON UPDATE NO ACTION;

    
-- Carga de datos

INSERT INTO VISITANTE(DNI,Nombre,Domicilio,Profesion)
VALUES	('08017216B', 'Maria Saavedra', 'Av. Los Rosales 22', 'Abogada'),
		('21521285A', 'Pedro Manuel', 'Calle Ginzo de Limia 14','Medico'),
		('45256522C', 'Pilar Cuevas', 'Av. Monforte de Lemos 10','Contador'),
		('26581263J', 'Ana Garcia', 'Av. Peñagrande 34','Ingeniero Informatico'),
		('32659852L', 'Jose Pareja', 'Av. El ferrol 26','Arquitecto'),
        ('78451232K', 'Gustavo Mena', 'Calle Julia Novoa 4','Administrador'),
        ('89562365H', 'Silvia Gala', 'Av. Ricardo Palma 12','Psicologo'),
        ('25896314P', 'Martha Ayuso', 'Av. Bella Vista 18','Ingeniero Forestal'),
        ('14253685G', 'Patricia Delgado', 'Av. Castilla 24','Publicista'),
        ('41526375F', 'Gema Hurtado', 'calle. Cebreros 25','Ingeniero Ambiental');

INSERT INTO COMUNIDADAUTONOMA(CodCA,Nombre,OrgResponsable)
VALUES	(40001,'Castilla y Leon','Org1'),
		(40002,'Andalucia','Org2'),
        (40003,'Galicia','Org3'),
        (40004,'Comunidad de Madrid','Org4');

INSERT INTO PARQUENATURAL(CodPN,Nombre,FechaDeclaracion)
VALUES	(30001,'SIERRA DE GUADARRAMA','1994-06-28'),
		(30002,'CUENCA ALTA','1998-02-25'),
		(30003,'MANZANARES','2006-03-19'),
		(30004,'PINAR DE ABANTOS','2008-09-02');

INSERT INTO ESPECIE(CodEspecie, NombreCientifico, NombreVulgar)
VALUES (5100,'Carcharodon carcharias','Carcharodon carcharias'),
	   (5101,'Canis lupus','Lobo'),
       (5102,'Ursus maritimus','Oso Polar'),
       (5103,'Panthera onca','Jaguar'),
       (6001,'Flores pequeñas','Todo el año'),
	   (6002,'Carecen','No tienen'),
       (6003,'Flor blanca' , 'diurna'),
       (7001,'Sulfuro', 'Sulfuro' ),
	  (7002,'Haluro', 'Haluro'),
      (7003,'Nitrato', 'Nitrato'),
      (7004,'Silciato', 'Silciato');

INSERT INTO ALOJAMIENTO(CodAlojamiento,Categoria,Capacidad,CodPN)
VALUES	(20001,'4ESTRELLAS','20',30001),
		(20002,'3ESTRELLAS','30',30002),
        (20003,'2ESTRELLAS','20',30003),
        (20004,'1ESTRELLA','30',30004);

INSERT INTO EXCURSION(CodExcursion,Fecha,Hora,aPie,CodAlojamiento)
VALUES	(10001,'2023-02-26','10:15','Y',20001),
		(10002,'2023-02-20','12:00','N',20002),
        (10003,'2023-02-26','10:15','Y',20003),
        (10004,'2023-02-19','10:00','N',20004);
        
INSERT INTO E_V(CodExcursion,DNI)
VALUES	(10001,'08017216B'),
		(10002,'21521285A'),
        (10001,'45256522C'),
        (10002,'26581263J'),
        (10001,'32659852L'),
        (10002,'78451232K'),
        (10003,'89562365H'),
        (10004,'25896314P'),
        (10003,'14253685G'),
        (10004,'41526375F');

INSERT INTO A_V(CodAlojamiento,DNI,FechaInicio,FechaFin)
VALUES	(20001,'08017216B','2023-02-25','2023-02-27'),
		(20002,'21521285A','2023-02-19','2023-02-21'),
        (20001,'45256522C','2023-02-25','2023-02-27'),
        (20003,'26581263J','2023-02-18','2023-02-20'),
        (20001,'32659852L','2023-02-25','2023-02-27'),
        (20003,'78451232K','2023-02-18','2023-02-20'),
        (20001,'89562365H','2023-02-25','2023-02-27'),
        (20002,'25896314P','2023-02-19','2023-02-21'),
        (20001,'14253685G','2023-02-25','2023-02-27'),
        (20004,'41526375F','2023-02-17','2023-02-20');

INSERT INTO CA_PN(CodCA,CodPN,Capacidad)
VALUES	(40001,30001,'9'),
		(40002,30002,'10'),
        (40003,30003,'8'),
        (40004,30004,'7');

INSERT INTO ENTRADA(CodEntrada,CodPN)
VALUES	(50001,30001),
		(50002,30002),
        (50003,30003),
        (50004,30004);

INSERT INTO PERSONAL(DNI,NSS,Nombre,Direccion,TfnoDomicilio,TfnoMovil,Sueldo,CodPN)
VALUES	('05025125D','555501234','Gabriela Santos','Av. El ferrol 24','644425965','926002562','2500',30001),
		('25621552J','263585611','Cristian Galileo','Av. Monforte de Lemos 4','642563952','964002562','2300',30002),
		('26251236F','635266652','Marian Lopez','Av.El Rosal 12','643265859','942002562','2800',30003),
		('45259687L','444526321','Libertad La Rosa','Av. Julian Camarillo 2','644256295','969002562','2100',30004);        
        
INSERT INTO AREA(NombreA,Extension,CodPn)
VALUES(9000,'3 ha',30001),
	  (9001,'10 ha',30002),
      (9002,'7,4 ha', 30003);

INSERT INTO CONSERVADOR(DNI,Tarea,NombreA)
VALUES		('05025125D','Control y vigilancia','9000'),
			('25621552J','Educacion ambiental','9001'),
            ('26251236F','Atencion a los visitantes','9002'),
            ('45259687L','Trabajo con pobladores','9000');
			

INSERT INTO VIGILANTE(DNI,NombreA)
VALUES		('05025125D','9000'),
			('25621552J','9001'),
            ('26251236F','9002'),
            ('45259687L','9000');


INSERT INTO INVESTIGADOR(DNI,Titulacion)
VALUES 		('05025125D','Ecologo Industrial'),
			('25621552J','Ingeniero Ambiental'),
            ('26251236F','Tec del Medio Ambiente'),
            ('45259687L','Biologo');

INSERT INTO GESTOR(DNI,CodEntrada)
VALUES		('05025125D',50001),
			('25621552J',50002),
            ('26251236F',50003),
            ('45259687L',50004);
      
INSERT INTO E_A(CodEspecie,CodArea,CantIndividuos)
VALUES(5101,9000,10),
	  (5103,9001,20),
      (5102,9002,5);

INSERT INTO ANIMAL(CodEspecie,Alimentacion,PeriodoCelo)
VALUES (5100,'Peces','Indiferente'),
	   (5101,'Vertebrados','Entre enero y abril'),
       (5102,'Animales árticos','e marzo a junio'),
	   (5103,'Peces, tortugas, caimmanes','Indiferente');
     
INSERT INTO VEGETAL(CodEspecie,Floracion,PeriodoFloracion)
VALUES (6001,'Flores pequeñas','Todo el año'),
	   (6002,'Carecen','No tienen'),
       (6003,'Flor blanca' , 'diurna');
       
INSERT INTO MINERAL(CodEspecie,tipo)
VALUES(7001,'Sulfuro'),
	  (7002,'Haluro'),
      (7003,'Nitrato'),
      (7004,'Silciato');
      
INSERT INTO VEHICULO(Matricula, Tipo, DNI)
VALUES('7171J', 'JEEP','05025125D'),
	  ('2432F', 'JEEP', '25621552J'),
      ('3652P', 'SUZUKI','26251236F'),
      ('6482L','JEEP','45259687L');

 INSERT INTO PROYECTO (CodProy,Presupuesto,FechaInicio, FechaFin, CodEspecie)
VALUES	(2001, 16.500, '2010-03-23', '2012-09-08', 5101),
        (2002, 25.670, '2012-04-30', '2017-02-18', 5103),
        (2004, 13.670, '2015-09-19', '2015-11-22', 5102),
        (2003, 3.560, '2011-05-06', '2011-08-23', 5101),
        (2005, 10.340, '2019-09-27', '2020-07-15', 5103);

INSERT INTO I_P(CodProy, DNI)
VALUES(2001,'05025125D'),
	  (2002,'25621552J'),
      (2003,'26251236F'),
      (2004,'45259687L');
      

CREATE OR REPLACE VIEW EXCURSION_A_PIE AS (
SELECT E_V.DNI, EXCURSION.FECHA, EXCURSION.aPie as EXCURSION_A_PIE
FROM E_V, EXCURSION
WHERE E_V.CodExcursion = EXCURSION.CodExcursion 
AND EXCURSION.aPie = 'Y');


