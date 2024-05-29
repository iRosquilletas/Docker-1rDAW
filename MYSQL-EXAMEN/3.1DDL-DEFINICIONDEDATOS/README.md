En esta memoria veremos la definición de datos en Mysql, aprendemos como conectarnos a MySQL desde la terminal y gestionaremos las transacciones.

GitLab: https://gitlab.com/rosquilletas/bases-de-datos

# 1. Conexión a la base de datos con MYSQL CLI

Para conectarnos al mysql desde la terminal, debemos ejecutar el siguiente comando:
mysql -u root -p -h 127.0.0.1 -P 33006

-u: Usuario  
-p: Contraseña
-h: Host
-P: Puerto

Esto es lo mismo que hacerlo desde el MYSQL Workbench, pero esta vez desde la terminal

## COMANDOS

Ver todas las bases de datos

```sql
SHOW DATABASES;
```

Ver todas las tablas de una base de datos

```sql
SHOW TABLES FROM Chinook;
SHOW FULL TABLES FROM Chinook;
```

Ver todas las columnas de una tabla

```sql
SHOW COLUMS FROM Employee;
DESCRIBE Employee;
```

Seleccionar base de datos para trabajar con ella

```sql
USE Chinook;
```

Como ver con cual base de datos estoy trabajado

```sql
SELECT DATABASE()
```

Como desceleccionar la base de datos con la que estoy trabajando

```sql
CREATE DATABASE xd;
USE xd;
DROP xd;
```

# 2. TCL: Commit, Rollback y Autocommit

### ¿Para qué sirve?

Se usa para gestionar las transacciones en MySQL, así nuestras operaciones serán consistentes y recuperables.

### Qué posibilidad tenemos?

Pdemos controlar la consistencia, la durabilidad, el aislamiento y deshacer cambios que no queriamos.

## Comandos

autocommit

```sql
SELECT @@autocommit;
SELECT @@autocommit;
```

Volver a un commit atras

```sql
ROLLBACK
```

Hacer commit

```sql
COMMIT
```

Poner el commit a 0

```sql
SET AUTOCOMMIT=0;
```

Ver que funciona el commit y al hacer rollback para que se quita la tabla que creamos

```sql
SET autocommit=0;
commit; -- hace el commit
INSERT INTO empresa.COMANDA VALUES(630, CURRENT_DATE(), "A", 100, "1987-01-23", 23490.90)
SELECT * FROM COMANDA;
ROLLBACK -- para volver
SELECT @@autocommit; -- ver en cual commit estamos
```

# 3. CREACIÓN DE BASE DE DATOS RALLANÉ

Ahora vamos a crear una base de datos "Rallane" con 3 tablas

### ¿Qué tipos elegimos?

Elegiremos los tipos de datos que sean apropiados para la información que tenga la columna, como por ejemplo "INT" para identificadores y "VARCHAR" para texto.

### ¿Qué restricciones ponemos?

Usaremos "PRIMARY KEY" para identificar unicamente cada registro, y "UNIQUE" para asegurar que ciertos valores no se repitan cuando no deben hacerlo.

### ¿Por qué?

Porque de esta forma se asegura la integridad y consistencia de los datos en la base de datos.

```sql
CREATE DATABASE Rallane;
```

### TABLA PASAJEROS

```sql
CREATE TABLE `Rallane`.`Pasajeros` (
  `idPasajeros` INT NOT NULL,
  `Nombre` VARCHAR(100) NOT NULL,
  `Documento` VARCHAR(45) NOT NULL,
  `TipoDocumento` VARCHAR(15) NOT NULL,
  `FechaNacimiento` DATE NOT NULL,
  `Nacionalidad` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPasajeros`),
  UNIQUE INDEX `Documento_UNIQUE` (`Documento` ASC) VISIBLE);
```

### TABLA VUELOS

```sql
CREATE TABLE `Rallane`.`Vuelos` (
  `idVuelos` INT NOT NULL,
  `NPlazas` VARCHAR(45) NULL,
  `Origen` VARCHAR(50) NULL,
  `Destino` VARCHAR(50) NULL,
  `Compañia` VARCHAR(45) NULL,
  `FechaHora` VARCHAR(45) NULL,
  PRIMARY KEY (`idVuelos`));
```

### TABLA RESERVAS

```sql
CREATE TABLE `Rallane`.`Reservas` (
  `idReserva` INT NOT NULL,
  `idPasajero` VARCHAR(45) NOT NULL,
  `idVuelo` VARCHAR(45) NOT NULL,
  `Asiento` CHAR(3) NOT NULL,
  PRIMARY KEY (`idReserva`));
```

# PREGUNTAS

### ¿Por qué necesitamos tres tablas?

Para que haya una tabla intermediaria que las pueda relaciones, es decir, que es de muchos a muchos.

### ¿Cuáles son las claves primarias y foráneas?

Claves primarias:

- Pasajeros: idPasajeros
- Vuelos: idVuelos
- Reservas: idReserva

Claves foráneas:

- idPasajero en Reservas debe referencia a idPasajeros en Pasajero
- "idVuelo" en "Reservas" debe referenciar a "idVuelos" en "Vuelos"

### ¿Por qué utilizamos las restricciones que hemos definido y no otras?

Porque de esta forma nos aseguramos de que los datos sean unicos y no se dupliquen. De esta forma podemos mantener la integridad de los datos y evitar errores de duplicaciones y conflictos entre las tablas.
