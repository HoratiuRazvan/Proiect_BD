
CREATE OR REPLACE FUNCTION EX_6
RETURN NUMBER IS
    m_varsta CITITORI.varsta%TYPE;
    CURSOR c_varsta IS SELECT varsta FROM CITITORI;
    TYPE t_varsta IS TABLE OF CITITORI.VARSTA%TYPE INDEX BY binary_integer;
    lista_varsta t_varsta;
    numar number := 0;
    suma number :=0;
    BEGIN
        FOR i in c_varsta LOOP
            lista_varsta(numar) := i.varsta;
            numar := numar + 1;
            suma := suma + i.varsta;
        END LOOP;
        RETURN suma/numar;
    
END EX_6;    
/
BEGIN
    DBMS_OUTPUT.PUT_LINE('Varsta medie este' || EX_6);
END;
/
CREATE OR REPLACE PROCEDURE EX_7
    (v_nume CITITORI.nume%TYPE)
    IS
        varsta_act CITITORI.varsta%TYPE;
        CURSOR c_varsta is SELECT varsta FROM CITITORI;
        varsta_mai_mica number := 0;
        varsta_mai_mare number := 0;
    BEGIN
        SELECT varsta into varsta_act
        FROM CITITORI
        WHERE nume = v_nume;
        FOR i IN c_varsta LOOP
            IF varsta_act > i.varsta THEN
                varsta_mai_mica := varsta_mai_mica + 1;
            ELSE
                varsta_mai_mare := varsta_mai_mare + 1;
            END IF;
        END LOOP;
        dbms_output.put_line('Sunt ' || varsta_mai_mica || ' cititori cu varsta mai mica decat ' || v_nume || ', respectiv '||varsta_mai_mare||' cu varsta mai mare');
END EX_7;                
/        
begin
   EX_7('Andrei');
end;
/
CREATE OR REPLACE PROCEDURE EX_8
    (v_nume_autor AUTORI.nume_autor%TYPE)
    is
        temp AUTORI.nume_autor%type;
        temp1 ARTICOLE.nume_articol%type;
        temp2 CATEGORII.nume_categorie%type;
    BEGIN
        SELECT AUTORI.nume_autor, ARTICOLE.nume_articol, CATEGORII.nume_categorie INTO temp,temp1,temp2
        FROM AUTORI 
        INNER JOIN ARTICOLE ON AUTORI.id_autor = ARTICOLE.id_autor  and AUTORI.nume_autor = v_nume_autor
        INNER JOIN CATEGORII ON CATEGORII.id_categorie = ARTICOLE.id_categorie;
        DBMS_OUTPUT.PUT_LINE(temp || ' a scris un singur articol: ' || temp1);
        EXCEPTION 
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('NU EXISTA AUTORUL DAT CU CORELATIE IN CELE 3 BAZE DE DATE');
            WHEN TOO_MANY_ROWS THEN
                DBMS_OUTPUT.PUT_LINE('Autorul are mai multe articole');
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Alta eroare');
END EX_8;
/
begin
   EX_8('Georgescu Maria');
end;
/
--Pentru ex_9 vom calcula media autorului dat
CREATE OR REPLACE FUNCTION EX_9
    (v_nume_autor AUTORI.nume_autor%TYPE)
    RETURN NUMBER IS 
    medie FLOAT(2);
    suma NUMBER := 0;
    BEGIN
    SELECT AVG(NOTE.val) into medie
    FROM AUTORI
    INNER JOIN ARTICOLE ON AUTORI.id_autor = ARTICOLE.id_autor and AUTORI.nume_autor = v_nume_autor
    INNER JOIN CITITORI_CITESC_ARTICOLE ON CITITORI_CITESC_ARTICOLE.id_articol = ARTICOLE.id_articol
    INNER JOIN CITITORI ON CITITORI.id_cititor = CITITORI_CITESC_ARTICOLE.id_cititor
    INNER JOIN NOTE ON NOTE.id_cititor = CITITORI.id_cititor and NOTE.id_articol = ARTICOLE.id_articol;
    RETURN medie;
    EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20000,'NU EXISTA AUTORUL DAT CU CORELATIE IN CELE 5 BAZE DE DATE');
            WHEN TOO_MANY_ROWS THEN
                RAISE_APPLICATION_ERROR(-20001,'Autorul are mai multe articole');
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20002,'Alta eroare');
END EX_9;
/
BEGIN
   dbms_output.put_line( EX_9('Popescu Ion'));
END;
/
--Am facut un trigger care nu permite modificarea datei la care a fost publicat articolul intr-o data ulterioara.
CREATE OR REPLACE TRIGGER EX_11
    BEFORE UPDATE OF data_articol ON ARTICOLE
    FOR EACH ROW
BEGIN
    IF(:NEW.data_articol > :OLD.data_articol) THEN
        RAISE_APPLICATION_ERROR(-20004,'nu se poate alege o data ulterioara');
    END IF;
END;
/
UPDATE ARTICOLE
SET data_articol = data_articol  + 1;

CREATE OR REPLACE TRIGGER EX_10
    BEFORE DELETE ON NOTE
    DECLARE
    CURSOR c_val IS SELECT val FROM NOTE;
    BEGIN
        FOR i IN c_val LOOP
            IF i.val > 1 and i.val < 11 THEN
                RAISE_APPLICATION_ERROR(-20005,'NU ESTE PERMISA STERGEREA NOTELOR VALIDE');
            END IF;
        END LOOP;
END;
/
DELETE FROM NOTE WHERE id_nota = 5;
/

CREATE TABLE TABEL_AUXILIAR( val NUMBER, data_introducere DATE);
/
CREATE OR REPLACE TRIGGER EX_12
    AFTER ALTER ON SCHEMA
BEGIN
    RAISE_APPLICATION_ERROR(-20006,'Nu este permisa modificarea tabelei');
END EX_12;
/
ALTER TABLE TABEL_AUXILIAR ADD username varchar(30);







