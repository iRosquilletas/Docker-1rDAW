USE chinook;
SELECT CustomerId, FirstName, LastName, Country,
    CASE WHEN Country = 'USA' THEN 'Local' WHEN Country IS NULL THEN 'Desconocido'
        ELSE 'Internacional'
    END AS Categoria
FROM Customer;