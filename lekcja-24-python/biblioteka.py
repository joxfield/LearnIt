#!/usr/bin/env python3

class Ksiazka:
    def __init__(self, tytul, autor, isbn, rok):
        self.tytul = tytul
        self.autor = autor
        self.isbn = isbn
        self.rok = rok
        self.dostepna = True

class Czytelnik:
    def __init__(self, imie, nazwisko, numer_czytelnika):
        self.imie = imie
        self.nazwisko = nazwisko
        self.numer_czytelnika = numer_czytelnika
        self.wypozyczone_ksiazki = []

class Biblioteka:
    def __init__(self, nazwa, adres):
        self.nazwa = nazwa
        self.adres = adres
        self.kolekcja_ksiazek = []
        self.lista_czytelnikow = []

    def dodaj_ksiazke(self, ksiazka):
        self.kolekcja_ksiazek.append(ksiazka)

    def zarejestruj_czytelnika(self, czytelnik):
        self.lista_czytelnikow.append(czytelnik)

    def wypozycz_ksiazke(self, ksiazka, czytelnik):
        if ksiazka.dostepna == True:
            ksiazka.dostepna = False
            czytelnik.wypozyczone_ksiazki.append(ksiazka)
            print("Wypożyczono książkę")
        else:
            print("Książka niedostępna")

    def zwroc_ksiazke(self, ksiazka, czytelnik):
        if ksiazka.dostepna == False:
            ksiazka.dostepna = True
            czytelnik.wypozyczone_ksiazki.remove(ksiazka)
            print("Zwrócono książkę")
        else:
            print("Nie można zwrócić książki")

    def wyszukaj_ksiazke(self, zapytanie):
        for ksiazka in self.kolekcja_ksiazek:
            if zapytanie in ksiazka.tytul or zapytanie in ksiazka.autor or zapytanie in ksiazka.isbn:
                print(f"{ksiazka.tytul} - {ksiazka.autor}")

    def sprawdz_wypozyczenia(self, czytelnik):
        print(f"Wypożyczone książki - {czytelnik.imie} {czytelnik.nazwisko}:")
        for ksiazka in czytelnik.wypozyczone_ksiazki:
            print(f"- {ksiazka.tytul}")

# Testowanie
biblioteka = Biblioteka("Biblioteka Miejska", "ul. Główna 1")

ksiazka1 = Ksiazka("Pan Tadeusz", "Mickiewicz", "123", 1834)
ksiazka2 = Ksiazka("Lalka", "Prus", "456", 1890)

czytelnik1 = Czytelnik("Jan", "Kowalski", "C001")

biblioteka.dodaj_ksiazke(ksiazka1)
biblioteka.dodaj_ksiazke(ksiazka2)
biblioteka.zarejestruj_czytelnika(czytelnik1)

biblioteka.wypozycz_ksiazke(ksiazka1, czytelnik1)
biblioteka.sprawdz_wypozyczenia(czytelnik1)
biblioteka.zwroc_ksiazke(ksiazka1, czytelnik1)
biblioteka.wyszukaj_ksiazke("Lalka")
