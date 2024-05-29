USE chinook;
SELECT FirstName, LastName
FROM customer
WHERE CustomerId IN (
        SELECT Invoice.CustomerId
        FROM Invoice
        INNER JOIN InvoiceLine ON Invoice.InvoiceId = InvoiceLine.InvoiceId
        GROUP BY Invoice.CustomerId, Invoice.InvoiceId
        HAVING SUM(Quantity) > 0);