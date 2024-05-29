USE Chinook;
SELECT * FROM Album JOIN Artist USING (ArtistId)
WHERE AlbumId IN (
	SELECT AlbumId
    FROM Track
    GROUP BY AlbumId
    HAVING COUNT(*) > 15
);