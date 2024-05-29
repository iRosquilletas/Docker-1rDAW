## NORMALIZACION

que es la normalizacion en mysql

dijeron algo de esto: es un proceso por el cual consigo que mis tablas tengan menos rebundancia

La normalización en MySQL, al igual que en cualquier sistema de gestión de bases de datos relacionales, es un proceso que se utiliza para organizar los datos en tablas de manera eficiente y reducir la redundancia de datos. El objetivo principal de la normalización es eliminar la duplicación de datos y mejorar la integridad de los datos en la base de datos.

El proceso de normalización se lleva a cabo mediante una serie de reglas (formas normales) que definen cómo deben estructurarse las tablas y cómo deben relacionarse entre sí. Estas reglas ayudan a evitar problemas como la inserción, actualización o eliminación de datos inconsistentes, lo que puede conducir a la corrupción de la base de datos.

Las formas normales más comunes son la Primera Forma Normal (1FN), la Segunda Forma Normal (2FN) y la Tercera Forma Normal (3FN), aunque existen formas normales adicionales (como la Forma Normal de Boyce-Codd, la Cuarta Forma Normal, etc.) que pueden aplicarse según las necesidades específicas de la base de datos.

En resumen, la normalización en MySQL es un proceso esencial para diseñar bases de datos eficientes y con integridad de datos, lo que facilita la gestión y el mantenimiento de los datos a largo plazo.

Claro, la normalización en MySQL es básicamente una técnica que ayuda a organizar la información en una base de datos de manera ordenada y eficiente. El objetivo es evitar que haya datos duplicados o redundantes, lo que podría llevar a problemas de consistencia o dificultar la actualización de la información.

Imagina que tienes una lista de clientes y cada cliente tiene una dirección. En lugar de tener una gran lista donde cada cliente repite su dirección cada vez que aparece, puedes dividir la información en dos partes: una tabla para los clientes y otra tabla para las direcciones. De esta manera, si una dirección cambia, solo necesitas actualizarla en un lugar, y todos los clientes asociados a esa dirección se verán afectados automáticamente.

En resumen, la normalización simplifica la gestión de los datos al organizarlos de manera ordenada y evitar la repetición innecesaria de información. Esto facilita la actualización de los datos y mejora la integridad de la base de datos en general.

## CREAME UNA TABLA CON ATRIBUTOS Y QUE RESTRICCIONES

```sql
CREATE TABLE empleados (
    empleado_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    edad INT CHECK (edad >= 18),
    salario DECIMAL(10, 2),
    fecha_contratacion DATE DEFAULT CURRENT_DATE,
    departamento_id INT,
    FOREIGN KEY (departamento_id) REFERENCES departamentos(departamento_id)
);

```

En esta tabla llamada empleados, tenemos los siguientes atributos y restricciones:

empleado_id: Es un identificador único para cada empleado. Se declara como un tipo INT y se establece como clave primaria (PRIMARY KEY). Además, se utiliza la opción AUTO_INCREMENT para que MySQL genere automáticamente valores nuevos para esta columna.

nombre y apellido: Son campos de texto (VARCHAR) que almacenan el nombre y apellido del empleado. Se especifica que no pueden ser nulos (NOT NULL).

edad: Es un número entero (INT) que representa la edad del empleado. Se utiliza una restricción CHECK para asegurarse de que la edad sea mayor o igual a 18 años.

salario: Es un número decimal (DECIMAL) que representa el salario del empleado. No se especifica ninguna restricción adicional en este caso.

fecha_contratacion: Es una fecha (DATE) que representa la fecha en que el empleado fue contratado. Se establece un valor predeterminado (DEFAULT) para que sea la fecha actual (CURRENT_DATE) en caso de que no se especifique una fecha de contratación específica.

departamento_id: Es un identificador de departamento al que pertenece el empleado. Se establece como un tipo INT y se define como una clave foránea (FOREIGN KEY) que hace referencia a la tabla departamentos. Esto garantiza que el departamento_id en la tabla empleados corresponda a un departamento_id válido en la tabla departamentos.

Esta tabla es un ejemplo simple de cómo puedes estructurar una tabla en MySQL con atributos y restricciones para almacenar información sobre empleados en una empresa.

## MODIFICAR ROL

```sql
SET ROLE 'analista' TO 'samuel'@'localhost';
```

## MYSQL TABLAS GENERADAS AUTOMATICAMETE

Claro, aquí tienes una explicación más detallada sobre cómo utilizar columnas generadas en MySQL, junto con ejemplos de comandos SQL:

Introducción a las columnas generadas en MySQL:
Las columnas generadas son aquellas cuyos valores se calculan automáticamente utilizando una expresión o los valores de otras columnas en la misma fila. Esto puede ser útil para derivar datos o realizar cálculos en la base de datos sin necesidad de almacenarlos explícitamente.

Tipos de columnas generadas:
En MySQL, existen dos tipos de columnas generadas: columnas virtuales y columnas almacenadas.

Columnas virtuales: Los valores de estas columnas se calculan en tiempo de ejecución cada vez que se accede a ellas en una consulta.
Columnas almacenadas: Los valores de estas columnas se calculan una vez y se almacenan físicamente en la tabla.
Sintaxis para definir una columna generada:
La sintaxis general para definir una columna generada en MySQL es la siguiente:

```sql
column_name data_type [GENERATED ALWAYS] AS (expression)
[VIRTUAL | STORED] [UNIQUE [KEY]]
```

column_name: El nombre de la columna generada.
data_type: El tipo de datos de la columna generada.
GENERATED ALWAYS: Indica que la columna es generada.
AS (expression): La expresión utilizada para calcular el valor de la columna generada.
VIRTUAL o STORED: Especifica si la columna generada es virtual o almacenada.
UNIQUE [KEY]: Opcionalmente, se puede definir una restricción única para la columna generada.

Ejemplos de columnas generadas:

```sql
CREATE TABLE contacts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    fullname VARCHAR(101) GENERATED ALWAYS AS (CONCAT(first_name, ' ', last_name)) VIRTUAL,
    email VARCHAR(100) NOT NULL
);
```

Columna almacenada:

```sql
ALTER TABLE products
ADD COLUMN stock_value DECIMAL(10, 2) GENERATED ALWAYS AS (quantityInStock * buyPrice) STORED;
```

Consultas que utilizan columnas generadas:
Una vez que se han definido las columnas generadas, pueden ser utilizadas en consultas como cualquier otra columna de la tabla. Por ejemplo:

```sql
SELECT id, fullname, email FROM contacts;
SELECT productName, ROUND(stock_value, 2) AS stock_value FROM products;
```

Espero que esta explicación te ayude a comprender cómo utilizar y trabajar con columnas generadas en MySQL. Si tienes alguna pregunta adicional o necesitas más ejemplos, no dudes en preguntar.
