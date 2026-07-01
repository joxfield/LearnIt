# PROJECT_SETUP_GUIDE.md

## Jak używać skryptu

```bash
./project_setup.sh <nazwa_projektu> <język> [katalogi]
```

## Parametry

- `$1` - nazwa projektu (obowiązkowy) — nazwa głównego katalogu projektu
- `$2` - język programowania (obowiązkowy) — obsługiwane: `python`, `js`, `go`
- `$3` - katalogi (opcjonalny) — lista katalogów oddzielona przecinkami, domyślnie: `src,tests,docs`

## Przykłady użycia

```bash
# Projekt Python z domyślnymi katalogami
./project_setup.sh my_project python

# Projekt JavaScript z niestandardowymi katalogami
./project_setup.sh my_app js "src,tests,build,docs"

# Projekt Go
./project_setup.sh my_service go "src,tests"
```

## Co skrypt tworzy

- Strukturę katalogów
- Plik `.gitignore` dopasowany do języka
- Plik startowy (`main.py` / `index.js` / `main.go`)
- `README.md`
- `setup.log` z logami wszystkich akcji
- Repozytorium Git
