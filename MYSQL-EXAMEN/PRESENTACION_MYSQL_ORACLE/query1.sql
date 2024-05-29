-- Quien es el profesor de base de datos

select nombre , apellido ,(

	select nombre from asignaturas
    where asignaturas.id_asignatura = profesores.asignatura_id

) AS asignatura FROM profesores 
WHERE id_profesor = 2 
