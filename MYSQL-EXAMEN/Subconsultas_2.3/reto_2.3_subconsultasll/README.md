# Reto 2.3: Consultas con subconsultas II

**[Bases de Datos] Unidad Didáctica 2: DML - Consultas Avanzadas**

Para este reto, volveremos a usar la base de datos Chinook (más información en el Reto 2.1).

![Diagrama relacional de Chinook (fuente: github.com/lerocha/chinook-database).](https://github.com/lerocha/chinook-database/assets/135025/cea7a05a-5c36-40cd-84c7-488307a123f4)

Mi GitLab: https://gitlab.com/rosquilletas/bases-de-datos

Tras cargar esta base de datos en tu SGBD, realiza las siguientes consultas:

## Subconsultas Escalares (Scalar Subqueries)

Estas subconsultas devuelven un solo valor, por lo general, se utilizan en contextos donde se espera un solo valor, como parte de una condición `WHERE`, `SELECT`, `HAVING`, etc.
Ejemplo:

_Obtener una lista de empleados que ganan más que el salario medio de la empresa. [1]_

```sql
SELECT
  lastname,
  firstname,
  salary
FROM employee
WHERE salary > (SELECT avg(salary)
                FROM employee)
```

### Consulta 1

Obtener las canciones con una duración superior a la media.

```sql
USE Chinook;
SELECT *
FROM Track
WHERE Milliseconds > (SELECT avg(Milliseconds)
FROM Track)
```

### Consulta 2

Listar las 5 últimas facturas del cliente cuyo email es "emma_jones@hotmail.com".

```sql
USE Chinook;
SELECT *
FROM Invoice
WHERE CustomerId IN (SELECT CustomerId
FROM Customer
WHERE Email = "emma_jones@hotmail.com"
LIMIT 5
);
```

## Subconsultas de varias filas

Diferenciamos dos tipos:

1. Subconsultas que devuelven una columna con múltiples filas (es decir, una lista de valores). Suelen incluirse en la cláusula `WHERE` para filtrar los resultados de la consulta principal. En este caso, suelen utilizarse con operadores como `IN`, `NOT IN`, `ANY`, `ALL`, `EXISTS` o `NOT EXISTS`.
2. Subconsultas que devuelven múltiples columnas con múltiples filas (es decir, tablas). Se comportan como una tabla temporal y se utilizan en lugares donde se espera una tabla, como en una cláusula `FROM`. [2]

### Consulta 3

Mostrar las listas de reproducción en las que hay canciones de reggae.

```sql
USE Chinook;
SELECT Name
FROM Playlist
WHERE PlaylistId in (SELECT PlaylistId
	FROM PlaylistTrack
		Where TrackId in (SELECT TrackId
			FROM Track
				Where GenreId in (select GenreId
					FROM Genre
						where name like "Reggae"
								)
						)
					);


USE chinook;
SELECT * FROM playlist
WHERE PlaylistId IN ( SELECT PlaylistId FROM playlisttrack
WHERE TrackId IN ( SELECT TrackId FROM track
WHERE GenreId IN ( SELECT GenreId FROM genre
WHERE genre.Name = "Reggae"
)));
```

### Consulta 4

Obtener la información de los clientes que han realizado compras superiores a 20€.

```sql
USE chinook;
SELECT FirstName, LastName, Email
FROM Customer
WHERE CustomerId IN (SELECT CustomerId
        FROM Invoice
        WHERE Total > 20
    );
```

### Consulta 5

Álbumes que tienen más de 15 canciones, junto a su artista.

```sql
USE Chinook;
SELECT * FROM Album JOIN Artist USING (ArtistId)
WHERE AlbumId IN (
	SELECT AlbumId
    FROM Track
    GROUP BY AlbumId
    HAVING COUNT(*) > 15
);
```

### Consulta 6

Obtener los álbumes con un número de canciones superiores a la media.

```sql
USE Chinook;

-- ID Y N canciones de cada álbym
SELECT AlbumId, COUNT(*) AS N_Canciones
FROM Track
GROUP BY AlbumId;

-- Media de canciones en todos los álbumes
SELECT AVG(N_Canciones) FROM
(
	SELECT AlbumId, COUNT(*) AS N_Canciones
	FROM Track
	GROUP BY AlbumId
) AS Album_NCanciones;

-- AlbumId, junto al número de canciones
SELECT AlbumId, COUNT(*) AS N_Canciones
FROM Track
GROUP BY AlbumId
HAVING N_Canciones > (SELECT AVG(N_Canciones) FROM
(
	SELECT AlbumId, COUNT(*) AS N_Canciones
	FROM Track
	GROUP BY AlbumId
) AS Album_NCanciones

);

-- info de los albumes con más canciones
SELECT * FROM Album
WHERE Albumid in
(
select Albumid
from Track
group by AlbumId
having count(*)> (
select avg(N_canciones) FROM ( select AlbumId, count(*) as N_canciones
from Track
group by AlbumId
) as album_canciones
)
);
```

### Consulta 7

Obtener los álbumes con una duración total superior a la media.

```sql
USE chinook;
SELECT  AlbumId, SUM(Milliseconds) AS duracion
FROM Track
GROUP BY AlbumId
HAVING duracion > (SELECT AVG(duracion)
        FROM (SELECT AlbumId, SUM(Milliseconds) AS duracion
            FROM Track
            GROUP BY AlbumId) AS duracionDelAlbum
    );


-- Obtener los albumes con una duracion total  superiorr a la media.

-- Duracion total de un album
SELECT * FROM Album;
SELECT * FROM Track;

-- Duracion de cada pista de album 1
SELECT Milliseconds FROM Track
WHERE AlbumId = 1;


-- Duracion total de cada album
SELECT AlbumId,  SUM(Milliseconds) AS DuracionTotal
FROM Track
GROUP BY AlbumId;

-- Álbumes con duración total superior a un número
SELECT AlbumId, SUM(Milliseconds) AS DuracionTotal
FROM Track
GROUP BY AlbumId
HAVING DuracionTotal > (2500000);


-- Media de la duración de los álbumes
SELECT AVG(DuracionTotal)
FROM (
SELECT AlbumId, SUM(Milliseconds) AS DuracionTotal
FROM Track
GROUP BY AlbumId
) AS AlbumDuracion;


SELECT AVG(DuracionTotal)
FROM (
SELECT AlbumId, SUM(Milliseconds) AS DuracionTotal
FROM Track
GROUP BY AlbumId
) AS AlbumDuracion
WHERE DuracionTotal > 250000;



-- Albymes con duracion sea superior a la media

SELECT AlbumId, SUM(Milliseconds) AS DuracionTotal
FROM Track
GROUP BY AlbumId
HAVING DuracionTotal > (
	SELECT AVG(DuracionTotal)
	FROM (
	SELECT AlbumId, SUM(Miliseconds) AS DuracionTotal
	FROM Track
	GROUP BY AlbumId
) AS AlbumDuracion
);



```

### Consulta 8

Canciones del género con más canciones.

```sql
USE chinook;
SELECT Track.Name, Genre.Name
FROM Track
INNER JOIN Genre ON Track.GenreId = Genre.GenreId
WHERE Genre.GenreId = (SELECT GenreId
        FROM(SELECT GenreId, COUNT(*) AS numeroCanciones
                FROM Track
                GROUP BY GenreId
                ORDER BY COUNT(*) DESC
                LIMIT 1
            ) AS generoComun
    );

```

### Consulta 9

Canciones de la _playlist_ con más canciones.

```sql
USE chinook;
SELECT Track.Name, Playlist.Name
FROM Track
INNER JOIN PlaylistTrack ON Track.TrackId = PlaylistTrack.TrackId
INNER JOIN Playlist ON PlaylistTrack.PlaylistId = Playlist.PlaylistId
WHERE Playlist.PlaylistId = (
	SELECT PlaylistId
        FROM (SELECT PlaylistId, COUNT(*) AS numeroCanciones
                FROM PlaylistTrack
                GROUP BY PlaylistId
                ORDER BY COUNT(*) DESC
                LIMIT 1
            ) PlaylistWithMostTracks
    );

```

## Subconsultas Correlacionadas (Correlated Subqueries):

Son subconsultas en las que la subconsulta interna depende de la consulta externa. Esto significa que la subconsulta se ejecuta una vez por cada fila devuelta por la consulta externa, suponiendo una gran carga computacional.
Ejemplo:

_Supongamos que queremos encontrar a todos los empleados con un salario superior al promedio de su departamento. [1]_

```sql
SELECT
  lastname,
  firstname,
  salary
FROM employee e1
WHERE e1.salary > (SELECT avg(salary)
                   FROM employee e2
                   WHERE e2.dept_id = e1.dept_id)
```

La principal diferencia entre una subconsulta correlacionada en SQL y una subconsulta simple es que las subconsultas correlacionadas hacen referencia a columnas de la tabla externa. En el ejemplo anterior, `e1.dept_id` es una referencia a la tabla de la subconsulta externa. [1]

### Consulta 10

Muestra los clientes junto con la cantidad total de dinero gastado por cada uno en compras.

```sql
USE chinook;
SELECT FirstName, LastName, SUM(Invoice.Total) AS Total
FROM Customer
INNER JOIN Invoice ON Customer.CustomerId = Invoice.CustomerId
GROUP BY Customer.CustomerId, Customer.FirstName, Customer.LastName;
```

### Consulta 11

Obtener empleados y el número de clientes a los que sirve cada uno de ellos.

```sql
-- Obtener empleados y el número de clientes a los que sirve cada uno de ellos.

DESCRIBE Customer;

-- Empleado con Número de clientes asociados

SELECT SupportRepId, COUNT(*) AS N_Customers
FROM Customer
GROUP BY SupportRepId;


-- Sacar info de cada empleado (usando JOIN)
SELECT EmployeeId, FirstName, LastName, N_Customers
FROM Employee
JOIN (
SELECT SupportRepId, COUNT(*) AS N_Customers
FROM Customer
GROUP BY SupportRepId
) AS Empleado_NCustomers
ON Employee.EmployeeId = Empleado_NCustomers.SupportRepId;

-- Sacar info de cada empleado (usando subconsultas correlacionadas)
SELECT EmployeeId, FirstName, LastName, (
	SELECT COUNT(*) AS N_Customers
    FROM Customer
    WHERE Customer.SupportRepId = Employee.EmployeeId
    ) AS N_Customers
FROM Employee;
```

### Consulta 12

Ventas totales de cada empleado.

```sql
USE chinook;
SELECT EmployeeId, FirstName, LastName,
    (
        SELECT SUM(Invoice.Total)
        FROM Invoice
        WHERE Invoice.CustomerId IN (
            SELECT Customer.CustomerId
            FROM Customer
            WHERE Customer.SupportRepId = Employee.EmployeeId
        )
    ) AS TotalSales
FROM Employee
WHERE Title = 'Sales Support Agent';


--otra forma
-- Ejercicio 12 Ventas totales de cada empleado
USE Chinook;
DESCRIBE Employee;
DESCRIBE Invoice;
DESCRIBE Customer;

-- Total de facturas del cliente 1
SELECT SUM(Total) FROM Invoice
WHERE CustomerId IN (1,3,12);

-- Clientes de cada empleado
SELECT CustomerId FROM Customer
WHERE SupportRepId = 3;


-- Total de las facturas de varios clientes
SELECT SUM(Total) FROM Invoice
Where CustomerId IN (1,3,12);

-- Total de la facturas de todos los clientes de un empleado
SELECT 3 AS EmployeeId, SUM(Total) FROM Invoice
WHERE CustomerId IN (
	SELECT CustomerId FROM Customer
    WHERE SupportRepId = 3
    );

    -- Datos de los empleados
    SELECT EmployeeId, LastName, FirstName, (
    SELECT SUM(Total) FROM Invoice
	WHERE CustomerId IN (
	SELECT CustomerId FROM Customer
    WHERE SupportRepId = EmployeeId
    )
) AS TotalVentas
FROM Employee AS E;

```

Este conjunto de consultas SQL está diseñado para analizar datos relacionados con clientes, empleados y facturas en una base de datos de ejemplo.

Total de facturas del cliente 1:
Esta consulta busca el total de todas las facturas para el cliente con CustomerId igual a 1, 3 o 12.

Clientes de cada empleado:
Esta consulta devuelve los CustomerId de los clientes asignados al empleado con SupportRepId igual a 3.

Total de las facturas de varios clientes:
Similar a la primera consulta, esta vez calcula el total de todas las facturas para los clientes con CustomerId igual a 1, 3 o 12.

Total de la facturas de todos los clientes de un empleado:
Esta consulta busca el total de todas las facturas para los clientes asignados al empleado con SupportRepId igual a 3. Se usa una subconsulta para obtener los CustomerId de estos clientes.

Datos de los empleados:
Esta consulta combina datos de la tabla Employee con información sobre las ventas totales de cada empleado. Para cada empleado, se muestra su EmployeeId, LastName y FirstName, junto con el total de ventas calculado mediante una subconsulta. La subconsulta suma el total de las facturas para todos los clientes asignados a cada empleado.

En resumen, estas consultas proporcionan información sobre las ventas totales de los clientes asignados a empleados específicos, así como detalles sobre los empleados y los clientes que están relacionados con ellos.

### Consulta 13

Álbumes junto al número de canciones en cada uno.

```sql
USE chinook;
SELECT
    Album.Title,
    (
        SELECT COUNT(*)
        FROM Track
        WHERE Track.AlbumId = Album.AlbumId
    ) AS canciones
FROM Album;
```

### Consulta 14

Obtener el nombre del álbum más reciente de cada artista. Pista: los álbumes más antiguos tienen un ID más bajo.

```sql
USE chinook;
SELECT Artist.Name AS Nombre,
    (SELECT Title
        FROM Album
        WHERE Album.ArtistId = Artist.ArtistId
        ORDER BY Album.AlbumId DESC
        LIMIT 1
    ) AS ultimoAlbum
FROM Artist;
```

## Referencias

- [1] https://learnsql.es/blog/subconsulta-correlacionada-en-sql-una-guia-para-principiantes/
- [2] https://learnsql.es/blog/cuales-son-los-diferentes-tipos-de-subconsultas-sql/
