-- PRÁCTICA 3


-- Ejercicio 1
-- desde system

CREATE USER admin IDENTIFIED BY bd;
GRANT dba TO admin;


-- Ejercicio 2
-- desde admin

CREATE TABLE PRUEBA (
    CLAVE NUMBER(16,0),
    DISPERSO NUMBER(16,0),
    CONCENTRADO NUMBER(16,0),
    IDISPERSO NUMBER(16,0),
    ICONCENTRADO NUMBER(16,0),
    BCONCENTRADO NUMBER(16,0)
);

DECLARE
I NUMBER(16,0);
R NUMBER(16,0);
BEGIN
FOR I IN 1..100000 LOOP
 R := DBMS_RANDOM.VALUE(1,1000000000);
 INSERT INTO PRUEBA VALUES(I, R, MOD(R,11), 1000000000-R, MOD(1000000000-R, 11),
MOD(2000000000-R, 11));
END LOOP;
END;
/
COMMIT;


-- Ejercicio 3
-- desde admin

CREATE INDEX PID ON PRUEBA(IDISPERSO);
CREATE INDEX PIC ON PRUEBA(ICONCENTRADO);
CREATE BITMAP INDEX PBC ON PRUEBA(BCONCENTRADO);

SET AUTOTRACE ON;


-- Ejercicio 4
-- desde admin

SELECT COUNT(*) FROM PRUEBA WHERE CLAVE = 50000;
- SELECT COUNT(*) FROM PRUEBA WHERE DISPERSO = 50000;
- SELECT COUNT(*) FROM PRUEBA WHERE CONCENTRADO = 5;
- SELECT COUNT(*) FROM PRUEBA WHERE IDISPERSO = 50000;
- SELECT COUNT(*) FROM PRUEBA WHERE ICONCENTRADO = 5;
- SELECT COUNT(*) FROM PRUEBA WHERE BCONCENTRADO = 5;

--EJERCICIO 5
-- desde admin

ALTER SYSTEM FLUSH SHARED_POOL;
ALTER SYSTEM FLUSH BUFFER_CACHE;
SELECT COUNT() FROM PRUEBA WHERE CLAVE = 50000;
    319488  physical read total bytes
    113  consistent gets

ALTER SYSTEM FLUSH SHARED_POOL;
ALTER SYSTEM FLUSH BUFFER_CACHE;
SELECT COUNT() FROM PRUEBA WHERE DISPERSO = 50000;
    4513792  physical read total bytes
    691  consistent gets

ALTER SYSTEM FLUSH SHARED_POOL;
ALTER SYSTEM FLUSH BUFFER_CACHE;
SELECT COUNT() FROM PRUEBA WHERE CONCENTRADO = 5;
    4530176  physical read total bytes
    691  consistent gets

ALTER SYSTEM FLUSH SHARED_POOL;
ALTER SYSTEM FLUSH BUFFER_CACHE;
SELECT COUNT() FROM PRUEBA WHERE IDISPERSO = 50000;
    212992  physical read total bytes
    120  consistent gets

ALTER SYSTEM FLUSH SHARED_POOL;
ALTER SYSTEM FLUSH BUFFER_CACHE;
SELECT COUNT() FROM PRUEBA WHERE ICONCENTRADO = 5;
    491520  physical read total bytes
    137  consistent gets

ALTER SYSTEM FLUSH SHARED_POOL;
ALTER SYSTEM FLUSH BUFFER_CACHE;
SELECT COUNT() FROM PRUEBA WHERE BCONCENTRADO = 5;
    368640  physical read total bytes
    122  consistent gets
