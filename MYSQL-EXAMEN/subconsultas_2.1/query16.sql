USE chinook;
SELECT EmployeeId, FirstName, LastName, Title,
    CASE
        WHEN Title LIKE '%Manager%' THEN 'Manager'
        WHEN Title LIKE '%Assistant%' THEN 'Assistant'
        ELSE 'Empleado'
    END AS Nivel
FROM Employee;