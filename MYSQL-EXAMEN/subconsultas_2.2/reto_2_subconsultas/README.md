# Reto 1: Consultas básicas

Samuel Borrás.

En este reto trabajamos con la base de datos `chinook`, que nos viene dada en la web `https://github.com/lerocha/chinook-database/releases/tag/v1.4.5`. A continuación realizamos una serie de consultas usando subconsultas, funciones de agregacion y casos. Para de esta forma extraer la información pedida en cada uno de los enunciados.

El código fuente correspondiente a este reto puede consultarse en: https://gitlab.com/rosquilletas/bases-de-datos

# EMPEZAMOS con las CONSULTAS

## Query 1

Muestra las listas de reproducción cuyo nombre comienza por M, junto a las 3
primeras canciones de cada uno, ordenadas por álbum y por precio (más bajo
primero).

```sql
USE chinook;
SELECT * FROM customer
WHERE Country = "France";
```

## Query 2

Muestra todos los artistas que tienen canciones con duración superior a 5 minutos.

```sql
USE chinook;
SELECT Name
FROM artist
WHERE ArtistId IN (SELECT ArtistId
        FROM album
        WHERE AlbumId IN ( SELECT AlbumId
			FROM track
			WHERE Milliseconds > 5 * 60 * 1000
            ));
```

## Query 3

Muestra nombre y apellidos de los empleados que tienen clientes asignados.
(Pista: se puede hacer con EXISTS).

```sql
USE chinook;
SELECT employee.FirstName, employee.LastName
FROM employee
WHERE EXISTS (SELECT 1
        FROM customer
        WHERE customer.SupportRepId = employee.EmployeeId
    );
```

## Query 4

Muestra todas las canciones que no han sido compradas.

```sql
USE chinook;
SELECT *
FROM track
WHERE TrackId NOT IN ( SELECT TrackId
        FROM invoiceline
);
```

## Query 5

Lista los empleados junto a sus subordinados (empleados que reportan a ellos).

```sql
USE chinook;
SELECT
    (SELECT EmployeeId FROM employee WHERE ReportsTo IS NULL) SupervisorId,
    (SELECT LastName FROM employee WHERE ReportsTo IS NULL) SupervisorLastName,
    (SELECT FirstName FROM employee WHERE ReportsTo IS NULL) SupervisorFirstName,
    e.EmployeeId SubordinateId,
    e.LastName SubordinateLastName,
    e.FirstName SubordinateFirstName
FROM employee e
WHERE  e.ReportsTo = (
        SELECT EmployeeId FROM employee WHERE ReportsTo IS NULL
    )
ORDER BY SupervisorId, SubordinateId;
```

## Query 6

Muestra todas las canciones que ha comprado el cliente Luis Rojas.

```sql
USE chinook;
SELECT Name
FROM track
WHERE track.TrackId IN (
        SELECT invoiceline.TrackId
        FROM invoiceline
        WHERE invoiceline.InvoiceId IN (
            SELECT invoice.InvoiceId
                FROM invoice
                WHERE invoice.CustomerId IN (
                    SELECT customer.CustomerId
                        FROM customer
                        WHERE customer.FirstName = 'Luis'
                        AND customer.LastName = 'Rojas'
				)));
```

## QUERY 7

Canciones que son más caras que cualquier otra canción del mismo álbum.

```sql
USE chinook;
SELECT TrackId, Name, UnitPrice, Album.Title, Album.ArtistId, Album.AlbumId
FROM  Track
INNER JOIN Album ON Track.AlbumId = Album.AlbumId
WHERE Track.UnitPrice > (SELECT MAX(Track2.UnitPrice) FROM Track AS Track2 WHERE Track2.AlbumId = Track.AlbumId);
```

# CONSULTAS CON SUBCONSULTAS Y FUNCIONES DE AGREGACIÓN

## QUERY 8

Clientes que han comprado todos los álbumes de un artista específico.

```sql
use chinook;
SELECT customer.FirstName, customer.LastName
FROM customer
WHERE
    ( SELECT COUNT(DISTINCT album.AlbumId)
        FROM album
        WHERE album.ArtistId = (
                SELECT ArtistId
                FROM artist
                WHERE Name = 'AC/DC')) = (
        SELECT COUNT(DISTINCT album2.AlbumId)
        FROM invoice
        INNER JOIN invoiceline ON invoice.InvoiceId = invoiceline.InvoiceId
        INNER JOIN track ON invoiceline.TrackId = track.TrackId
        INNER JOIN album album2 ON track.AlbumId = album2.AlbumId
        WHERE customer.CustomerId = invoice.CustomerId AND album2.ArtistId = (
			SELECT ArtistId
                FROM artist
                WHERE Name = 'AC/DC'));

```

