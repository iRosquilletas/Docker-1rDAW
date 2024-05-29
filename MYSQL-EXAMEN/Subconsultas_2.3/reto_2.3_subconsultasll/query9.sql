USE chinook;
SELECT Track.Name, Playlist.Name
FROM Track
INNER JOIN PlaylistTrack ON Track.TrackId = PlaylistTrack.TrackId
INNER JOIN Playlist ON PlaylistTrack.PlaylistId = Playlist.PlaylistId
WHERE Playlist.PlaylistId = (
	SELECT PlaylistId
        FROM (SELECT PlaylistId, COUNT(*) AS numeroCanciones
                FROM PlaylistTrack
                GROUP BY PlaylistId
                ORDER BY COUNT(*) DESC
                LIMIT 1
            ) PlaylistWithMostTracks
    );