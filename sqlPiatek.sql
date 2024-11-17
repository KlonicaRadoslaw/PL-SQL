--select distinct egz.id_egzaminator, egz.nazwisko, egz.imie
--from egzaminatorzy egz
--inner join egzaminy e on e.id_egzaminator = egz.id_egzaminator
--where e.id_student = '0000005' or e.id_student = '0000010'
--order by egz.id_egzaminator

--SELECT g.ID_Egzaminator, Nazwisko, Imie
--FROM Egzaminy e
--INNER JOIN Egzaminatorzy g ON e.ID_Egzaminator = g.ID_Egzaminator
--WHERE e.ID_Student = '0000005'
--INTERSECT
--SELECT g.ID_Egzaminator, Nazwisko, Imie
--FROM Egzaminy e
--INNER JOIN Egzaminatorzy g ON e.ID_Egzaminator = g.ID_Egzaminator
--WHERE e.ID_Student = '0000010' ;

--select distinct o.id_osrodek, o.nazwa_osrodek, nazwa_przedmiot
--from egzaminy e
--inner join osrodki o on e.id_osrodek = o.id_osrodek
--right join przedmioty p on p.id_przedmiot = e.id_przedmiot
--order by nazwa_przedmiot, o.id_osrodek

--select nazwa_przedmiot, id_student, nazwisko, imie
--from przedmioty
--cross join studenci
--minus
--select nazwa_przedmiot, s.id_student, nazwisko, imie
--from przedmioty p
--inner join egzaminy e on p.id_przedmiot = e.id_przedmiot
--inner join studenci s on e.id_student = s.id_student
--order by 1,2;

--select Nazwa_przedmiot, count(e.id_egzamin) as Liczba_egzaminow
--from przedmioty p
--left join egzaminy e on p.id_przedmiot = e.id_przedmiot
--group by Nazwa_przedmiot
--order by Nazwa_przedmiot

--select o.id_osrodek, nazwa_osrodek, count(distinct e.id_student) as Liczba_osob
--from osrodki o
--left join egzaminy e on o.id_osrodek = e.id_osrodek
--group by o.id_osrodek, nazwa_osrodek

--select o.id_osrodek
--from osrodki o
--inner join egzaminy e on o.id_osrodek = e.id_osrodek
--inner join egzaminatorzy g on e.id_egzaminator = g.id_egzaminator
--where upper(nazwa_osrodek) = 'CKMP'
--group by o.id_osrodek, nazwa_osrodek, g.id_egzaminator, nazwisko, imie
--having count(e.id_osrodek) > 5
--order by o.id_osrodek, g.id_egzaminator

--select nazwa_przedmiot, min(data_egzamin) as Pierwszy, max(data_egzamin) as Ostatni
--from przedmioty p
--left join egzaminy e on p.id_przedmiot = e.id_przedmiot
--group by nazwa_przedmiot
--order by nazwa_przedmiot;

--select g.id_egzaminator, nazwisko, imie, count(distinct id_student) as Liczba_osob
--from egzaminy e
--inner join egzaminatorzy g on e.id_egzaminator = g.id_egzaminator
--group by g.id_egzaminator, nazwisko, imie
--having count(distinct id_student) > 5
--order by nazwisko, imie;

--select distinct id_student
--from egzaminy
--where data_egzamin = (select min(data_egzamin) from egzaminy);

--select distinct nazwa_przedmiot
--from przedmioty p
--inner join egzaminy e on p.id_przedmiot = e.id_przedmiot
--where data_egzamin > ( select max(data_egzamin)
--                        from egzaminy e
--                        inner join przedmioty p on p.id_przedmiot = e.id_przedmiot
--                        and upper(nazwa_przedmiot) = 'BAZY DANYCH'
--);

select g.id_egzaminator
from egzaminatorzy g
inner join egzaminy e on g.id_egzaminator = e.id_egzaminator
group by g.id_egzaminator, nazwisko, imie
having count(id_egzamin) = ( select min(count(id_egzamin))
                                from egzaminy
                                group by id_egzaminator);