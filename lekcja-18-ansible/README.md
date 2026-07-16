# Ansible LAMP

## Wymagania
- Ansible
- Ubuntu 24+

## Użycie
```bash
ansible-playbook -i inventory playbook.yml
```

## Role

| Rola | Opis |
|------|------|
| base | Aktualizacja systemu, podstawowe pakiety |
| web | Instalacja i konfiguracja Apache |
| database | Instalacja MySQL, tworzenie bazy i użytkownika |
| php | Instalacja PHP i rozszerzeń |
| app | Wdrożenie aplikacji PHP |

## Zmienne (roles/database/defaults/main.yml)
- `db_name` — nazwa bazy danych (domyślnie: lamp_app)
- `db_user` — użytkownik bazy (domyślnie: lamp_user)
- `db_password` — hasło użytkownika

## Weryfikacja
```bash
curl http://localhost/index.php
```
