USE chinook;
SELECT FirstName, LastName, SUM(Invoice.Total) AS Total
FROM Customer
INNER JOIN Invoice ON Customer.CustomerId = Invoice.CustomerId
GROUP BY Customer.CustomerId, Customer.FirstName, Customer.LastName;