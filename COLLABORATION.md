# COLLABORATION.md

## Procedura wysłania zmian (push)

1. Utwórz gałąź feature z develop
2. Wprowadź zmiany i commituj
3. Wypchnij gałąź na GitHub

```bash
git checkout -b feature/nazwa develop
git add .
git commit -m "Opis zmian"
git push origin feature/nazwa
```

## Procedura pobrania zmian (pull/fetch)

```bash
# Pobierz informacje o zdalnych gałęziach (bez scalania)
git fetch origin

# Pobierz i scal zmiany z aktualną gałęzią
git pull origin develop
```

**Różnica:** `fetch` tylko pobiera informacje, `pull` pobiera i scala.

## Jak tworzyć Pull Request

1. Wypchnij gałąź na GitHub (`git push origin feature/nazwa`)
2. Wejdź na GitHub → pojawi się banner "Compare & pull request"
3. Ustaw `base: develop` ← `compare: feature/nazwa`
4. Wpisz tytuł i opis zmian
5. Kliknij "Create pull request"
6. Po review kliknij "Merge pull request"

## Cleanup po merge

```bash
# Usuń gałąź lokalnie
git branch -d feature/nazwa

# Usuń gałąź na GitHubie
git push origin --delete feature/nazwa
```

## Best practices dla zespołu

- Każda funkcja = osobna gałąź `feature`
- Zawsze twórz gałąź z `develop`, nie z `main`
- Opisuj commity jasno i po angielsku
- Przed PR upewnij się że kod działa
- `main` zawsze musi być stabilny
- Hotfixy tworz z `main` i merguj do `main` i `develop`
