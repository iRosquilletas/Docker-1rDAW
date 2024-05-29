USE chinook;
SELECT *
FROM track
WHERE TrackId NOT IN ( SELECT TrackId
        FROM invoiceline
);