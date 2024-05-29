USE chinook;
SELECT Name
FROM artist
WHERE ArtistId IN (SELECT ArtistId
        FROM album
        WHERE AlbumId IN ( SELECT AlbumId
			FROM track
			WHERE Milliseconds > 5 * 60 * 1000 
            ));