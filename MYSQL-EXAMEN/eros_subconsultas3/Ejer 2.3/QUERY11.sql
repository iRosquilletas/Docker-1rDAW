-- Obtener empleados y el numero de clientes a los que sirve cada uno de ellos.

SELECT EmployeeId, FirstName, LastName, N_Customers FROM Employee
JOIN (

	SELECT SupportRepId, COUNT(*) AS N_Customers 
	from Customer
	GROUP BY SupportRepId

)as EmpledosNCustomers
ON Employee.EmployeeId= EmpledosNCustomers.SupportRepId;

-- SUBCUNSULTA CORRELACIONADA
select LastName , FirstName,(

	select count(Customer.CustomerId) from Customer
	where Customer.SupportRepId = Employee.EmployeeId
) as Clientes  from Employee