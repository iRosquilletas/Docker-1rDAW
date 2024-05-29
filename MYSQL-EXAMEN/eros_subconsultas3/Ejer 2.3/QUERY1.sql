-- OBTENER LAS CANCIONES CON UNA DURACIÓN SUPERIOR A LA MEDIA

select * from Track
where
		Milliseconds > (select avg(Milliseconds)
						from Track)