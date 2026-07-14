# DB_ADMIN.md

## Konfiguracja użytkowników

### Użytkownicy bazy danych blog

| Użytkownik | Uprawnienia | Opis |
|------------|-------------|------|
| blog_admin | ALL PRIVILEGES | Pełny dostęp do bazy |
| blog_dev | SELECT, INSERT, UPDATE | Programista - brak DELETE |
| blog_auditor | SELECT | Audytor - tylko odczyt |

### Tworzenie użytkowników

```sql
CREATE USER 'blog_admin'@'localhost' IDENTIFIED BY 'Admin123!';
GRANT ALL PRIVILEGES ON blog.* TO 'blog_admin'@'localhost';

CREATE USER 'blog_dev'@'localhost' IDENTIFIED BY 'Dev123!';
GRANT SELECT, INSERT, UPDATE ON blog.* TO 'blog_dev'@'localhost';

CREATE USER 'blog_auditor'@'localhost' IDENTIFIED BY 'Audit123!';
GRANT SELECT ON blog.* TO 'blog_auditor'@'localhost';

FLUSH PRIVILEGES;
```

## Procedura backupu

### Ręczny backup

```bash
sudo mysqldump blog > ~/blog_backup.sql
```

### Automatyczny backup z datą

```bash
~/db_backup.sh
```

Skrypt tworzy plik w katalogu `~/backups/` z datą w nazwie np. `blog_2026-07-14_15-00-00.sql`

### Odtwarzanie bazy

```bash
sudo mysql -e "CREATE DATABASE blog_restored;"
sudo mysql blog_restored < ~/blog_backup.sql
```

## Monitorowanie

### Status usługi

```bash
sudo systemctl status mysql
```

### Aktywne połączenia

```sql
SHOW PROCESSLIST;
```

### Informacje o tabelach

```sql
USE blog;
SHOW TABLE STATUS;
```

### Interpretacja SHOW TABLE STATUS

- `Engine` — silnik bazy (InnoDB obsługuje transakcje i FOREIGN KEY)
- `Rows` — liczba wierszy w tabeli
- `Data_length` — rozmiar danych w bajtach
- Widoki mają `Engine: NULL`
