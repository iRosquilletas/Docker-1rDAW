use chinook;
SELECT customer.FirstName, customer.LastName
FROM customer
WHERE
    ( SELECT COUNT(DISTINCT album.AlbumId)
        FROM album
        WHERE album.ArtistId = (
                SELECT ArtistId
                FROM artist
                WHERE Name = 'AC/DC')) = (
        SELECT COUNT(DISTINCT album2.AlbumId)
        FROM invoice
        INNER JOIN invoiceline ON invoice.InvoiceId = invoiceline.InvoiceId
        INNER JOIN track ON invoiceline.TrackId = track.TrackId
        INNER JOIN album album2 ON track.AlbumId = album2.AlbumId
        WHERE customer.CustomerId = invoice.CustomerId AND album2.ArtistId = (
			SELECT ArtistId
                FROM artist
                WHERE Name = 'AC/DC'));