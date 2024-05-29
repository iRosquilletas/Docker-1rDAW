USE chinook;
SELECT TrackId, Name, UnitPrice, Album.Title, Album.ArtistId, Album.AlbumId
FROM  Track
INNER JOIN Album ON Track.AlbumId = Album.AlbumId
WHERE Track.UnitPrice > (SELECT MAX(Track2.UnitPrice) FROM Track AS Track2 WHERE Track2.AlbumId = Track.AlbumId);