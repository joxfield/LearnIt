# SSH Security

## 1. Klucze publiczny i prywatny
Klucz prywatny jest do użytku prywatnego — tylko właściciel go posiada.
Klucz publiczny można udostępniać — wgrywamy go na serwer.
Serwer sprawdza czy klucz prywatny pasuje do publicznego jak zamek i klucz.

## 2. SSH vs hasła
Hasło można podsłuchać lub złamać bruteforce'em.
Klucz SSH jest znacznie trudniejszy do złamania — 4096 bitów losowych danych.

## 3. Bezpieczne zarządzanie kluczami
- Klucz prywatny: uprawnienia 600 (tylko właściciel)
- Klucz publiczny: uprawnienia 644
- Nigdy nie udostępniaj klucza prywatnego

## 4. Debugowanie SSH
ssh -v user@serwer        # verbose - szczegółowe logi połączenia
journalctl -u ssh -n 20   # logi serwera SSH
