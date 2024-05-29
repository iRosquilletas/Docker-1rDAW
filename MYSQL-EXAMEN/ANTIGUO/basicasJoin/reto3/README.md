# Reto 1: Consultas básicas

# Reto 1: Consultas básicas

Samuel Borrás.

En este reto trabajamos con la base de datos `videoclub`. A continuación realizamos una serie de consultas para extraer la información pedida en cada uno de los enunciados.

El código fuente correspondiente a este reto puede consultarse en: https://gitlab.com/rosquilletas/bases-de-datos.git

## Query 1

Para mostrar la lista de las películas del videoclub junto al nombre de su género, usaremos lo siguiente:

```sql
USE videoclub;
SELECT PELICULA.CodiPeli, PELICULA.Titol, GENERE.Descripcio AS Genero
FROM PELICULA
JOIN GENERE ON PELICULA.CodiGenere = GENERE.CodiGenere;
```

## Query 2

Para listar todas las facturas de María, usaremos lo siguiente:

```sql
USE videoclub;
SELECT *
FROM FACTURA
WHERE DNI = '022222222R';
```

## Query 3

Para listar las películas junto a su actor principal, usaremos lo siguiente:

```sql
USE videoclub;
SELECT P.Titol, A.Nom AS 'Actor Principal'
FROM PELICULA P
JOIN ACTOR A ON P.CodiActor = A.CodiActor;
```

## Query 4

Para listar películas junto a todos los actores que la interpretaron, usaremos lo siguiente:

```sql
USE videoclub;
SELECT P.Titol, A.Nom AS 'Actores'
FROM PELICULA P
JOIN INTERPRETADA I ON P.CodiPeli = I.CodiPeli
JOIN ACTOR A ON I.CodiActor = A.CodiActor;
```

## Query 5

Para listar el ID y nombres de las películas junto a los ID y nombres de sus segundas partes, usaremos lo siguiente:

```sql
USE videoclub;
SELECT P1.CodiPeli AS 'ID Película', P1.Titol AS 'Película', P2.CodiPeli AS 'ID Segunda Parte', P2.Titol AS ' Segunda Parte'
FROM PELICULA P1
LEFT JOIN PELICULA P2 ON P1.SegonaPart = P2.CodiPeli;
```
