-- listar las 5 últimas facturas del cliente cuyo email es “emma_jones@hotmail.com”
SELECT * FROM Invoice
WHERE CustomerId IN (
    SELECT CustomerId FROM Customer
    WHERE Email LIKE 'emma_jones@hotmail.com'
--    limit 5
);

