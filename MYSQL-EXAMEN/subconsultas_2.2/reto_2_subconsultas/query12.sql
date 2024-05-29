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