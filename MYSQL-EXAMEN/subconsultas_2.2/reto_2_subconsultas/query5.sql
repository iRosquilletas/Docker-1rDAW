USE chinook;
SELECT 
    (SELECT EmployeeId FROM employee WHERE ReportsTo IS NULL) SupervisorId,
    (SELECT LastName FROM employee WHERE ReportsTo IS NULL) SupervisorLastName,
    (SELECT FirstName FROM employee WHERE ReportsTo IS NULL) SupervisorFirstName,
    e.EmployeeId SubordinateId,
    e.LastName SubordinateLastName,
    e.FirstName SubordinateFirstName
FROM employee e
WHERE  e.ReportsTo = (
        SELECT EmployeeId FROM employee WHERE ReportsTo IS NULL
    )
ORDER BY SupervisorId, SubordinateId;