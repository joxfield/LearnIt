#!/usr/bin/env python3
weight = float(input("Podaj wagę w kg: "))
height = float(input("Podaj wzrost w cm: "))

BMI = weight / (height/100)**2

print(f"Twoje BMI wynosi: {BMI:.2f}")

if BMI < 18.5:
    print("Niedowaga")
elif 18.5 <= BMI < 25:
    print("Waga prawidłowa")
elif 25 <= BMI < 30:
    print("Nadwaga")
else:
    print("Otyłość")
