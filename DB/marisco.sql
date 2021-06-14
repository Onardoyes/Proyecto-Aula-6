DROP DATABASE marisco;
CREATE DATABASE marisco;
USE marisco;

--
-- Table structure for table `cat_tipo_empleado`
--

DROP TABLE IF EXISTS `cat_tipo_empleado`;
CREATE TABLE `cat_tipo_empleado` (
  `cve_tipo_empleado` varchar(24) NOT NULL COMMENT 'Identificador del tipo de empleado',
  `desc_tipo_empleado` varchar(20) NOT NULL COMMENT 'Descripción del tipo de empleado',
  PRIMARY KEY (`cve_tipo_empleado`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Catálogo del tipo de empleado ';

INSERT INTO `cat_tipo_empleado` VALUES ('A','Administrador'),('M','Mesero'),('C','Cajero');

--
-- Table structure for table `cat_unidad_medida`
--

DROP TABLE IF EXISTS `cat_unidad_medida`;
CREATE TABLE `cat_unidad_medida` (
  `id_unidad_medida` varchar(5) NOT NULL COMMENT 'Identificador de la unidad de medida',
  `nombre_unidad_medida` varchar(50) NOT NULL COMMENT 'Nombre de de la unidad de medida',
  PRIMARY KEY (`id_unidad_medida`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Catálogo de las unidades de medida';

INSERT INTO `cat_unidad_medida` VALUES ('Kg','KILOGRAMO'),('L','LITRO'),('P','PIEZA'),('g','GRAMO'),('Ml','MILILITRO'),('Oz','ONZA'),('T','TAZA'),('C','CUCHARADA'),('Pi','PIZCA');

--
-- Table structure for table `cat_tipo_ingrediente`
--

DROP TABLE IF EXISTS `cat_tipo_ingrediente`;
CREATE TABLE `cat_tipo_ingrediente` (
  `id_tipo_ingrediente` varchar(1) NOT NULL COMMENT 'Identificador del tipo de ingrediente: V=Verdura M=Marisco',
  `tipo_ingrediente` varchar(15) NOT NULL COMMENT 'nombre de los diferentes tipos de ingredientes',
  PRIMARY KEY (`id_tipo_ingrediente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Catálogo de los diferentes tipos de ingredientes';

INSERT INTO `cat_tipo_ingrediente` VALUES ('M','Marisco'),('V','Verdura');

--
-- Table structure for table `cat_tipo_platillo`
--

DROP TABLE IF EXISTS `cat_tipo_platillo`;
CREATE TABLE `cat_tipo_platillo` (
  `cve_tipo_platillo` varchar(2) NOT NULL COMMENT 'Identificador del tipo de platillo',
  `desc_tipo_platillo` varchar(120) NOT NULL COMMENT 'Descripción del tipo de platillo',
  PRIMARY KEY (`cve_tipo_platillo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Catálogo de los tipos de platillos y bebidas';

INSERT INTO `cat_tipo_platillo` VALUES ('B','Bebida'),('C','Coctel'),('CA','Caldos'),('CM','Camarones'),('E','Entradas'),('F','Filetes'),('IN','Platillos Infantiles'),('M','Mojarras'),('P','Postres'),('PF','Platos Fuertes');

--
-- Table structure for table `cat_ingrediente`
--

DROP TABLE IF EXISTS `cat_ingrediente`;
CREATE TABLE `cat_ingrediente` (
  `id_ingrediente` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador del ingrediente',
  `nombre_ingrediente` varchar(200) NOT NULL COMMENT 'Nombre del ingrediente',
  `tipo_ingrediente` varchar(1) NOT NULL COMMENT 'Indicador del tipo de ingrediente: V=Verdura M=Marisco',
  PRIMARY KEY (`id_ingrediente`),
  KEY `FK_id_tipo_ingrediente` (`tipo_ingrediente`),
  CONSTRAINT `FK_id_tipo_ingrediente` FOREIGN KEY (`tipo_ingrediente`) REFERENCES `cat_tipo_ingrediente` (`id_tipo_ingrediente`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1 COMMENT='Catálogo de los ingredientes para los platillos y bebidas';

INSERT INTO `cat_ingrediente` VALUES (1,'ALMEJAS','M'),(2,'AGUACATE','V'),(3,'AJOS','V'),(4,'ARROZ','V'),(5,'CAMARON','M'),(6,'CEBOLLA','V'),(7,'CEBOLLA MORADA','V'),(8,'CHAMPIÑON','V'),(9,'CHILE VERDE','V'),(10,'CILANTRO','V'),(11,'COCTEL','M'),(12,'COL MORADA','V'),(13,'CRISTAL','M'),(14,'EMPANADAS','M'),(15,'FILETE','M'),(16,'FILETE MOJARRA','M'),(17,'JAIBA','M'),(18,'JITOMATE','V'),(19,'LECHUGA','V'),(20,'LIMON','V'),(21,'MOJARRA','M'),(22,'PAPA','V'),(23,'PATA DE MULA','M'),(24,'PEPINO','V'),(25,'PESCADO','M'),(26,'PIÑA','V'),(27,'PULPO','M'),(28,'SURIMI','M'),(29,'ZANAHORIA','V');

CREATE TABLE cat_prioridadReporte (
    id_prioridad INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
    prioridad_reporte VARCHAR(8) NOT NULL
) DEFAULT CHARACTER SET utf8mb4;
SELECT * FROM cat_prioridadReporte;
INSERT INTO cat_prioridadReporte VALUES (1, 'BAJA'), (2, 'MEDIA'), (3, 'ALTA');

--
-- Table structure for table `empleado`
--

DROP TABLE IF EXISTS `empleado`;
CREATE TABLE `empleado` (
  `id_empleado` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador del empleado',
  `nombre` varchar(44) NOT NULL COMMENT 'Nombre del empleado',
  `primer_apellido` varchar(44) NOT NULL COMMENT 'Primer apellido del empleado',
  `segundo_apellido` varchar(44) DEFAULT NULL COMMENT 'Segundo apellido del empleado',
  `cve_tipo_empleado` varchar(24) NOT NULL COMMENT 'Identificador del tipo de empleado',
  `clave_ingreso` varchar(60) DEFAULT NULL COMMENT 'Clave de acceso al sistema, Aplica para administrador y cajero',
  PRIMARY KEY (`id_empleado`),
  KEY `FK_cve_tipo_empleado1` (`cve_tipo_empleado`),
  CONSTRAINT `FK_cve_tipo_empleado1` FOREIGN KEY (`cve_tipo_empleado`) REFERENCES `cat_tipo_empleado` (`cve_tipo_empleado`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla de empleados';

INSERT INTO `empleado` VALUES (1,'Angel','Reyes','Vega','A','Leonardo9'),(2,'Cesar','De la O','Cordero','C','12346');


CREATE TABLE reporte(
    id_reporte INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_empleado INT(11) NOT NULL,
    id_prioridad INT UNSIGNED NOT NULL,
    reporte_descripcion TEXT NOT NULL,
    fecha_reporte VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
    FOREIGN KEY (id_prioridad) REFERENCES cat_prioridadReporte(id_prioridad)
) DEFAULT CHARACTER SET utf8mb4;

INSERT INTO reporte VALUES (1,1,2,'El modulo de reportes esta teniendo problemas','2021-04-23 12:00:00');
INSERT INTO reporte VALUES (0,1,2,'modulo xd','2021-04-27 12:00:00');

--
-- Table structure for table `cat_platillo`
--

DROP TABLE IF EXISTS `cat_platillo`;
CREATE TABLE `cat_platillo` (
  `id_platillo` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador del platillo',
  `nombre_platillo` varchar(200) NOT NULL COMMENT 'Nombre del platillo',
  `cve_tipo_platillo` varchar(2) DEFAULT NULL,
  `precio` decimal(4,0) NOT NULL COMMENT 'Precio unitario del platillo',
  PRIMARY KEY (`id_platillo`),
  KEY `FK_cve_tipo_platillo1` (`cve_tipo_platillo`),
  CONSTRAINT `FK_cve_tipo_platillo1` FOREIGN KEY (`cve_tipo_platillo`) REFERENCES `cat_tipo_platillo` (`cve_tipo_platillo`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=latin1 COMMENT='Catálogo de los platillos y bebidas';

INSERT INTO `cat_platillo` VALUES (1,'AGUACHILE','PF',120),
(2,'ALAMBRE DE MARISCOS','PF',150),
(3,'ARROZ CUBANITO','PF',40),
(4,'BROCHETAS DE CAMARONES','IN',90),
(5,'CALDO DE CAMARÓN CHICO','CA',60),
(6,'CALDO DE CAMARÓN GRANDE','CA',80),
(7,'CALDO DE PESCADO CHICO','CA',50),
(8,'CALDO DE PESCADO GRANDE','CA',70),
(9,'CAMARONES A LA DIABLA','CM',140),
(10,'CAMARONES A LA PLANCHA','CM',140),
(11,'CAMARONES AL AJILLO','CM',140),
(12,'CAMARONES AL COCO','CM',150),
(13,'CAMARONES CON TOCINO','CM',180),
(14,'CAMARONES EMPANIZADOS','CM',140),
(15,'CAMARONES EMPANIZADOS','IN',70),
(16,'CAMARONES MANGO-HABANERO','CM',180),
(17,'CAMARONES RELLENOS DE QUESO DOBLE CREMA','CM',150),
(18,'CAMARONES TAMARINDO-HABANERO','CM',180),
(19,'CAPARAZÓN A LA DIABLA','PF',100),
(20,'CEVICHE ACAPULCO','PF',120),
(21,'CEVICHE ZIHUATANEJO','PF',120),
(22,'COCTEL CAMPECHANO CHICO','C',50),
(23,'COCTEL CAMPECHANO GRANDE','C',100),
(24,'COCTEL CAMPECHANO MEDIANO','C',70),
(25,'COCTEL DE CAMARÓN CHICO','C',60),
(26,'COCTEL DE CAMARÓN GRANDE','C',120),
(27,'COCTEL DE CAMARON MEDIANO','C',80),
(28,'CONSOMÉ','CA',15),
(29,'EMPANADA COMBINADA','E',30),
(30,'EMPANADA DE CAMARÓN','E',35),
(31,'EMPANADA HAWAIANA DE CAMARÓN','E',40),
(32,'EMPANADA HAWAIANA DE MARISCOS','E',40),
(33,'ENSALADA EL MARISQUITO','PF',120),
(34,'FILETE A LA PLANCHA','F',140),
(35,'FILETE EMPANIZADO','F',140),
(36,'FILETE EMPANIZADO INFANTIL','IN',70),
(37,'FILETE EMPAPELADO','F',180),
(38,'FILETE RELLENO DE MARISCOS','F',180),
(39,'FILETES','E',20),
(40,'MAR Y TIERRA','PF',150),
(41,'MOJARRA A LA BARBACOA','M',220),
(42,'MOJARRA A LA DIABLA','M',180),
(43,'MOJARRA A LA TALLA','M',180),
(44,'MOJARRA AL MOJO DE AJO','M',140),
(45,'MOJARRA FRITA','M',140),
(46,'PESCADILLAS','E',20),
(47,'PIÑA RELLENA','PF',200),
(48,'PULPO A LA DIABLA','PF',120),
(49,'ROLLITOS DE CAMARÓN INFANTILES','IN',70),
(50,'SOPA DE MARISCOS CHICA','CA',100),
(51,'SOPA DE MARISCOS GRANDE','CA',120),
(52,'SOPES DE CAMARÓN','PF',70),
(53,'TACOS A LA VECARUZANA','PF',120),
(54,'TACOS CRUJIENTES DE CAMARÓN','PF',90),
(55,'TOSTADA COMBINADA','E',25),
(56,'TOSTADA DE CAMARÓN','E',30),
(57,'VOLCÁN DE PULPO','PF',35),
(58,'VUELVE A LA VIDA CHICO','C',50),
(59,'VUELVE A LA VIDA GRANDE','C',100),
(60,'VUELVE A LA VIDA MEDIANO','C',70);

DROP TABLE IF EXISTS `receta`;
CREATE TABLE `receta` (
  `id_receta` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador del registro',
  `id_platillo` int(11) NOT NULL COMMENT 'Identificador del platillo',
  `id_ingrediente` int(11) NOT NULL COMMENT 'Identificador del ingrediente',
  `id_unidad_medida` varchar(5) NOT NULL COMMENT 'Identificador de la unidad de medida',
  `cantidad_ingrediente` double(6,2) NOT NULL COMMENT 'Cantidad de unidades de medida del ingrediente requerida para el platillo',
  PRIMARY KEY (`id_receta`),
  KEY `FK_id_ingrediente2` (`id_ingrediente`),
  KEY `FK_id_unidad_medida2` (`id_unidad_medida`),
  CONSTRAINT `FK_id_ingrediente2` FOREIGN KEY (`id_ingrediente`) REFERENCES `cat_ingrediente` (`id_ingrediente`),
  CONSTRAINT `FK_id_unidad_medida2` FOREIGN KEY (`id_unidad_medida`) REFERENCES `cat_unidad_medida` (`id_unidad_medida`)
) ENGINE=InnoDB AUTO_INCREMENT=416 DEFAULT CHARSET=latin1 COMMENT='Relación de los ingredientes por platillo. La unidad de medida por ingrediente debe corresponder a la de la despensa';

INSERT INTO `receta` VALUES (1,1,5,'K',0.36),(2,1,24,'K',0.05),(3,2,5,'K',0.15),(4,2,28,'K',0.04),(5,2,27,'K',0.04),(6,3,4,'K',0.25),(7,4,5,'K',0.18),(8,4,4,'K',0.05),(9,4,19,'K',0.03),(10,4,12,'K',0.02),(11,4,18,'K',0.02),(12,4,24,'K',0.02),(13,4,2,'K',0.02),(14,5,5,'K',0.21),(15,5,17,'P',1.50),(16,5,1,'P',3.00),(17,5,22,'K',0.02),(18,5,29,'K',0.02),(19,5,6,'K',0.03),(20,5,10,'K',0.01),(21,5,18,'K',0.03),(22,5,2,'K',0.02),(23,6,5,'K',0.27),(24,6,17,'P',1.00),(25,6,1,'P',4.00),(26,6,22,'K',0.03),(27,6,29,'K',0.03),(28,6,6,'K',0.03),(29,6,10,'K',0.01),(30,6,18,'K',0.03),(31,6,2,'K',0.02),(32,7,25,'K',0.26),(33,7,17,'P',1.50),(34,7,1,'P',3.00),(35,7,22,'K',0.02),(36,7,29,'K',0.02),(37,7,6,'K',0.03),(38,7,10,'K',0.01),(39,7,18,'K',0.03),(40,7,2,'K',0.02),(41,8,25,'K',0.38),(42,8,17,'P',1.00),(43,8,1,'K',4.00),(44,8,22,'K',0.03),(45,8,29,'K',0.03),(46,8,6,'K',0.03),(47,8,10,'K',0.01),(48,8,18,'K',0.03),(49,8,2,'K',0.02),(50,9,5,'K',0.36),(51,9,4,'K',0.10),(52,9,19,'K',0.05),(53,9,12,'K',0.03),(54,9,18,'K',0.02),(55,9,6,'K',0.00),(56,9,24,'K',0.02),(57,9,2,'K',0.04),(58,10,5,'K',0.36),(59,10,4,'K',0.10),(60,10,19,'K',0.05),(61,10,12,'K',0.03),(62,10,18,'K',0.02),(63,10,6,'K',0.00),(64,10,24,'K',0.02),(65,10,2,'K',0.04),(66,11,5,'K',0.36),(67,11,4,'K',0.10),(68,11,19,'K',0.05),(69,11,12,'K',0.03),(70,11,18,'K',0.02),(71,11,6,'K',0.00),(72,11,24,'K',0.02),(73,11,2,'K',0.04),(74,12,5,'K',0.36),(75,12,4,'K',0.10),(76,12,19,'K',0.05),(77,12,12,'K',0.03),(78,12,18,'K',0.02),(79,12,6,'K',0.00),(80,12,24,'K',0.02),(81,12,2,'K',0.04),(82,13,5,'K',0.36),(83,13,4,'K',0.10),(84,13,19,'K',0.05),(85,13,12,'K',0.03),(86,13,18,'K',0.02),(87,13,6,'K',0.00),(88,13,24,'K',0.02),(89,13,2,'K',0.04),(90,14,5,'K',0.36),(91,14,4,'K',0.10),(92,14,19,'K',0.05),(93,14,12,'K',0.03),(94,14,18,'K',0.02),(95,14,6,'K',0.00),(96,14,24,'K',0.02),(97,14,2,'K',0.04),(98,15,5,'K',0.18),(99,15,4,'K',0.05),(100,15,19,'K',0.03),(101,15,12,'K',0.02),(102,15,18,'K',0.02),(103,15,24,'K',0.02),(104,15,2,'K',0.02),(105,16,5,'K',0.36),(106,16,4,'K',0.10),(107,16,19,'K',0.05),(108,16,12,'K',0.03),(109,16,18,'K',0.02),(110,16,6,'K',0.00),(111,16,24,'K',0.02),(112,16,2,'K',0.04),(113,17,5,'K',0.36),(114,17,4,'K',0.10),(115,17,19,'K',0.05),(116,17,12,'K',0.03),(117,17,18,'K',0.02),(118,17,6,'K',0.00),(119,17,24,'K',0.02),(120,17,2,'K',0.04),(121,18,5,'K',0.36),(122,18,4,'K',0.10),(123,18,19,'K',0.05),(124,18,12,'K',0.03),(125,18,18,'K',0.02),(126,18,6,'K',0.00),(127,18,24,'K',0.02),(128,18,2,'K',0.04),(129,19,5,'K',0.08),(130,19,14,'K',1.00),(131,19,19,'K',0.05),(132,19,12,'K',0.03),(133,19,18,'K',0.02),(134,19,6,'K',0.00),(135,19,24,'K',0.02),(136,19,2,'K',0.04),(137,20,6,'K',0.03),(138,20,10,'K',0.01),(139,20,18,'K',0.03),(140,20,2,'K',0.02),(141,21,5,'K',0.08),(142,21,27,'K',0.08),(143,21,6,'K',0.03),(144,21,10,'K',0.01),(145,21,18,'K',0.03),(146,21,2,'K',0.02),(147,22,5,'K',0.05),(148,22,6,'K',0.03),(149,22,10,'K',0.01),(150,22,18,'K',0.03),(151,22,2,'K',0.02),(152,23,5,'K',0.05),(153,23,6,'K',0.03),(154,23,10,'K',0.01),(155,23,18,'K',0.03),(156,23,2,'K',0.02),(157,24,5,'K',0.10),(158,24,6,'K',0.03),(159,24,10,'K',0.01),(160,24,18,'K',0.03),(161,24,2,'K',0.02),(162,25,5,'K',0.08),(163,25,6,'K',0.03),(164,25,10,'K',0.01),(165,25,18,'K',0.03),(166,25,2,'K',0.02),(167,26,5,'K',0.24),(168,26,6,'K',0.03),(169,26,10,'K',0.01),(170,26,18,'K',0.03),(171,26,2,'K',0.02),(172,27,5,'K',0.17),(173,27,6,'K',0.03),(174,27,10,'K',0.01),(175,27,18,'K',0.03),(176,27,2,'K',0.02),(177,28,14,'P',1.00),(178,28,5,'K',0.09),(179,28,27,'K',0.01),(180,28,28,'K',0.01),(181,28,6,'K',0.03),(182,28,10,'K',0.01),(183,28,18,'K',0.03),(184,28,2,'K',0.02),(185,29,14,'P',1.00),(186,29,5,'K',0.15),(187,29,6,'K',0.03),(188,29,10,'K',0.01),(189,29,18,'K',0.03),(190,29,2,'K',0.02),(191,30,14,'P',1.00),(192,30,5,'K',0.15),(193,30,6,'K',0.03),(194,30,10,'K',0.01),(195,30,18,'K',0.03),(196,30,2,'K',0.02),(197,30,26,'P',0.03),(198,31,14,'P',1.00),(199,31,5,'K',0.09),(200,31,27,'K',0.01),(201,31,28,'K',0.01),(202,31,6,'K',0.03),(203,31,10,'K',0.01),(204,31,18,'K',0.03),(205,31,26,'P',0.03),(206,32,19,'K',0.10),(207,32,12,'K',0.03),(208,32,18,'K',0.02),(209,32,6,'K',0.00),(210,32,24,'K',0.02),(211,32,2,'K',0.03),(212,32,28,'K',0.02),(213,32,27,'K',0.02),(214,32,5,'K',0.15),(215,33,15,'K',0.13),(216,33,4,'K',0.10),(217,33,19,'K',0.05),(218,33,12,'K',0.03),(219,33,18,'K',0.02),(220,33,6,'K',0.00),(221,33,24,'K',0.02),(222,33,2,'K',0.04),(223,34,15,'K',0.13),(224,34,4,'K',0.10),(225,34,19,'K',0.05),(226,34,12,'K',0.03),(227,34,18,'K',0.02),(228,34,6,'K',0.00),(229,34,24,'K',0.02),(230,34,2,'K',0.04),(231,35,15,'K',0.07),(232,35,4,'K',0.05),(233,35,19,'K',0.03),(234,35,12,'K',0.02),(235,35,18,'K',0.02),(236,35,24,'K',0.02),(237,35,2,'K',0.02),(238,36,15,'K',0.13),(239,36,22,'K',0.02),(240,36,29,'K',0.02),(241,36,5,'K',0.12),(242,36,19,'K',0.05),(243,36,12,'K',0.03),(244,36,18,'K',0.02),(245,36,6,'K',0.00),(246,36,24,'K',0.02),(247,36,2,'K',0.04),(248,36,4,'K',0.10),(249,37,15,'K',0.13),(250,37,5,'K',0.12),(251,37,28,'K',0.02),(252,37,27,'K',0.02),(253,37,19,'K',0.05),(254,37,12,'K',0.03),(255,37,18,'K',0.02),(256,37,6,'K',0.05),(257,37,24,'K',0.02),(258,37,2,'K',0.04),(259,37,4,'K',0.10),(260,38,15,'K',0.20),(261,38,6,'K',0.03),(262,38,10,'K',0.01),(263,38,18,'K',0.03),(264,38,2,'K',0.02),(265,39,5,'K',0.15),(266,39,27,'K',0.04),(267,40,16,'P',1.00),(268,40,22,'K',0.02),(269,40,29,'K',0.02),(270,40,5,'K',0.12),(271,40,28,'K',0.02),(272,40,27,'K',0.02),(273,40,4,'K',0.10),(274,40,19,'K',0.05),(275,40,12,'K',0.03),(276,40,18,'K',0.02),(277,40,6,'K',0.05),(278,41,16,'P',1.00),(279,41,4,'K',0.10),(280,41,19,'K',0.05),(281,41,12,'K',0.03),(282,41,18,'K',0.02),(283,41,6,'K',0.00),(284,41,24,'K',0.02),(285,41,2,'K',0.04),(286,42,16,'P',1.00),(287,42,4,'K',0.10),(288,42,19,'K',0.05),(289,42,12,'K',0.03),(290,42,18,'K',0.02),(291,42,6,'K',0.00),(292,42,24,'K',0.02),(293,42,2,'K',0.04),(294,43,16,'P',1.00),(295,43,4,'K',0.10),(296,43,19,'K',0.05),(297,43,12,'K',0.03),(298,43,18,'K',0.02),(299,43,6,'K',0.00),(300,43,24,'K',0.02),(301,43,2,'K',0.04),(302,44,16,'P',1.00),(303,44,4,'K',0.10),(304,44,19,'K',0.05),(305,44,12,'K',0.03),(306,44,18,'K',0.02),(307,44,6,'K',0.00),(308,44,24,'K',0.02),(309,44,2,'K',0.04),(310,45,6,'K',0.03),(311,45,10,'K',0.01),(312,45,18,'K',0.03),(313,45,2,'K',0.02),(314,46,5,'K',0.08),(315,46,27,'K',0.08),(316,46,26,'P',1.00),(317,46,19,'K',0.05),(318,46,12,'K',0.03),(319,46,18,'K',0.02),(320,46,6,'K',0.00),(321,46,24,'K',0.02),(322,46,2,'K',0.04),(323,47,27,'K',0.14),(324,47,4,'K',0.10),(325,47,19,'K',0.05),(326,47,12,'K',0.03),(327,47,18,'K',0.02),(328,47,6,'K',0.00),(329,47,24,'K',0.02),(330,47,2,'K',0.04),(331,48,5,'K',0.05),(332,48,4,'K',0.05),(333,48,19,'K',0.03),(334,48,12,'K',0.03),(335,48,18,'K',0.02),(336,48,24,'K',0.02),(337,48,2,'K',0.02),(338,49,5,'K',0.12),(339,49,17,'P',1.50),(340,49,1,'P',3.00),(341,49,28,'K',0.02),(342,49,27,'K',0.02),(343,49,25,'K',0.15),(344,49,6,'K',0.03),(345,49,10,'K',0.01),(346,49,18,'K',0.03),(347,49,2,'K',0.02),(348,50,5,'K',0.18),(349,50,17,'P',1.00),(350,50,1,'P',4.00),(351,50,28,'K',0.04),(352,50,27,'K',0.04),(353,50,25,'K',0.18),(354,50,6,'K',0.03),(355,50,10,'K',0.01),(356,50,18,'K',0.03),(357,50,2,'K',0.02),(358,51,5,'K',0.11),(359,51,19,'K',0.02),(360,51,18,'K',0.02),(361,51,6,'K',0.00),(362,51,24,'K',0.02),(363,51,2,'K',0.04),(364,52,5,'K',0.08),(365,52,4,'K',0.10),(366,52,19,'K',0.05),(367,52,12,'K',0.03),(368,52,18,'K',0.02),(369,52,6,'K',0.00),(370,52,24,'K',0.02),(371,52,2,'K',0.04),(372,53,5,'K',0.08),(373,53,4,'K',0.10),(374,53,19,'K',0.05),(375,53,12,'K',0.03),(376,53,18,'K',0.02),(377,53,24,'K',0.02),(378,53,2,'K',0.04),(379,54,5,'K',0.12),(380,54,27,'K',0.01),(381,54,28,'K',0.01),(382,54,6,'K',0.03),(383,54,10,'K',0.01),(384,54,18,'K',0.03),(385,54,2,'K',0.02),(386,55,5,'K',0.24),(387,55,6,'K',0.03),(388,55,10,'K',0.01),(389,55,18,'K',0.03),(390,55,2,'K',0.02),(391,56,27,'K',0.05),(392,57,5,'K',0.02),(393,57,28,'K',0.02),(394,57,27,'K',0.02),(395,57,23,'P',1.00),(396,57,6,'K',0.03),(397,57,10,'K',0.01),(398,57,18,'K',0.03),(399,57,2,'K',0.02),(400,58,5,'K',0.04),(401,58,28,'K',0.06),(402,58,27,'K',0.06),(403,58,23,'P',2.00),(404,58,6,'K',0.03),(405,58,10,'K',0.01),(406,58,18,'K',0.03),(407,58,2,'K',0.02),(408,59,5,'K',0.04),(409,59,28,'K',0.04),(410,59,27,'K',0.04),(411,59,23,'P',1.00),(412,59,6,'K',0.03),(413,59,10,'K',0.01),(414,59,18,'K',0.03),(415,59,2,'K',0.02);

--
-- Table structure for table `despensa`
--

DROP TABLE IF EXISTS `despensa`;
CREATE TABLE `despensa` (
  `id_despensa` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador del registro de la despensa',
  `id_ingrediente` int(11) NOT NULL COMMENT 'Identificador del ingrediente',
  `fecha_ingreso` datetime NOT NULL COMMENT 'Fecha de ingreso del ingrediente a la despensa',
  `id_unidad_medida` varchar(5) NOT NULL COMMENT 'Identificador de la unidad de medida',
  `cantidad_inicial` double(6,2) NOT NULL COMMENT 'Cantidad inicial de unidades de medida del ingrediente',
  `cantidad_disponible` double(6,2) NOT NULL COMMENT 'Cantidad disponible de unidades de medida del ingrediente',
  PRIMARY KEY (`id_despensa`),
  KEY `FK_id_ingrediente` (`id_ingrediente`),
  KEY `FK_id_unidad_medida` (`id_unidad_medida`),
  CONSTRAINT `FK_id_ingrediente` FOREIGN KEY (`id_ingrediente`) REFERENCES `cat_ingrediente` (`id_ingrediente`),
  CONSTRAINT `FK_id_unidad_medida` FOREIGN KEY (`id_unidad_medida`) REFERENCES `cat_unidad_medida` (`id_unidad_medida`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1 COMMENT='Despensa de los ingredientes';

INSERT INTO `despensa` VALUES (1,1,'2021-01-08 00:11:40','K',0.00,0.00),(2,2,'2021-01-08 00:11:40','K',0.00,0.00),(3,3,'2021-01-08 00:11:40','K',0.00,0.00),(4,4,'2021-01-08 00:11:40','K',0.00,0.00),(5,5,'2021-01-08 00:11:40','K',0.00,0.00),(6,6,'2021-01-08 00:11:40','K',0.00,0.00),(7,7,'2021-01-08 00:11:40','K',0.00,0.00),(8,8,'2021-01-08 00:11:40','K',0.00,0.00),(9,9,'2021-01-08 00:11:40','K',0.00,0.00),(10,10,'2021-01-08 00:11:40','K',0.00,0.00),(11,11,'2021-01-08 00:11:40','K',0.00,0.00),(12,12,'2021-01-08 00:11:40','K',0.00,0.00),(13,13,'2021-01-08 00:11:40','K',0.00,0.00),(14,14,'2021-01-08 00:11:40','P',0.00,0.00),(15,15,'2021-01-08 00:11:40','K',0.00,0.00),(16,16,'2021-01-08 00:11:40','K',0.00,0.00),(17,17,'2021-01-08 00:11:40','K',0.00,0.00),(18,18,'2021-01-08 00:11:40','K',0.00,0.00),(19,19,'2021-01-08 00:11:40','K',0.00,0.00),(20,20,'2021-01-08 00:12:18','K',0.00,0.00),(21,21,'2021-01-08 00:12:37','P',0.00,0.00),(22,22,'2021-01-08 00:11:40','K',0.00,0.00),(23,23,'2021-01-08 00:11:40','P',0.00,0.00),(24,24,'2021-01-08 00:11:40','K',0.00,0.00),(25,25,'2021-01-08 00:12:51','K',0.00,0.00),(26,26,'2021-01-08 00:12:51','K',0.00,0.00),(27,27,'2021-01-08 00:12:51','K',0.00,0.00),(28,28,'2021-01-08 00:12:51','K',0.00,0.00),(29,29,'2021-01-08 00:12:52','K',0.00,0.00);

--
-- Table structure for table `receta`
--

DROP TABLE IF EXISTS `receta`;
CREATE TABLE `receta` (
  `id_receta` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador del registro',
  `id_platillo` int(11) NOT NULL COMMENT 'Identificador del platillo',
  `id_ingrediente` int(11) NOT NULL COMMENT 'Identificador del ingrediente',
  `id_unidad_medida` varchar(5) NOT NULL COMMENT 'Identificador de la unidad de medida',
  `cantidad_ingrediente` double(6,2) NOT NULL COMMENT 'Cantidad de unidades de medida del ingrediente requerida para el platillo',
  PRIMARY KEY (`id_receta`),
  KEY `FK_id_ingrediente2` (`id_ingrediente`),
  KEY `FK_id_unidad_medida2` (`id_unidad_medida`),
  CONSTRAINT `FK_id_ingrediente2` FOREIGN KEY (`id_ingrediente`) REFERENCES `cat_ingrediente` (`id_ingrediente`),
  CONSTRAINT `FK_id_unidad_medida2` FOREIGN KEY (`id_unidad_medida`) REFERENCES `cat_unidad_medida` (`id_unidad_medida`)
) ENGINE=InnoDB AUTO_INCREMENT=416 DEFAULT CHARSET=latin1 COMMENT='Relación de los ingredientes por platillo. La unidad de medida por ingrediente debe corresponder a la de la despensa';

INSERT INTO `receta` VALUES (1,1,5,'K',0.36),(2,1,24,'K',0.05),(3,2,5,'K',0.15),(4,2,28,'K',0.04),(5,2,27,'K',0.04),(6,3,4,'K',0.25),(7,4,5,'K',0.18),(8,4,4,'K',0.05),(9,4,19,'K',0.03),(10,4,12,'K',0.02),(11,4,18,'K',0.02),(12,4,24,'K',0.02),(13,4,2,'K',0.02),(14,5,5,'K',0.21),(15,5,17,'P',1.50),(16,5,1,'P',3.00),(17,5,22,'K',0.02),(18,5,29,'K',0.02),(19,5,6,'K',0.03),(20,5,10,'K',0.01),(21,5,18,'K',0.03),(22,5,2,'K',0.02),(23,6,5,'K',0.27),(24,6,17,'P',1.00),(25,6,1,'P',4.00),(26,6,22,'K',0.03),(27,6,29,'K',0.03),(28,6,6,'K',0.03),(29,6,10,'K',0.01),(30,6,18,'K',0.03),(31,6,2,'K',0.02),(32,7,25,'K',0.26),(33,7,17,'P',1.50),(34,7,1,'P',3.00),(35,7,22,'K',0.02),(36,7,29,'K',0.02),(37,7,6,'K',0.03),(38,7,10,'K',0.01),(39,7,18,'K',0.03),(40,7,2,'K',0.02),(41,8,25,'K',0.38),(42,8,17,'P',1.00),(43,8,1,'K',4.00),(44,8,22,'K',0.03),(45,8,29,'K',0.03),(46,8,6,'K',0.03),(47,8,10,'K',0.01),(48,8,18,'K',0.03),(49,8,2,'K',0.02),(50,9,5,'K',0.36),(51,9,4,'K',0.10),(52,9,19,'K',0.05),(53,9,12,'K',0.03),(54,9,18,'K',0.02),(55,9,6,'K',0.00),(56,9,24,'K',0.02),(57,9,2,'K',0.04),(58,10,5,'K',0.36),(59,10,4,'K',0.10),(60,10,19,'K',0.05),(61,10,12,'K',0.03),(62,10,18,'K',0.02),(63,10,6,'K',0.00),(64,10,24,'K',0.02),(65,10,2,'K',0.04),(66,11,5,'K',0.36),(67,11,4,'K',0.10),(68,11,19,'K',0.05),(69,11,12,'K',0.03),(70,11,18,'K',0.02),(71,11,6,'K',0.00),(72,11,24,'K',0.02),(73,11,2,'K',0.04),(74,12,5,'K',0.36),(75,12,4,'K',0.10),(76,12,19,'K',0.05),(77,12,12,'K',0.03),(78,12,18,'K',0.02),(79,12,6,'K',0.00),(80,12,24,'K',0.02),(81,12,2,'K',0.04),(82,13,5,'K',0.36),(83,13,4,'K',0.10),(84,13,19,'K',0.05),(85,13,12,'K',0.03),(86,13,18,'K',0.02),(87,13,6,'K',0.00),(88,13,24,'K',0.02),(89,13,2,'K',0.04),(90,14,5,'K',0.36),(91,14,4,'K',0.10),(92,14,19,'K',0.05),(93,14,12,'K',0.03),(94,14,18,'K',0.02),(95,14,6,'K',0.00),(96,14,24,'K',0.02),(97,14,2,'K',0.04),(98,15,5,'K',0.18),(99,15,4,'K',0.05),(100,15,19,'K',0.03),(101,15,12,'K',0.02),(102,15,18,'K',0.02),(103,15,24,'K',0.02),(104,15,2,'K',0.02),(105,16,5,'K',0.36),(106,16,4,'K',0.10),(107,16,19,'K',0.05),(108,16,12,'K',0.03),(109,16,18,'K',0.02),(110,16,6,'K',0.00),(111,16,24,'K',0.02),(112,16,2,'K',0.04),(113,17,5,'K',0.36),(114,17,4,'K',0.10),(115,17,19,'K',0.05),(116,17,12,'K',0.03),(117,17,18,'K',0.02),(118,17,6,'K',0.00),(119,17,24,'K',0.02),(120,17,2,'K',0.04),(121,18,5,'K',0.36),(122,18,4,'K',0.10),(123,18,19,'K',0.05),(124,18,12,'K',0.03),(125,18,18,'K',0.02),(126,18,6,'K',0.00),(127,18,24,'K',0.02),(128,18,2,'K',0.04),(129,19,5,'K',0.08),(130,19,14,'K',1.00),(131,19,19,'K',0.05),(132,19,12,'K',0.03),(133,19,18,'K',0.02),(134,19,6,'K',0.00),(135,19,24,'K',0.02),(136,19,2,'K',0.04),(137,20,6,'K',0.03),(138,20,10,'K',0.01),(139,20,18,'K',0.03),(140,20,2,'K',0.02),(141,21,5,'K',0.08),(142,21,27,'K',0.08),(143,21,6,'K',0.03),(144,21,10,'K',0.01),(145,21,18,'K',0.03),(146,21,2,'K',0.02),(147,22,5,'K',0.05),(148,22,6,'K',0.03),(149,22,10,'K',0.01),(150,22,18,'K',0.03),(151,22,2,'K',0.02),(152,23,5,'K',0.05),(153,23,6,'K',0.03),(154,23,10,'K',0.01),(155,23,18,'K',0.03),(156,23,2,'K',0.02),(157,24,5,'K',0.10),(158,24,6,'K',0.03),(159,24,10,'K',0.01),(160,24,18,'K',0.03),(161,24,2,'K',0.02),(162,25,5,'K',0.08),(163,25,6,'K',0.03),(164,25,10,'K',0.01),(165,25,18,'K',0.03),(166,25,2,'K',0.02),(167,26,5,'K',0.24),(168,26,6,'K',0.03),(169,26,10,'K',0.01),(170,26,18,'K',0.03),(171,26,2,'K',0.02),(172,27,5,'K',0.17),(173,27,6,'K',0.03),(174,27,10,'K',0.01),(175,27,18,'K',0.03),(176,27,2,'K',0.02),(177,28,14,'P',1.00),(178,28,5,'K',0.09),(179,28,27,'K',0.01),(180,28,28,'K',0.01),(181,28,6,'K',0.03),(182,28,10,'K',0.01),(183,28,18,'K',0.03),(184,28,2,'K',0.02),(185,29,14,'P',1.00),(186,29,5,'K',0.15),(187,29,6,'K',0.03),(188,29,10,'K',0.01),(189,29,18,'K',0.03),(190,29,2,'K',0.02),(191,30,14,'P',1.00),(192,30,5,'K',0.15),(193,30,6,'K',0.03),(194,30,10,'K',0.01),(195,30,18,'K',0.03),(196,30,2,'K',0.02),(197,30,26,'P',0.03),(198,31,14,'P',1.00),(199,31,5,'K',0.09),(200,31,27,'K',0.01),(201,31,28,'K',0.01),(202,31,6,'K',0.03),(203,31,10,'K',0.01),(204,31,18,'K',0.03),(205,31,26,'P',0.03),(206,32,19,'K',0.10),(207,32,12,'K',0.03),(208,32,18,'K',0.02),(209,32,6,'K',0.00),(210,32,24,'K',0.02),(211,32,2,'K',0.03),(212,32,28,'K',0.02),(213,32,27,'K',0.02),(214,32,5,'K',0.15),(215,33,15,'K',0.13),(216,33,4,'K',0.10),(217,33,19,'K',0.05),(218,33,12,'K',0.03),(219,33,18,'K',0.02),(220,33,6,'K',0.00),(221,33,24,'K',0.02),(222,33,2,'K',0.04),(223,34,15,'K',0.13),(224,34,4,'K',0.10),(225,34,19,'K',0.05),(226,34,12,'K',0.03),(227,34,18,'K',0.02),(228,34,6,'K',0.00),(229,34,24,'K',0.02),(230,34,2,'K',0.04),(231,35,15,'K',0.07),(232,35,4,'K',0.05),(233,35,19,'K',0.03),(234,35,12,'K',0.02),(235,35,18,'K',0.02),(236,35,24,'K',0.02),(237,35,2,'K',0.02),(238,36,15,'K',0.13),(239,36,22,'K',0.02),(240,36,29,'K',0.02),(241,36,5,'K',0.12),(242,36,19,'K',0.05),(243,36,12,'K',0.03),(244,36,18,'K',0.02),(245,36,6,'K',0.00),(246,36,24,'K',0.02),(247,36,2,'K',0.04),(248,36,4,'K',0.10),(249,37,15,'K',0.13),(250,37,5,'K',0.12),(251,37,28,'K',0.02),(252,37,27,'K',0.02),(253,37,19,'K',0.05),(254,37,12,'K',0.03),(255,37,18,'K',0.02),(256,37,6,'K',0.05),(257,37,24,'K',0.02),(258,37,2,'K',0.04),(259,37,4,'K',0.10),(260,38,15,'K',0.20),(261,38,6,'K',0.03),(262,38,10,'K',0.01),(263,38,18,'K',0.03),(264,38,2,'K',0.02),(265,39,5,'K',0.15),(266,39,27,'K',0.04),(267,40,16,'P',1.00),(268,40,22,'K',0.02),(269,40,29,'K',0.02),(270,40,5,'K',0.12),(271,40,28,'K',0.02),(272,40,27,'K',0.02),(273,40,4,'K',0.10),(274,40,19,'K',0.05),(275,40,12,'K',0.03),(276,40,18,'K',0.02),(277,40,6,'K',0.05),(278,41,16,'P',1.00),(279,41,4,'K',0.10),(280,41,19,'K',0.05),(281,41,12,'K',0.03),(282,41,18,'K',0.02),(283,41,6,'K',0.00),(284,41,24,'K',0.02),(285,41,2,'K',0.04),(286,42,16,'P',1.00),(287,42,4,'K',0.10),(288,42,19,'K',0.05),(289,42,12,'K',0.03),(290,42,18,'K',0.02),(291,42,6,'K',0.00),(292,42,24,'K',0.02),(293,42,2,'K',0.04),(294,43,16,'P',1.00),(295,43,4,'K',0.10),(296,43,19,'K',0.05),(297,43,12,'K',0.03),(298,43,18,'K',0.02),(299,43,6,'K',0.00),(300,43,24,'K',0.02),(301,43,2,'K',0.04),(302,44,16,'P',1.00),(303,44,4,'K',0.10),(304,44,19,'K',0.05),(305,44,12,'K',0.03),(306,44,18,'K',0.02),(307,44,6,'K',0.00),(308,44,24,'K',0.02),(309,44,2,'K',0.04),(310,45,6,'K',0.03),(311,45,10,'K',0.01),(312,45,18,'K',0.03),(313,45,2,'K',0.02),(314,46,5,'K',0.08),(315,46,27,'K',0.08),(316,46,26,'P',1.00),(317,46,19,'K',0.05),(318,46,12,'K',0.03),(319,46,18,'K',0.02),(320,46,6,'K',0.00),(321,46,24,'K',0.02),(322,46,2,'K',0.04),(323,47,27,'K',0.14),(324,47,4,'K',0.10),(325,47,19,'K',0.05),(326,47,12,'K',0.03),(327,47,18,'K',0.02),(328,47,6,'K',0.00),(329,47,24,'K',0.02),(330,47,2,'K',0.04),(331,48,5,'K',0.05),(332,48,4,'K',0.05),(333,48,19,'K',0.03),(334,48,12,'K',0.03),(335,48,18,'K',0.02),(336,48,24,'K',0.02),(337,48,2,'K',0.02),(338,49,5,'K',0.12),(339,49,17,'P',1.50),(340,49,1,'P',3.00),(341,49,28,'K',0.02),(342,49,27,'K',0.02),(343,49,25,'K',0.15),(344,49,6,'K',0.03),(345,49,10,'K',0.01),(346,49,18,'K',0.03),(347,49,2,'K',0.02),(348,50,5,'K',0.18),(349,50,17,'P',1.00),(350,50,1,'P',4.00),(351,50,28,'K',0.04),(352,50,27,'K',0.04),(353,50,25,'K',0.18),(354,50,6,'K',0.03),(355,50,10,'K',0.01),(356,50,18,'K',0.03),(357,50,2,'K',0.02),(358,51,5,'K',0.11),(359,51,19,'K',0.02),(360,51,18,'K',0.02),(361,51,6,'K',0.00),(362,51,24,'K',0.02),(363,51,2,'K',0.04),(364,52,5,'K',0.08),(365,52,4,'K',0.10),(366,52,19,'K',0.05),(367,52,12,'K',0.03),(368,52,18,'K',0.02),(369,52,6,'K',0.00),(370,52,24,'K',0.02),(371,52,2,'K',0.04),(372,53,5,'K',0.08),(373,53,4,'K',0.10),(374,53,19,'K',0.05),(375,53,12,'K',0.03),(376,53,18,'K',0.02),(377,53,24,'K',0.02),(378,53,2,'K',0.04),(379,54,5,'K',0.12),(380,54,27,'K',0.01),(381,54,28,'K',0.01),(382,54,6,'K',0.03),(383,54,10,'K',0.01),(384,54,18,'K',0.03),(385,54,2,'K',0.02),(386,55,5,'K',0.24),(387,55,6,'K',0.03),(388,55,10,'K',0.01),(389,55,18,'K',0.03),(390,55,2,'K',0.02),(391,56,27,'K',0.05),(392,57,5,'K',0.02),(393,57,28,'K',0.02),(394,57,27,'K',0.02),(395,57,23,'P',1.00),(396,57,6,'K',0.03),(397,57,10,'K',0.01),(398,57,18,'K',0.03),(399,57,2,'K',0.02),(400,58,5,'K',0.04),(401,58,28,'K',0.06),(402,58,27,'K',0.06),(403,58,23,'P',2.00),(404,58,6,'K',0.03),(405,58,10,'K',0.01),(406,58,18,'K',0.03),(407,58,2,'K',0.02),(408,59,5,'K',0.04),(409,59,28,'K',0.04),(410,59,27,'K',0.04),(411,59,23,'P',1.00),(412,59,6,'K',0.03),(413,59,10,'K',0.01),(414,59,18,'K',0.03),(415,59,2,'K',0.02);


--
-- Table structure for table `orden`
--

DROP TABLE IF EXISTS `orden`;
CREATE TABLE `orden` (
  `id_orden` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la orden',
  `id_empleado` int(11) NOT NULL COMMENT 'Identificador del empleado que atiende la orden',
  `fecha` datetime NOT NULL COMMENT 'Fecha de la orden',
  `costo_total` varchar(44) NOT NULL COMMENT 'Costo total por los platillos requeridos',
  `estatus` tinyint(4) NOT NULL COMMENT 'Estatus de la orden 0=cancelado 1=abierto, 2=cerrado, 3=perdida',
  PRIMARY KEY (`id_orden`),
  KEY `FK_id_empleado` (`id_empleado`),
  CONSTRAINT `FK_id_empleado` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1 COMMENT='Orden de la comanda';

INSERT INTO `orden` VALUES (1,2,'2021-04-09 02:05:20','$120',1),(2,2,'2021-01-09 02:10:44','$150',1),(3,2,'2021-01-09 02:11:57','$40',1),(4,2,'2021-01-09 12:18:52','$90',1),(5,2,'2021-01-10 01:09:56','$60',1),(6,2,'2021-01-10 01:41:54','$80',1);

--
-- Table structure for table `detalle_orden`
--

DROP TABLE IF EXISTS `detalle_orden`;
CREATE TABLE `detalle_orden` (
  `id_detalle` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador del detalle',
  `id_orden` int(11) NOT NULL COMMENT 'Identificador de la orden',
  `id_platillo` int(11) NOT NULL COMMENT 'Identificador del platillo',
  `cantidad` int(11) NOT NULL COMMENT 'Cantidad',
  `subtotal` varchar(44) NOT NULL COMMENT 'Subtotal que corresponde al precio del platillo por la cantidad',
  PRIMARY KEY (`id_detalle`),
  UNIQUE KEY `idx_detalle_orden` (`id_orden`,`id_platillo`),
  KEY `FK_id_platillo2` (`id_platillo`),
  CONSTRAINT `FK_id_orden` FOREIGN KEY (`id_orden`) REFERENCES `orden` (`id_orden`),
  CONSTRAINT `FK_id_platillo2` FOREIGN KEY (`id_platillo`) REFERENCES `cat_platillo` (`id_platillo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='platillos que se pidieron por cita';

CREATE USER 'Database User'@'localhost' IDENTIFIED BY 'Database User Password';
ALTER USER 'Database User'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Database User Password';
GRANT ALL PRIVILEGES ON marisco.* TO 'Database User'@'localhost' WITH GRANT OPTION ;
FLUSH PRIVILEGES;