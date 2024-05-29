USE chinook;
SELECT FirstName, LastName, Email
FROM Customer
WHERE CustomerId IN (SELECT CustomerId
        FROM Invoice
        WHERE Total > 20
    );