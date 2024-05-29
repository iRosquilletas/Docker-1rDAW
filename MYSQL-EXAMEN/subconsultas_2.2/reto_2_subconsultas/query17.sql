USE chinook;
SELECT Customer.CustomerId, Customer.FirstName, Customer.LastName, SUM(Invoice.Total) AS TotalPurchases,
    CASE
        WHEN SUM(Invoice.Total) > 500 THEN 'VIP'
        ELSE 'Error'
    END AS Category
FROM Customer
INNER JOIN Invoice ON Customer.CustomerId = Invoice.CustomerId
GROUP BY Customer.CustomerId;