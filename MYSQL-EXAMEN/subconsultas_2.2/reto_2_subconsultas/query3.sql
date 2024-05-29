USE chinook;
SELECT employee.FirstName, employee.LastName
FROM employee
WHERE EXISTS (SELECT 1
        FROM customer
        WHERE customer.SupportRepId = employee.EmployeeId
    );