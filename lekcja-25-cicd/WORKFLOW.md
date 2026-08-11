# CI/CD Pipeline - GitHub Actions

## Opis workflow

Workflow uruchamia się automatycznie przy każdym `push` i `pull_request`.

## Joby

### 1. Build
- Pobiera kod z repozytorium
- Symuluje budowanie aplikacji
- Zapisuje artefakt (tylko na master)

### 2. Test
- Uruchamia się po Build
- Symuluje testy aplikacji

### 3. Deploy
- Uruchamia się po Test
- Działa TYLKO na gałęzi master
- Symuluje wdrożenie na produkcję

## Zmienne środowiskowe
- `github.ref` - referencja do gałęzi

## Artefakty
Dostępne do pobrania w zakładce Actions → dany run → Artifacts
