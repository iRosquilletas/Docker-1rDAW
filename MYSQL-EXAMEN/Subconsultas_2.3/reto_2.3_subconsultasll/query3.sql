USE Chinook;
SELECT Name 
FROM Playlist 
WHERE PlaylistId in (SELECT PlaylistId
	FROM PlaylistTrack
		Where TrackId in (SELECT TrackId
			FROM Track
				Where GenreId in (select GenreId
					FROM Genre
						where name like "Reggae"
								)
						)
					);