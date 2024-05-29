USE Chinook;
SELECT *
FROM Track
WHERE Milliseconds > (SELECT avg(Milliseconds)
                FROM Track)