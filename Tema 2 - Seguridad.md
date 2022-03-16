- [Status](../../Document/Status.md)―[Draft](../../Document/Status/Draft.md) #Status
- Las 4 As→Autenticación, Autorización, Acceso y Auditoría
- Tareas de seguridad  ↓ 
    - Asegurarse de que la instalación y configuración de la BD es segura
    - Gestionar aspectos de seguridad de las cuentas de usuario
    - Asegurarse de que las conexiones de red son seguras
    - Cifrado de datos sensibles
    - Asegurar que la base de datos no tiene vulnerabilidades de seguridad
    - Decidir qué componentes de BD auditar y cómo
    - Descarga e instalación de parches de seguridad
- Parámetros de Seguridad
    - ```sql
ALTER SYSTEM SET var=valor
ALTER SYSTEM RESET var=valor	
```
- Gestión de usuarios en SO
    - Crear un usuario con opción external  ↓ 
        - ```sql
Create user "OPS$HOST\USUARIO" identified externally;
```
- Gestión de usuarios en Oracle
    - ```sql
CREATE PROFILE Perfil_1 LIMIT
	SESSIONS_PER_USER 3 -- Máximo núm. de sesiones para ese usuario.
	CONNECT_TIME UNLIMITED -- Duración máxima de la conexión.
	IDLE_TIME 10 -- Minutos de tiempo muerto en una sesión. 
	FAILED_LOGIN_ATTEMPTS 4 -- no máximo de intentos para bloquear cuenta. 
	PASSWORD_LIFE_TIME 90 -- No de días de expiración de la password. 
	PASSWORD_GRACE_TIME 3; -- Periodo de gracia después de los 90 días.
``````sql
Resource_limit=true 
```
- Tablespaces
    - Tablespaces←Las divisiones lógicas que hace Oracle de los datos de una BD.
    - USERS←El tablespace por defecto para todos los usuarios. 
    - ```sql
SELECT * from DBA_TABLESPACES; -- Comprueba los ts existentes create tablespace nombre datafile ’nombrefichero.dbf' size 10M autoextend on; /*Crea un ts con un fichero de tamaño 10M autoextensible. Para que un usuario pueda usarlo debe asignársele una quota de uso. */
```
- Crear usuarios
    - IDENTIFIED←Única cláusula obligatoria al crear usuarios
    - Un usuario recién creado no tiene ningún privilegio
    - ```sql
 CREATE USER Pepe IDENTIFIED BY Clave_Pepe
  TEMPORARY TABLESPACE temp_ts -- Tablespace para los seg. temporales.
  DEFAULT TABLESPACE data_ts -- Tabl. por defecto para sus objetos.
  QUOTA 100M ON test_ts -- Máximo espacio en ese Tablespace.
  QUOTA 500K ON data_ts
  PROFILE Perfil_1; -- Asigna el Perfil_1 al usuario.
```
    - Modificar un usuario↔ALTER USER
    - Borrar un usuario↔DROP USER marta CASCADE
        - CASCADE↔Borrar todos los objetos que contiene
- Roles
    - ```sql
CREATE ROLE nombre_role 
[NOT IDENTIFIED 
|IDENTIFIED {BY password |
			 USING [schema.]package |
			 EXTERNALLY |
			 GLOBALLY}];
```
    - ```sql
-- Ejemplo --
CREATE ROLE Gestor IDENTIFIED BY 123;
CREATE ROLE USUARIO_NORMAL;
``` 
- Permisos (GRANT y REVOKE)
    - Tipos de Permisos←SELECT, INSERT, DELETE, UPDATE, ALTER, REFERENCES, INDEX (para crear índices) y EXECUTE  
    - Tipos de Objetos←Tablas, Vistas, Secuencias, Procedimientos, Funciones, Vistas Materializadas  
    - ```sql
GRANT <Lista_Permisos> [ON <Objeto>]
TO <Usuarios> [WITH {GRANT|ADMIN} OPTION]
``` 
    - ```sql
 REVOKE <Lista_Permisos> [ON <Objeto>] FROM <Usuario>;
```
- Creación de vistas
    - ```sql
Formato: CREATE [OR REPLACE] [[NO] FORCE] VIEW <NombreV> [(<Lista_Atrbs>)] AS (<Subconsulta>) [WITH READ ONLY];
```
    - Es posible escribir sobre vistas que hayan sido creadas sobre una sola tabla y no usan funciones de agregación. 
- Borrado de vistas 
    - ```sql
 DROP VIEW <NombreV>;
```
- Sinónimos 
    - ```sql
CREATE [PUBLIC] SYNONYM <Nombre> FOR <Objeto>;
```
- Snapshots
    - ```sql
CREATE MATERIALIZED VIEW <Nombre> <Cláusulas> AS <subconsulta>;
```
        - Cláusulas
            - ```sql
BUILD [INMEDIATE | DEFERRED]
```
            - ```sql
[Refresh <Opciones> | NEVER REFRESH
```
                - Opciones
                    - ```sql
FAST --
```
                    - ```sql
COMPLETE --Rehacer la consulta
```
                    - ```sql
FORCE --alterna entre FAST y COMPLETE
``` 
- ```javascript
select * from dict;
``` 
- 
