# Reto 1: Consultas básicas

Samuel Borrás.

En este reto trabajamos con la base de datos `chinook`, que nos viene dada en la web `https://github.com/lerocha/chinook-database/releases/tag/v1.4.5`. A continuación realizamos una serie de consultas para extraer la información pedida en cada uno de los enunciados.

El código fuente correspondiente a este reto puede consultarse en: https://gitlab.com/rosquilletas/bases-de-datos

## Query 1

Esto encuentra todos los paises de Francia:

```sql
USE chinook;
SELECT * FROM customer
WHERE Country = "France";
```

## Query 2

Esto muestra las facturas del priemr trimestre de este año:

```sql
USE chinook;
SELECT * FROM invoice
WHERE InvoiceDate >= "2021-01-01 00:00:00" AND InvoiceDate < "2021-04-01 00:00:00";

```

## Query 3

Muestra todas las canciones compuestas por AC/DC

```sql
USE chinook;
SELECT album.Title, artist.Name, album.ArtistId FROM album
JOIN artist ON album.ArtistId  = artist.ArtistId
WHERE artist.Name = "AC/DC";
```

## Query 4

Esto muestra las 10 canciones que más tamaño ocupan:

```sql

USE chinook;
SELECT * FROM track
ORDER BY Bytes DESC
LIMIT 10;
```

## Query 5

Esto muestra el nombre de aquellos países en los que tenemos clientes.

```sql
USE chinook;
SELECT DISTINCT Country
FROM customer;
```

## Query 6

Esto muestra todos los géneros musicales.

```sql
USE chinook;
SELECT Name FROM genre;
```

## QUERY 7

Esto muestra todos los artistas junto a sus álbumes.

```sql
USE chinook;
SELECT album.Title, artist.Name, album.ArtistId FROM album
JOIN artist ON album.ArtistId  = artist.ArtistId;
```

## QUERY 8

Esto muestra los nombres de los 15 empleados más jóvenes junto a los nombres de
sus supervisores, si los tienen

```sql
USE chinook;
SELECT * FROM employee
ORDER BY BirthDate DESC
LIMIT 15;

```

## QUERY 9

Esto muestra todas las facturas de los clientes berlineses. Deberán mostrarse las columnas: fecha de la factura, nombre completo del cliente, dirección de facturación,
código postal, país, importe (en este orden).

```sql
USE chinook;
SELECT invoice.InvoiceDate, invoice.BillingAddress, invoice.BillingCountry, invoice.Total, invoice.CustomerId, customer.FirstName, customer.LastName
FROM chinook.invoice
JOIN chinook.customer ON invoice.CustomerId = customer.CustomerId
WHERE invoice.BillingCountry = 'Germany' AND customer.City = 'Berlin';
```

## QUERY 10

Esto muestra las listas de reproducción cuyo nombre comienza por C, junto a todas
sus canciones, ordenadas por álbum y por duración.

```sql

USE chinook;
SELECT playlist.Name AS PlaylistName, track.Name AS TrackName, album.Title AS AlbumTitle, Track.Milliseconds
FROM playlist
JOIN PlaylistTrack ON Playlist.PlaylistId = PlaylistTrack.PlaylistId
JOIN Track ON PlaylistTrack.TrackId = Track.TrackId
JOIN Album ON Track.AlbumId = Album.AlbumId
WHERE Playlist.Name LIKE 'C%'
ORDER BY PlaylistName, AlbumTitle, Track.Milliseconds;
```

## QUERY 11

Esto muestra qué clientes han realizado compras por valores superiores a 10€, ordenados por apellido

```sql
USE chinook;
SELECT Customer.LastName, Customer.FirstName, SUM(Invoice.Total) AS TotalGastado
FROM Customer
JOIN Invoice ON Customer.CustomerId = Invoice.CustomerId
GROUP BY Customer.CustomerId
HAVING TotalGastado > 10
ORDER BY Customer.LastName;
```

## QUERY 12

Esto muestra el importe medio, mínimo y máximo de cada factura:

```sql
USE chinook;
SELECT InvoiceId,
       AVG(Total) AS medio,
       MIN(Total) AS minimo,
       MAX(Total) AS maximo
FROM Invoice
GROUP BY InvoiceId;
```

## QUERY 13

Esto muestra el número total de artistas

```sql
USE chinook;
SELECT COUNT(ArtistId) AS artistasTotales
FROM Artist;
```

## QUERY 14

Esto muestra el número de canciones del álbum “Out Of Time”:

```sql
USE chinook;
SELECT COUNT(TrackId) AS CancionesOutOfTime
FROM Track
WHERE AlbumId = (
    SELECT AlbumId
    FROM Album
    WHERE Title = 'Out Of Time'
);
```

## QUERY 15

Esto muestra el número de países donde tenemos clientes:

```sql
USE chinook;
SELECT COUNT(DISTINCT Country) AS NumeroPaises
FROM Customer;
;
```

## QUERY 16

Esto muestra el número de canciones de cada género (deberá mostrarse el nombre del
género):

```sql
USE chinook;
SELECT g.Name AS Genero, COUNT(t.TrackId) AS NumeroCanciones
FROM Genre g
LEFT JOIN Track t ON g.GenreId = t.GenreId
GROUP BY g.Name;
;
```

## QUERY 17

Esto muestra los álbumes ordenados por el número de canciones que tiene cada uno:

```sql
USE chinook;
SELECT a.Title AS Album, COUNT(t.TrackId) AS NumeroDeCanciones
FROM Album a
LEFT JOIN Track t ON a.AlbumId = t.AlbumId
GROUP BY a.Title
ORDER BY NumeroDeCanciones DESC;
```

## QUERY 18

Esto encuentra los géneros musicales más populares (los más comprados):

```sql
USE chinook;
SELECT g.Name AS Genero, SUM(i.Total) AS TotalComprado
FROM Genre g
JOIN Track t ON g.GenreId = t.GenreId
JOIN InvoiceLine il ON t.TrackId = il.TrackId
JOIN Invoice i ON il.InvoiceId = i.InvoiceId
GROUP BY g.Name
ORDER BY TotalComprado DESC;
```

## QUERY 19

Esto sirve para listar los 6 álbumes que acumulan más compras:

```sql
USE chinook;
SELECT a.Title AS Album, COUNT(il.InvoiceLineId) AS TotalCompras
FROM Album a
JOIN Track t ON a.AlbumId = t.AlbumId
JOIN InvoiceLine il ON t.TrackId = il.TrackId
GROUP BY a.Title
ORDER BY TotalCompras DESC
LIMIT 6;
```

## QUERY 20

Esto muestra los países en los que tenemos al menos 5 clientes:

```sql
USE chinook;
SELECT c.Country AS Pais, COUNT(c.CustomerId) AS TotalClientes
FROM Customer c
GROUP BY c.Country
HAVING COUNT(c.CustomerId) >= 5;
```
