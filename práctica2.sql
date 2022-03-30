-- Ejercicio 2
ALTER SYSTEM SET "WALLET_ROOT"='C:\Users\app\alumnos\Oracle_instalacion\wallet' scope=SPFILE;
ALTER SYSTEM SET TDE_CONFIGURATION="KEYSTORE_CONFIGURATION=FILE" scope=both;

-- Ejercicio 3
-- El tablespace TS_FINTECH ya está creado

-- Ejercicio 4
CREATE TABLE USUARIO1.employee (
    first_name VARCHAR2 (128),
    last_name VARCHAR2 (128),
    empID NUMBER,
    salary NUMBER) 
        TABLESPACE TS_FINTECH;

-- Ejercicio 5
ALTER TABLE USUARIO1.employee MODIFY (empID ENCRYPT);
ALTER TABLE USUARIO1.employee MODIFY (salary ENCRYPT);

-- Ejercicio 6
SELECT * FROM DBA_ENCRYPTED_COLUMNS;

-- Ejercicio 7
INSERT INTO USUARIO1.employee (first_name, last_name, empID, salary) 
    values ('Marta', 'Maleno', 1, 1) ;
    
INSERT INTO USUARIO1.employee (first_name, last_name, empID, salary) 
    values ('Pablo', 'Huertas', 2, 1);

INSERT INTO USUARIO1.employee (first_name, last_name, empID, salary) 
    values ('Jesús', 'Cestino', 3, 1);

INSERT INTO USUARIO1.employee (first_name, last_name, empID, salary) 
    values ('Ignacio', 'Lopezosa', 4, 1);

select * from usuario1.employee;

alter system flush buffer_cache;

select * from dba_data_files;


-- Ejericio 8
-- ALTER TABLE USUARIO1.EMPLOYEE 