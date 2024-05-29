USE Chinook;
SELECT *
FROM Invoice
WHERE CustomerId IN (SELECT CustomerId
FROM Customer
WHERE Email = "emma_jones@hotmail.com"
LIMIT 5