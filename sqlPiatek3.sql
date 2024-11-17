--CREATE VIEW VStudenci
--    AS
--    SELECT ID_Student, Nazwisko, Imie
--    From studenci;
--
--Create view VEgzaminyCKMP
--    as
--    SELECT o.ID_Osrodek, Nazwa_Osrodek, s.id_student, Nazwisko, Imie, Nazwa_Przedmiot, Data_Egzamin
--    from Osrodki o
--    INNER JOIN Egzaminy e ON e.ID_Osrodek = o.ID_Osrodek
--    INNER JOIN Studenci s ON s.ID_Student = e.ID_Student
--    INNER JOIN Przedmioty p ON p.Id_przedmiot = e.Id_przedmiot;

--Create view VEgzaminatorStudent (ID_Egzaminator, EgzaminatorNazwisko, EgzaminatorImie, ID_Student, StudentNazwisko, StudentImie, LiczbaMax)
--as
--Select g.id_egzaminator, g.nazwisko, g.imie, s.id_student, s.nazwisko, s.imie, count(ID_Egzamin)
--from Egzaminatorzy g
--Inner join Egzaminy e ON e.ID_Egzaminator = g.ID_Egzaminator
--inner join Studenci s ON s.ID_Student = e.ID_Student
--group by g.id_egzaminator, g.nazwisko, g.imie, s.id_student, s.nazwisko, s.imie
--having count(ID_Egzamin) = ( select max(count(ID_Egzamin))
--                                from Egzaminy e2
--                                Where e2.id_egzaminator = g.id_egzaminator
--                                group by ID_Student
--
--);

--create view VOsrodkiLublin
--as
--SELECT * FROM Osrodki
--where upper(Miasto) = 'LUBLIN'
--with check option;

--select * from vosrodkilublin
--order by nazwa_osrodek;

--insert into vstudenci
--Values ('0101011', 'Kuras', 'Jan');

--update vstudenci
--set Imie = 'Marian'
--WHERE id_student = '0101011'

--select distinct s.id_student, Nazwisko, Imie
--from Studenci s
--inner join Egzaminy e ON e.ID_Student = s.ID_Student
--inner join VOsrodkiLublin v on v.ID_Osrodek = e.ID_Osrodek
--ORDER BY Nazwisko, Imie;


