# Strategia kopii zapasowych PostgreSQL

## Analiza potrzeb

**RPO** (Recovery Point Objective) — maksymalna utrata danych: 1 godzina
**RTO** (Recovery Time Objective) — maksymalny czas przestoju: 4 godziny

## Krytyczne dane
- Tabela `customers` — dane klientów
- Tabela `orders` — zamówienia i transakcje

## Strategia kopii zapasowych

| Typ | Częstotliwość | Retencja |
|-----|---------------|----------|
| Pełna | Co tydzień (niedziela 00:00) | 4 tygodnie |
| Różnicowa | Codziennie (00:00) | 7 dni |
| WAL archiving | Ciągłe | 7 dni |

## WAL Archiving
PostgreSQL zapisuje każdą zmianę w Write-Ahead Log.
Konfiguracja w `postgresql.conf`:

wal_level = replica
archive_mode = on
archive_command = 'cp %p /var/lib/postgresql/wal_archive/%f'

## Skrypty

### Backup
```bash
~/pg_backup.sh
```

### Monitoring
```bash
~/pg_backup_monitor.sh
```
Alert gdy backup starszy niż 24 godziny.

## Procedura odtwarzania

### Scenariusz 1 — utrata danych
```bash
sudo -u postgres psql -c "CREATE DATABASE business_db_restored;"
sudo -u postgres psql business_db_restored < ~/pg_backups/backup_DATA.sql
```

### Scenariusz 2 — awaria serwera
1. Zainstaluj PostgreSQL na nowym serwerze
2. Skopiuj ostatni backup
3. Odtwórz bazę jak w Scenariuszu 1
4. Zastosuj logi WAL dla punktu w czasie

## Przechowywanie kopii
- **On-site** — `~/pg_backups/` na serwerze lokalnym
- **Off-site** — kopia na zdalnym serwerze lub chmurze (np. AWS S3)

## Harmonogram testów
| Test | Częstotliwość |
|------|---------------|
| Weryfikacja backupu | Co tydzień |
| Test odtwarzania | Co miesiąc |
| Pełny test DRP | Co kwartał |
