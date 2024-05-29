

select AlbumId , count(*) as N_Canciones
From Track
group by AlbumId;
	Select AVG(N_Canciones) from
	(
    
		select AlbumId, COUNT(*) as N_Canciones
        from Track
        group by AlbumId
        
    )as Album_NCanciones;