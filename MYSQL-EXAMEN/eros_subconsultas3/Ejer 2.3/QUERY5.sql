-- Álbumes que tienen más de 15 canciones, junto a su artista.
SELECT * FROM Album JOIN Artist USING (ArtistId)
where AlbumId in (
	select AlbumId
    from Track
    group by AlbumId
    HAVING COUNT(*) > 15
)