# Opciones de Control de Acceso en MySQL

En esta memoria veremos las opciones de control de Acceso que ofrece MySQL.

## Registro, Modificación y Eliminación de Usuarios

### Registrar Nuevos Usuarios

Para registrar un nuevo usuario en MySQL, se utiliza el comando `CREATE USER`:

```sql
CREATE USER 'samuel'@'localhost' IDENTIFIED BY '1234';
```

### Modificar Usuarios

Para modificar un usuario, como cambiar su contraseña o nombre, se utiliza el comando ALTER USER:

```sql
ALTER USER 'samuel'@'localhost' IDENTIFIED BY '1234';
```

### DAR PERMISOS

```sql
GRANT SELECT ON nombre_de_la_base_de_datos.* TO 'samuel'@'localhost';
```

FLUSH PRIVILEGES;

## VER PERMISOS DE UN USUARIO

```sql
SHOW grants for 'usuario'@'localhost';
```

## PERMISOS QUE HAY

```
SELECT: Permite al usuario leer los datos de una tabla.
INSERT: Permite al usuario agregar nuevos registros a una tabla.
UPDATE: Permite al usuario modificar los registros existentes en una tabla.
DELETE: Permite al usuario eliminar registros de una tabla.
CREATE: Permite al usuario crear nuevas tablas o bases de datos.
ALTER: Permite al usuario modificar la estructura de una tabla existente.
DROP: Permite al usuario eliminar tablas o bases de datos existentes.
GRANT OPTION: Permite al usuario otorgar permisos a otros usuarios.
ALL PRIVILEGES: Otorga todos los permisos disponibles en una base de datos o tabla específica.
```

### QUITAR PERMISO

```sql
REVOKE SELECT ON Chinook.* FROM 'samuel'@'localhost';
```

### Eliminar Usuarios

Para eliminar un usuario, se utiliza el comando DROP USER:

```sql
DROP USER 'samuel'@'localhost';
```

## Autenticación de Usuarios

### Opciones de Autenticación

MySQL tiene autenciaciones como la Nativa y la Pluggable:

```sql
CREATE USER 'samuel'@'localhost' IDENTIFIED WITH 'xdplugin' BY '1234';
```

## Mostrar Usuarios Existentes y sus Permisos

Para mostrar los usuarios existentes:

```sql
SELECT user, host FROM mysql.user;
```

Para mostrar los permisos de un usuario específico:

```sql
SHOW GRANTS FOR 'samuel'@'localhost';
```

## Permisos y Granularidad

### Tipos de Permisos

Los permisos en MySQL pueden ser de varios tipos:

- GLOBAL: Afecta a todas las bases de datos y tablas.
- DATABASE: Afecta a todas las tablas en una base de datos específica.
- TABLE: Afecta a una tabla específica.
- COLUMN: Afecta a una columna específica en una tabla.
- PROCEDURE: Afecta a procedimientos almacenados y funciones.

### Ejemplos de Permisos

- ALL PRIVILEGES: Todos los permisos.
- SELECT: Permiso para seleccionar datos.
- INSERT: Permiso para insertar datos.
- UPDATE: Permiso para actualizar datos.
- DELETE: Permiso para eliminar datos.

### Asignar Permisos

Para otorgar permisos:

```sql
GRANT UPDATE ON chinook.employee TO 'samuel'@'localhost';
```

Para revocar permisos:

```sql
REVOKE DELETE ON chinook.employee FROM 'samuel'@'localhost';
```

## Gestión de Usuarios y sus Permisos

### Permisos Necesarios para Gestionar Usuarios

Para gestionar usuarios y permisos, un usuario generalmente necesita el permiso GRANT OPTION además de permisos administrativos como CREATE USER, DROP USER, GRANT, y REVOKE.

## Agrupación de Usuario con Roles

Con MySQL se puede agrupar usuarios usando roles.

### Crear y Asignar Roles

Para crear un rol:

```sql
CREATE ROLE 'rol';
```

Para otorgar permisos a un rol:

```sql
GRANT DELETE ON chinook.employee TO 'rol';
```

Para asignar un rol a un usuario:

```sql
GRANT 'rol' TO 'samuel'@'localhost';
```

Para activar un rol para un usuario:

```sql
SET DEFAULT ROLE 'rol' FOR 'samuel'@'localhost';
este rol se quita al cerrar sesion.
```

### Ejemplo de Uso de Roles

```sql
CREATE ROLE 'rol';
GRANT SELECT ON chinook.employee TO 'rol';
GRANT 'rol' TO 'samuel'@'localhost';
SET DEFAULT ROLE 'rol' FOR 'samuel'@'localhost';
```

## Comandos para Gestionar Usuarios y Permisos

### Comandos Principales

- Crear Usuario: CREATE USER 'samuel'@'localhost' IDENTIFIED BY '1234';
- Modificar Usuario: ALTER USER 'samuel'@'localhost' IDENTIFIED BY '1234';
- Eliminar Usuario: DROP USER 'samuel'@'localhost';
- Mostrar Usuarios: SELECT sam FROM mysql.user;
- Mostrar Permisos: SHOW GRANTS FOR 'samuel'@'localhost';
- Otorgar Permisos: GRANT DELETE ON chinook.employee TO 'samuel'@'localhost';
- Revocar Permisos: REVOKE UPDATE ON chinook.employee FROM 'samuel'@'localhost';
- Crear Rol: CREATE ROLE 'rol';
- Otorgar Permisos a Rol: GRANT UPDATE ON chinook.employee TO 'rol';
- Asignar Rol a Usuario: GRANT 'rol' TO 'samuel'@'localhost';
- Activar Rol para Usuario: SET DEFAULT ROLE 'rol' FOR 'samuel'@'localhost';
