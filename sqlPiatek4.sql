--BEGIN
--    FOR i IN 1..100 LOOP
--        IF MOD(i,2) = 0 THEN
--            dbms_output.put_line(i);
--        END IF;
--    END LOOP;
--END;

--DECLARE
--    i NUMBER DEFAULT 0;
--    CURSOR CStudent IS SELECT ID_Student, Nazwisko, Imie FROM Studenci ORDER BY Nazwisko, Imie;
--BEGIN
--    FOR dane IN CStudent LOOP
--        i := i+1;
--        dbms_output.put_line(i || ' ' || dane.ID_Student || ' ' || dane.Nazwisko || ' ' || dane.Imie);
--    END LOOP;
--END;

--DECLARE
--    vData DATE;
--    CURSOR CEgzaminy IS select distinct Data_Egzamin FROM Egzaminy ORDER BY Data_Egzamin DESC;
--BEGIN
--    OPEN CEgzaminy;
--    IF CEgzaminy%ISOPEN THEN
--        FOR i IN 1..3 LOOP
--            FETCH CEgzaminy INTO vData;
--            EXIT WHEN CEgzaminy%NOTFOUND;
--            dbms_output.put_line(vData);
--        END LOOP;
--    CLOSE CEgzaminy;
--    END IF;
--END;
--
--CREATE TRIGGER BI_Przedmioty BEFORE INSERT ON Przedmioty FOR EACH ROW
--    DECLARE
--        imax Przedmioty.Id_przedmiot%TYPE;
--    BEGIN
--        SELECT MAX(Id_przedmiot) INTO imax FROM Przedmioty;
--        :new.Id_przedmiot := imax + 1;
--    END;

--DECLARE
--    i NUMBER DEFAULT 0;
--    CURSOR CEgzaminator IS SELECT nazwisko, imie, id_egzaminator FROM egzaminatorzy ORDER BY Nazwisko, Imie;
--BEGIN
--    dbms_output.put_line('LP.  IDENTYFIKATOR  NAZWISKO  IMIE');
--    FOR dane IN CEgzaminator LOOP
--        i := i+1;
--        dbms_output.put_line(i || ' ' || dane.id_egzaminator || ' ' || dane.Nazwisko || ' ' || dane.Imie);
--    END LOOP;
--END;

--DECLARE
--    CURSOR osrodki_egzaminy_cursor IS
--        SELECT o.Nazwa_osrodek, COUNT(e.ID_Egzamin) AS liczba_egzaminow
--        FROM osrodki o
--        LEFT JOIN egzaminy e ON o.Id_osrodek = e.Id_osrodek
--        GROUP BY o.Nazwa_osrodek;
--BEGIN
--    DBMS_OUTPUT.PUT_LINE('Sekcja 1: Oœrodki z mniej ni¿ 5 egzaminami');
--    FOR record IN osrodki_egzaminy_cursor LOOP
--        IF record.liczba_egzaminow < 5 THEN
--            DBMS_OUTPUT.PUT_LINE('Oœrodek: ' || record.Nazwa_osrodek || ', Liczba egzaminów: ' || record.liczba_egzaminow);
--        END IF;
--    END LOOP;
--    
--    DBMS_OUTPUT.PUT_LINE('-----------------------------');
--    DBMS_OUTPUT.PUT_LINE('Sekcja 2: Oœrodki z 5-10 egzaminami');
--    FOR record IN osrodki_egzaminy_cursor LOOP
--        IF record.liczba_egzaminow BETWEEN 5 AND 10 THEN
--            DBMS_OUTPUT.PUT_LINE('Oœrodek: ' || record.Nazwa_osrodek || ', Liczba egzaminów: ' || record.liczba_egzaminow);
--        END IF;
--    END LOOP;
--    
--    DBMS_OUTPUT.PUT_LINE('-----------------------------');
--    DBMS_OUTPUT.PUT_LINE('Sekcja 3: Oœrodki z wiêcej ni¿ 10 egzaminami');
--    FOR record IN osrodki_egzaminy_cursor LOOP
--        IF record.liczba_egzaminow > 10 THEN
--            DBMS_OUTPUT.PUT_LINE('Oœrodek: ' || record.Nazwa_osrodek || ', Liczba egzaminów: ' || record.liczba_egzaminow);
--        END IF;
--    END LOOP;
--END;

--BEGIN
--    FOR record IN (
--        SELECT p.nazwa_przedmiot, COUNT(e.ID_Egzamin) AS liczba_egzaminow
--        FROM przedmioty p
--        JOIN egzaminy e ON p.Id_przedmiot = e.Id_przedmiot
--        GROUP BY p.nazwa_przedmiot
--        ORDER BY liczba_egzaminow DESC
--        FETCH FIRST 3 ROWS ONLY
--    ) LOOP
--        DBMS_OUTPUT.PUT_LINE('Przedmiot: ' || record.nazwa_przedmiot || ', Liczba egzaminów: ' || record.liczba_egzaminow);
--    END LOOP;
--END;

DECLARE
    max_data DATE;
BEGIN
    -- Pobranie maksymalnej daty egzaminu
    SELECT MAX(Data_egzamin) INTO max_data FROM egzaminy;

    FOR record IN (
        SELECT e.Data_egzamin, egz.Id_egzaminator, egz.Imie, egz.Nazwisko
        FROM egzaminy e
        JOIN egzaminatorzy egz ON e.Id_egzaminator = egz.Id_egzaminator
        WHERE e.Data_egzamin BETWEEN max_data - 2 AND max_data
        ORDER BY e.Data_egzamin
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Data egzaminu: ' || TO_CHAR(record.Data_egzamin, 'YYYY-MM-DD') || 
                             ', Id egzaminatora: ' || record.Id_egzaminator ||
                             ', Imiê: ' || record.Imie || 
                             ', Nazwisko: ' || record.Nazwisko);
    END LOOP;
END;

DECLARE
    CURSOR przedmioty_cursor IS
        SELECT p.Id_przedmiot, p.nazwa_przedmiot, MAX(e.Data_egzamin) AS max_data
        FROM przedmioty p
        JOIN egzaminy e ON p.Id_przedmiot = e.Id_przedmiot
        GROUP BY p.Id_przedmiot, p.nazwa_przedmiot;
BEGIN
    FOR przedmiot_record IN przedmioty_cursor LOOP
        FOR student_record IN (
            SELECT s.Id_student, s.Nazwisko, s.Imie, e.Data_egzamin
            FROM studenci s
            JOIN egzaminy e ON s.Id_student = e.Id_student
            WHERE e.Id_przedmiot = przedmiot_record.Id_przedmiot
              AND e.Data_egzamin BETWEEN przedmiot_record.max_data - 1 AND przedmiot_record.max_data
            ORDER BY e.Data_egzamin, s.Nazwisko
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('Przedmiot: ' || przedmiot_record.nazwa_przedmiot || 
                                 ', Data egzaminu: ' || TO_CHAR(student_record.Data_egzamin, 'YYYY-MM-DD') ||
                                 ', Id studenta: ' || student_record.Id_student ||
                                 ', Nazwisko: ' || student_record.Nazwisko || 
                                 ', Imiê: ' || student_record.Imie);
        END LOOP;
    END LOOP;
END;

