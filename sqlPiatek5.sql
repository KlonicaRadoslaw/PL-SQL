------DECLARE
------    vPrzedmiot Przedmioty.Id_przedmiot%TYPE;
------BEGIN
------    SELECT DISTINCT p.id_przedmiot INTO vPrzedmiot
------    From Przedmioty p JOIN egzaminy e ON p.id_przedmiot = e.id_przedmiot
------    WHERE upper(Nazwa_Przedmiot) = 'BAZY DANYCH';
------    dbms_output.put_line('Z baz danych odby³ siê ju¿ egzamin');
------EXCEPTION
------    WHEN NO_DATA_FOUND THEN
------        dbms_output.put_line('Z baz danych nie by³o jeszcze egzaminu');
------END;
----
----DECLARE
----    vPrzedmiot Przedmioty.Id_przedmiot%TYPE;
----    vP Egzaminy.Id_przedmiot%TYPE;
----    CURSOR CPrzedmiot IS SELECT Id_przedmiot FROM Przedmioty
----        WHERE upper(Nazwa_Przedmiot) = 'BAZY DANYCH';
----BEGIN
----    OPEN CPrzedmiot;
----    IF CPrzedmiot%ISOPEN THEN
----        FETCH CPrzedmiot INTO vPrzedmiot;
----        IF CPrzedmiot%FOUND THEN
----            SELECT DISTINCT Id_przedmiot INTO vP
----            FROM Egzaminy
----            WHERE Id_Przedmiot = vPrzedmiot;
----            dbms_output.put_line('Z baz danych odby³ siê ju¿ egzamin');
----        ELSE
----            dbms_output.put_line('Nie ma takiego przedmiotu');
----        END IF;
----        CLOSE CPrzedmiot;
----    END IF;
----EXCEPTION
----    WHEN NO_DATA_FOUND THEN
----        dbms_output.put_line('Z baz danych nie by³o jeszcze egzaminu');
----        CLOSE CPrzedmiot;
----END;
--
--DECLARE 
--vX  Egzaminy.ID_Egzaminator%TYPE ; 
-- CURSOR CurEgzam IS SELECT ID_Egzaminator, Nazwisko, Imie 
-- FROM Egzaminatorzy ; 
-- VRekEgzam CurEgzam%ROWTYPE ;  
--BEGIN 
--OPEN CurEgzam ;   FETCH CurEgzam INTO vRekEgzam ;  
--WHILE CurEgzam%FOUND LOOP  
--  BEGIN 
--   SELECT ID_Egzaminator INTO vX FROM Egzaminy  
--WHERE ID_Egzaminator = vRekEgzam.ID_Egzaminator ; 
-- EXCEPTION 
--     WHEN TOO_MANY_ROWS THEN 
--     Dbms_output.Put_line(vRekEgzam.ID_Egzaminator|| ' ' || vRekEgzam.Nazwisko || ' ' || vRekEgzam.Imie);
--     WHEN NO_DATA_FOUND THEN  NULL ;  
-- END  ; 
-- FETCH CurEgzam INTO vRekEgzam ;  
-- END LOOP ; 
-- CLOSE CurEgzam ;  
--END ;
--

--DECLARE
--    vX VARCHAR(1);
--    CURSOR COsrodek IS SELECT ID_Osrodek, Nazwa_Osrodek FROM Osrodki ORDER BY ID_Osrodek;
--
--BEGIN
--    FOR vCur IN COsrodek LOOP
--        BEGIN
--            SELECT DISTINCT 'X' INTO vX FROM EGZAMINY
--                WHERE ID_OSRODEK = vCur.ID_Osrodek;
--        EXCEPTION
--            WHEN NO_DATA_FOUND THEN
--                dbms_output.put_line(vCur.ID_Osrodek || ' ' || vCur.Nazwa_Osrodek);
--        END;
--    END LOOP;
--END;

DECLARE
    Uwaga EXCEPTION;
    CURSOR CStudent IS SELECT s.ID_Student, Nazwisko, Imie,
        COUNT(ID_Egzamin) AS Liczba FROM Studenci s LEFT JOIN Egzaminy e
        ON s.ID_Student = e.ID_Student GROUP BY s.id_student, Nazwisko, Imie;
BEGIN
    FOR vCur IN CStudent LOOP
        BEGIN
            IF vCur.Liczba = 0 THEN RAISE Uwaga;
            END IF;
        EXCEPTION
            WHEN Uwaga THEN
                Dbms_output.Put_line(vCur.ID_Student || ' ' || vCur.Nazwisko || ' ' || vCur.Imie) ; 
        END;
    END LOOP;
END;
                