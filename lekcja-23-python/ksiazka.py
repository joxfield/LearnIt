#!/usr/bin/env python3

contacts = {}
next_id = 1

def add_contact():
    global next_id
    first_name = input("Imię: ")
    last_name = input("Nazwisko: ")
    phone = input("Telefon: ")
    email = input("Email: ")
    if not phone.isdigit():
        print("Błąd: telefon tylko cyfry!")
        return
    contacts[next_id] = {"imie": first_name, "nazwisko": last_name, "telefon": phone, "email": email}
    next_id += 1
    print("Dodano!")

def show_contacts():
    if not contacts:
        print("Brak kontaktów!")
        return
    for id, c in contacts.items():
        print(f"{id}. {c['imie']} {c['nazwisko']} - {c['telefon']} - {c['email']}")

def search_contact():
    query = input("Szukaj: ").lower()
    for id, c in contacts.items():
        if query in c['imie'].lower() or query in c['nazwisko'].lower():
            print(f"{id}. {c['imie']} {c['nazwisko']} - {c['telefon']}")

def delete_contact():
    show_contacts()
    id = int(input("ID do usunięcia: "))
    if id in contacts:
        del contacts[id]
        print("Usunięto!")
    else:
        print("Nie znaleziono!")

def edit_contact():
    show_contacts()
    id = int(input("ID do edycji: "))
    if id not in contacts:
        print("Nie znaleziono!")
        return
    contacts[id]['imie'] = input("Nowe imię: ")
    contacts[id]['nazwisko'] = input("Nowe nazwisko: ")
    contacts[id]['telefon'] = input("Nowy telefon: ")
    contacts[id]['email'] = input("Nowy email: ")
    print("Zaktualizowano!")

def menu():
    while True:
        print("\n1. Dodaj\n2. Wyświetl\n3. Szukaj\n4. Usuń\n5. Edytuj\n0. Wyjdź")
        choice = input("Opcja: ")
        if choice == "1": add_contact()
        elif choice == "2": show_contacts()
        elif choice == "3": search_contact()
        elif choice == "4": delete_contact()
        elif choice == "5": edit_contact()
        elif choice == "0": break
        else: print("Nieprawidłowa opcja!")

menu()
