# GIT_WORKFLOW.md

## Diagram Git Flow

main        ──────────────────────────●──────●
|      |
release/1.0 ──────────────────────●───┘      |
|           |
develop     ──●────────────────●──┘      ●───┘
\              /          |
feature/mon  ───●────────────┘           |
\                         |
feature/log  ───●────────────┘           |
|
hotfix       ────────────────────────────●

## Typy gałęzi

**main** — kod produkcyjny, zawsze stabilny, trafia do klienta

**develop** — gałąź deweloperska, tu trafiają gotowe funkcje

**feature/xxx** — osobna gałąź dla każdej nowej funkcji, tworzona z `develop`, każdy programista pracuje na swojej gałęzi żeby nie nadpisywać kodu innych

**release/xxx** — przejściowa gałąź do przygotowania wersji przed wypuszczeniem, tu poprawiane są ostatnie błędy i zmieniane numery wersji

**hotfix/xxx** — pilna naprawa błędu w produkcji, tworzona z `main` (nie z `develop`) bo klient ma problem teraz

## Użyte komendy

```bash
# Tworzenie i przełączanie gałęzi
git checkout -b feature/monitoring develop
git checkout -b hotfix/critical-bug main

# Scalanie
git merge feature/monitoring
git merge --no-ff release/1.0.0

# Tagowanie wersji
git tag -a v1.0.0 -m "Version 1.0.0"

# Podgląd historii
git log --oneline --all --graph
```

## Rozwiązywanie konfliktów

Konflikt powstaje gdy dwie gałęzie modyfikują ten sam plik.
Rozwiązanie: edytuj plik ręcznie, usuń znaczniki `<<<<`, `====`, `>>>>`,
następnie `git add .` i `git commit`.

## Przepływ pracy

1. Nowa funkcja → utwórz `feature/xxx` z `develop`
2. Gotowa funkcja → merguj do `develop`
3. Nowa wersja → utwórz `release/xxx` z `develop`, merguj do `main`
4. Błąd w produkcji → utwórz `hotfix/xxx` z `main`, merguj do `main` i `develop`
