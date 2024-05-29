-- Mostrar las listas de reproducción en las que hay canciones de reggae.

Select * from PlaylistTrack
where TrackId IN (
    select TrackId from Track
    where GenreId IN (
		select GenreId from Genre
        where Name like "Reggae"
    )
);


select Name from Playlist
where PlaylistId in (
    select PlaylistId  from PlaylistTrack
		where TrackId in (
			select TrackId from Track
				where GenreId in (
					select GenreId from Genre
                    where Name like "Reggae"
                )
        ) 
)

-- la correcta es esta

