USE chinook;
SELECT EmployeeId, FirstName, LastName,
    (
        SELECT SUM(Invoice.Total)
        FROM Invoice
        WHERE Invoice.CustomerId IN (
            SELECT Customer.CustomerId
            FROM Customer
            WHERE Customer.SupportRepId = Employee.EmployeeId
        )
    ) AS TotalSales
FROM Employee
WHERE Title = 'Sales Support Agent';