## QUERY 9

Clientes que han comprado más de 20 canciones en una sola transacción.

```sql
USE chinook;
SELECT FirstName, LastName
FROM customer
WHERE CustomerId IN (
        SELECT Invoice.CustomerId
        FROM Invoice
        INNER JOIN InvoiceLine ON Invoice.InvoiceId = InvoiceLine.InvoiceId
        GROUP BY Invoice.CustomerId, Invoice.InvoiceId
        HAVING SUM(Quantity) > 0);
```

## QUERY 10

Muestra las 10 canciones más compradas.

```sql
USE chinook;
SELECT Name, COUNT(*) AS Total
FROM Track
INNER JOIN InvoiceLine ON Track.TrackId = InvoiceLine.TrackId
GROUP BY Track.TrackId
ORDER BY Total DESC
LIMIT 10;
```

## QUERY 11

Muestra las canciones con una duración superior a la media.

```sql
USE chinook;
SELECT TrackId,Name, Milliseconds
FROM Track
WHERE Milliseconds > (
    SELECT AVG(Milliseconds)
    FROM Track);
```

## QUERY 12

Para demostrar lo bueno que es nuestro servicio, muestra el número de países
donde tenemos clientes, el número de géneros músicales de los que disponemos y el número de pistas.

#### PAISES

```sql
USE chinook;
SELECT COUNT(DISTINCT Country) AS paises
FROM Customer;
```

#### GENEROS

```sql
SELECT COUNT(*) AS generos
FROM Genre;
```

#### PISTAS

```sql
SELECT COUNT(*) AS pistas
FROM Track;
```

## QUERY 13

Canciones vendidas más que la media de ventas por canción.

```sql
USE chinook;
SELECT Name, COUNT(*) AS ventas
FROM Track
INNER JOIN InvoiceLine ON Track.TrackId = InvoiceLine.TrackId
GROUP BY Track.TrackId
HAVING COUNT(*) > ( SELECT AVG(ventas)
        FROM ( SELECT COUNT(*) AS ventas
			FROM InvoiceLine
			GROUP BY TrackId) ventas)
ORDER BY COUNT(*) DESC;
```

# CONSULTAS CON CASOS

## QUERY 14

Clasifica a los clientes en tres categorías según su país: “Local” si el país es ‘USA’, “Internacional” si el país es distinto de ‘USA’, y “Desconocido” si el país es nulo.

```sql
USE chinook;
SELECT CustomerId, FirstName, LastName, Country,
    CASE WHEN Country = 'USA' THEN 'Local' WHEN Country IS NULL THEN 'Desconocido'
        ELSE 'Internacional'
    END AS Categoria
FROM Customer;
```

## QUERY 15

Calcula el descuento aplicado sobre cada factura, que depende del monto total
de la factura (10% para facturas superiores a $100).

```sql
USE chinook;
SELECT InvoiceId, Total,
    CASE
        WHEN Total > 100 THEN Total * 0.1
        ELSE 0
    END AS Descuento
FROM Invoice;

;
```

## QUERY 16

Clasifica a los empleados en diferentes niveles según su cargo (manager, asistente
o empleado).

```sql
USE chinook;
SELECT EmployeeId, FirstName, LastName, Title,
    CASE
        WHEN Title LIKE '%Manager%' THEN 'Manager'
        WHEN Title LIKE '%Assistant%' THEN 'Assistant'
        ELSE 'Empleado'
    END AS Nivel
FROM Employee;
```

## QUERY 17

Etiqueta a los clientes como “VIP” si han gastado más de $500 en compras
totales.

```sql
USE chinook;
SELECT Customer.CustomerId, Customer.FirstName, Customer.LastName, SUM(Invoice.Total) AS TotalPurchases,
    CASE
        WHEN SUM(Invoice.Total) > 500 THEN 'VIP'
        ELSE 'Error'
    END AS Category
FROM Customer
INNER JOIN Invoice ON Customer.CustomerId = Invoice.CustomerId
GROUP BY Customer.CustomerId;
```
