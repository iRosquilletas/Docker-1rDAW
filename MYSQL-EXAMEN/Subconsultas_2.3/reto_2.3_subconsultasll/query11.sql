-- Obtener empleados y el número de clientes a los que sirve cada uno de ellos.

DESCRIBE Customer;

-- Empleado con Número de clientes asociados

SELECT SupportRepId, COUNT(*) AS N_Customers
FROM Customer
GROUP BY SupportRepId;


-- Sacar info de cada empleado (usando JOIN)
SELECT EmployeeId, FirstName, LastName, N_Customers
FROM Employee
JOIN (
SELECT SupportRepId, COUNT(*) AS N_Customers
FROM Customer
GROUP BY SupportRepId
) AS Empleado_NCustomers
ON Employee.EmployeeId = Empleado_NCustomers.SupportRepId;

-- Sacar info de cada empleado (usando subconsultas correlacionadas)
SELECT EmployeeId, FirstName, LastName, (
	SELECT COUNT(*) AS N_Customers
    FROM Customer
    WHERE Customer.SupportRepId = Employee.EmployeeId
    ) AS N_Customers
FROM Employee;