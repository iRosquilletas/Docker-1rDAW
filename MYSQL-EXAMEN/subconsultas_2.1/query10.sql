USE chinook;
SELECT Name, COUNT(*) AS Total
FROM Track
INNER JOIN InvoiceLine ON Track.TrackId = InvoiceLine.TrackId
GROUP BY Track.TrackId
ORDER BY Total DESC
LIMIT 10;