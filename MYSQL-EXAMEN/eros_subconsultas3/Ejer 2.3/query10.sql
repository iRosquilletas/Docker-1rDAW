-- Canciones de la playlist con más canciones
SELECT 
FirstName , LastName,
    (
        SELECT SUM(Invoice.Total) 
        FROM Invoice 
        WHERE Customer.CustomerId = Invoice.CustomerId
    ) AS paco
FROM 
    Customer;

select * from Invoice;