-- Álbumes junto al número de canciones en cada uno
select Title , (

	select count(AlbumId) from Track
    where Album.AlbumId=Track.AlbumId

) as paco 
from Album
