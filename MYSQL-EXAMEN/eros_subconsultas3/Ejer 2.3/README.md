# RETO 2.2

EROS MUÑOZ ZANÓN

En este reto trabajamos con la base de datos `Chinook`. A continuación realizamos una serie de consultas para extraer la información pedida en cada uno de los enunciados.

El código fuente correspondiente a este reto puede consultarse en: https://gitlab.com/ErosMZ/base-de-datos.git

## QUERY 2

En este ejemplo he selecionado de la 

```sql
SELECT DISTINCT ar.Name AS 'Nombre de Artista'
FROM Artist AS ar
WHERE ar.ArtistId IN (
    SELECT al.ArtistId
    FROM Album AS al
    WHERE al.AlbumId IN (
        SELECT tr.AlbumId
        FROM Track AS tr
        WHERE tr.Milliseconds > 300000 
    )
);
```