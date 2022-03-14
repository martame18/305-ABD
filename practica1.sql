-- Prueba: Diccionario de Oracle

-- PREGUNTA 1
-- Muestre el nombre y el tipo de los atributos de la tabla ALUMNOS del usuario DOCENCIA
SELECT
  COLUMN_NAME "Nombre", DATA_TYPE "Tipo"
FROM
  ALL_TAB_COLUMNS
WHERE
  OWNER='DOCENCIA'
  AND TABLE_NAME='ALUMNOS';

-- PREGUNTA 2
-- Listar el nombre y tipo de todos los objetos del usuario con el que te has conectado
SELECT
  OBJECT_NAME "Nombre", OBJECT_TYPE "Tipo"
FROM
  USER_OBJECTS;

-- PREGUNTA 3
-- Mostrar los roles que el usuario tienen actualmente activados
SELECT
  GRANTED_ROLE "Roles"
FROM
  USER_ROLE_PRIVS;

--PREGUNTA 4
-- Listar los privilegios de sistema asignados al usuario conectado
SELECT
  PRIVILEGE "Privilegio"
FROM
  USER_TAB_PRIVS;

-- PREGUNTA 5
-- Listar los nombres de restricciones foráneas a tablas del mismo esquema que tiene el usuario DOCENCIA
SELECT
  CONSTRAINT_NAME "Nombre"
FROM
  ALL_CONSTRAINTS
WHERE
  OWNER='DOCENCIA'
  AND R_OWNER='DOCENCIA';

-- PREGUNTA 6
-- Lista, ordenado por el nombre de tabla todas las columnas, su tipo y su longitud del esquema DOCENCIA
SELECT
  TABLE_NAME "NOMBRETABLA", COLUMN_NAME "NOMBRECOLUMNA", DATA_TYPE "TIPODATOS", DATA_LENGTH "LONGITUD"
FROM
  ALL_TAB_COLUMNS
WHERE
  OWNER='DOCENCIA'
ORDER BY
  TABLE_NAME;

-- PREGUNTA 7
-- Listar el nombre de las vistas que a su vez dependen de otras vistas. Mostrar también el nombre de esas otras vistas de las que dependen.
SELECT
  OWNER "Owner", NAME "name", TYPE "type", REFERENCED_OWNER "r_owner", REFERENCED_NAME "r_name", REFERENCED_TYPE "r_type", REFERENCED_LINK_NAME "r_link", DEPENDENCY_TYPE "dep_type"
FROM
  ALL_DEPENDENCIES
WHERE
  TYPE='VIEW';

-- PREGUNTA 8
-- Listar el nombre de todas las vistas de usuarios que comiencen por UBD y que son INVALIDAS
SELECT
  OBJECT_NAME "OBJETO"
FROM
  ALL_OBJECTS
WHERE
  OBJECT_TYPE='VIEW'
  AND STATUS='INVALID'
  AND SUBSTR(OWNER,1,3)='UBD';

-- PREGUNTA 9
-- Listar las Integridad referencial de las tablas del esquema DOCENCIA. Es decir, listar el nombre de la tabla, columna y nombre de la restricción foránea.
SELECT
  A.TABLE_NAME, A.COLUMN_NAME, A.CONSTRAINT_NAME
FROM
  ALL_CONS_COLUMNS A JOIN ALL_CONSTRAINTS B
  ON A.OWNER = B.OWNER
WHERE
  B.CONSTRAINT_TYPE = 'R'
  AND B.R_OWNER = 'DOCENCIA';

-- PREGUNTA 10
-- Seleccionar todas las vistas del usuario DOCENCIA basadas en una consulta larga (más de 150 caracteres).
SELECT
    A.VIEW_NAME, A.TEXT_LENGTH
FROM
    ALL_OBJECTS AO JOIN ALL_VIEWS AV
    ON B.OBJECT_NAME = A.VIEW_NAME
WHERE
    A.OWNER = 'DOCENCIA'
    AND A.TEXT_LENGTH > 150
    AND B.OBJECT_TYPE = 'VIEW'
    AND B.CREATED < TO_DATE('01-01-2017');

-- PREGUNTA 11
-- Mostrar todos los índices marcados como únicos (UNIQUENESS='UNIQUE') del usuario DOCENCIA junto al número de columnas que lo forman.
SELECT
  B.INDEX_NAME, COUNT(B.INDEX_NAME)
FROM
  ALL_IND_COLUMNS A JOIN ALL_INDEXES B
  ON A.INDEX_NAME = B.INDEX_NAME
    AND A.INDEX_OWNER = B.OWNER
WHERE B.OWNER = 'DOCENCIA'
  AND B.UNIQUENESS = 'UNIQUE'
GROUP BY B.INDEX_NAME;
