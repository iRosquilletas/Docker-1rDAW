```sql
-- Crear la base de datos
CREATE DATABASE tienda_musica;

-- Usar la base de datos
USE tienda_musica;

-- Crear la tabla de artistas
CREATE TABLE artistas (
    ArtistId INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255)
);

-- Crear la tabla de álbumes
CREATE TABLE albums (
    AlbumId INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255),
    ArtistId INT,
    FOREIGN KEY (ArtistId) REFERENCES artistas(ArtistId)
);

-- Crear la tabla de canciones
CREATE TABLE canciones (
    TrackId INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255),
    AlbumId INT,
    Genre VARCHAR(255),
    Composer VARCHAR(255),
    Milliseconds INT,
    Bytes INT,
    UnitPrice DECIMAL(10,2),
    FOREIGN KEY (AlbumId) REFERENCES albums(AlbumId)
);

-- Crear la tabla de clientes
CREATE TABLE clientes (
    CustomerId INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Email VARCHAR(255),
    Country VARCHAR(255)
);

-- Crear la tabla de facturas
CREATE TABLE facturas (
    InvoiceId INT AUTO_INCREMENT PRIMARY KEY,
    CustomerId INT,
    InvoiceDate DATETIME,
    Total DECIMAL(10,2),
    FOREIGN KEY (CustomerId) REFERENCES clientes(CustomerId)
);

-- Crear la tabla de detalles de facturas
CREATE TABLE detalle_facturas (
    InvoiceLineId INT AUTO_INCREMENT PRIMARY KEY,
    InvoiceId INT,
    TrackId INT,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    FOREIGN KEY (InvoiceId) REFERENCES facturas(InvoiceId),
    FOREIGN KEY (TrackId) REFERENCES canciones(TrackId)
);
```

Primary Key (Clave Primaria):

En una tabla, la primary key es un campo o una combinación de campos que identifica de manera única cada fila en la tabla.
Se utiliza para garantizar la unicidad de las filas y para permitir un acceso rápido a los datos.
Se define al crear la tabla utilizando la cláusula PRIMARY KEY.
Foreign Key (Clave Foránea):

Una foreign key es un campo (o conjunto de campos) en una tabla que hace referencia a la primary key de otra tabla.
Se utiliza para establecer una relación entre dos tablas.
Se define al crear la tabla utilizando la cláusula FOREIGN KEY.
Las foreign keys garantizan la integridad referencial, lo que significa que no se pueden insertar valores que no existan en la tabla referenciada.
REFERENCES (Referencias):

La cláusula REFERENCES se utiliza para establecer la relación entre dos tablas mediante foreign keys.
Indica qué columna(s) en la tabla actual hacen referencia a la primary key de otra tabla.
Se utiliza junto con la cláusula FOREIGN KEY.
Especifica la tabla y la columna(s) a la que se hace referencia en la otra tabla.
En el ejemplo que proporcioné anteriormente:

En la tabla albums, la columna ArtistId es una foreign key que hace referencia a la primary key (ArtistId) en la tabla artistas. Esto establece una relación entre los álbumes y los artistas.
En la tabla detalle_facturas, las columnas InvoiceId y TrackId son foreign keys que hacen referencia a las primary keys (InvoiceId y TrackId respectivamente) en las tablas facturas y canciones. Esto establece una relación entre los detalles de la factura y las facturas, y entre los detalles de la factura y las canciones.

## INSERTAR DATOS

```sql
-- Insertar datos en la tabla de artistas
INSERT INTO artistas (Name) VALUES ('Queen');
INSERT INTO artistas (Name) VALUES ('The Beatles');

-- Insertar datos en la tabla de álbumes
INSERT INTO albums (Title, ArtistId) VALUES ('A Night at the Opera', 1);
INSERT INTO albums (Title, ArtistId) VALUES ('Abbey Road', 2);

-- Insertar datos en la tabla de canciones
INSERT INTO canciones (Name, AlbumId, Genre, Composer, Milliseconds, Bytes, UnitPrice)
VALUES ('Bohemian Rhapsody', 1, 'Rock', 'Freddie Mercury', 355000, 5242880, 0.99);
INSERT INTO canciones (Name, AlbumId, Genre, Composer, Milliseconds, Bytes, UnitPrice)
VALUES ('Come Together', 2, 'Rock', 'John Lennon, Paul McCartney', 259000, 4587520, 0.99);

-- Insertar datos en la tabla de clientes
INSERT INTO clientes (FirstName, LastName, Email, Country)
VALUES ('John', 'Doe', 'john@example.com', 'USA');
INSERT INTO clientes (FirstName, LastName, Email, Country)
VALUES ('Jane', 'Smith', 'jane@example.com', 'UK');

-- Insertar datos en la tabla de facturas
INSERT INTO facturas (CustomerId, InvoiceDate, Total)
VALUES (1, '2024-05-30 10:00:00', 9.99);
INSERT INTO facturas (CustomerId, InvoiceDate, Total)
VALUES (2, '2024-05-30 11:00:00', 15.99);

-- Insertar datos en la tabla de detalles de facturas
INSERT INTO detalle_facturas (InvoiceId, TrackId, Quantity, UnitPrice)
VALUES (1, 1, 1, 0.99);
INSERT INTO detalle_facturas (InvoiceId, TrackId, Quantity, UnitPrice)
VALUES (2, 2, 2, 0.99);
```

## MODIFICAR

```sql
-- Agregar una nueva columna
ALTER TABLE canciones
ADD Description VARCHAR(255);

-- Modificar el tipo de datos de una columna existente
ALTER TABLE canciones
MODIFY Milliseconds BIGINT;

-- Cambiar el nombre de una columna
ALTER TABLE canciones
CHANGE Composer Songwriter VARCHAR(255);

-- Eliminar una columna
ALTER TABLE canciones
DROP COLUMN Bytes;
```

## BORRAR

```sql
-- Borrar datos de una tabla
DELETE FROM canciones WHERE Genre = 'Rock';

-- Borrar una tabla completa
DROP TABLE detalle_facturas;

-- Borrar una base de datos completa
DROP DATABASE tienda_musica;
```

## ETC

```sql
-- Agregar una nueva columna con un valor predeterminado
ALTER TABLE clientes
ADD PhoneNumber VARCHAR(20) DEFAULT 'N/A';

-- Modificar el nombre de una tabla
ALTER TABLE detalle_facturas
RENAME TO invoice_details;

-- Modificar una columna para que no permita valores nulos
ALTER TABLE clientes
MODIFY Email VARCHAR(255) NOT NULL;

-- Modificar una columna para cambiar su longitud máxima
ALTER TABLE albums
MODIFY Title VARCHAR(100);

-- Modificar una columna para cambiar su nombre y su tipo de datos
ALTER TABLE facturas
CHANGE InvoiceDate BillingDate DATETIME;

-- Agregar una clave foránea a una tabla existente
ALTER TABLE detalle_facturas
ADD FOREIGN KEY (TrackId) REFERENCES canciones(TrackId);
```
