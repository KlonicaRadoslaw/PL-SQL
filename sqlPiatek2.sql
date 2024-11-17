--CREATE TABLE Przedmioty (Id_przedmiot NUMBER(3),
--                        Nazwa_Przedmiot VARCHAR2(40),
--                        Opis VARCHAR2(200));

--CREATE TABLE KopiaEgzaminy
--    AS
--    SELECT * FROM Egzaminy;

--CREATE TABLE KopiaStudenci(NrAlbumu, Nazwisko, Imie)
--    AS
--    SELECT ID_Student, Nazwisko, Imie
--    FROM Studenci WHERE 1 = 0;

--CREATE TABLE KopiaEgzaminatorzy
--    AS
--    SELECT TO_NUMBER(ID_Egzaminator) AS IDEgzaminator, Nazwisko, Imie
--    FROM Egzaminatorzy
--    WHERE 'a' = 'b';

--CREATE TABLE TMaxOsrodki AS
--SELECT e.ID_Osrodek, Nazwa_Osrodek, e.ID_Student, Nazwisko, Imie, COUNT
--(ID_Egzamin) AS Liczba
--FROM Egzaminy e JOIN Osrodki o
--ON e.ID_Osrodek=o.ID_Osrodek
--JOIN Studenci s ON e.ID_Student=s.ID_Student
--GROUP BY e.ID_Osrodek, Nazwa_Osrodek, e.ID_Student, Nazwisko, Imie
--HAVING COUNT(ID_Egzamin) = (
--SELECT MAX(COUNT(ID_Egzamin))
--FROM Egzaminy e1
--WHERE e1.ID_Osrodek = e.ID_Osrodek
--GROUP BY ID_Student ) ;

--ALTER TABLE Egzaminy
--    ADD Punkty NUMBER(2);

--ALTER TABLE Egzaminy
--    MODIFY Punkty NUMBER(3);

--ALTER TABLE Egzaminy
--    MODIFY Punkty DEFAULT 1;
--DROP TABLE TMaxOsrodki;

--DROP TABLE TMaxOsrodki CASCADE CONSTRAINTS;

--ALTER TABLE Przedmioty ADD PRIMARY KEY(Id_przedmiot);

--CREATE TABLE Przedmioty ( Id_przedmiot NUMBER(3) PRIMARY KEY,
--Nazwa_Przedmiot VARCHAR2(40),
--Opis VARCHAR2(200) ) ;
--
--ALTER TABLE Przedmioty
--    ADD UNIQUE (Nazwa_Przedmiot);
--    
--CREATE TABLE Przedmioty (Id_przedmiot NUMBER(3) PRIMARY KEY,
--                        Nazwa_Przedmiot VARCHAR2(40) NOT NULL,
--                        Opis VARCHAR2(200),
--                        UNIQUE (Nazwa_Przedmiot)
--);
--
--ALTER TABLE Osrodki
--    MODIFY Nazwa_Osrodek NOT NULL;
--
--ALTER TABLE Egzaminy
--    ADD CONSTRAINT ZdalNN CHECK (Zdal IN ('Y','N'));

