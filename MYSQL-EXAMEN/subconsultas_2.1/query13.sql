USE chinook;
SELECT Name, COUNT(*) AS ventas
FROM Track
INNER JOIN InvoiceLine ON Track.TrackId = InvoiceLine.TrackId
GROUP BY Track.TrackId
HAVING COUNT(*) > ( SELECT AVG(ventas)
        FROM ( SELECT COUNT(*) AS ventas
			FROM InvoiceLine
			GROUP BY TrackId) ventas)
ORDER BY COUNT(*) DESC;