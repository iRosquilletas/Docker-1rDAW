USE chinook;
SELECT TrackId,Name, Milliseconds
FROM Track
WHERE Milliseconds > (
    SELECT AVG(Milliseconds)
    FROM Track);