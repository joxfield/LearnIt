#!/bin/bash
# project_setup.sh - Tworzenie struktury projektu

if [[ $# -lt 2 ]]; then
    echo "Użycie: $0 <nazwa_projektu> <jezyk> [katalogi]"
    exit 1
fi

project_name="$1"
language="$2"
custom_dirs="${3:-src,tests,docs}"
IFS=',' read -ra base_dirs <<< "$custom_dirs"

log_action() {
    local message="$1"
    echo "$message"
    if [[ -d "$project_name" ]]; then
        echo "$message" >> $project_name/setup.log
    fi
}

create_dir() {
    local dir="$1"
    if [[ -d "$dir" ]]; then
        log_action "[WARNING] Katalog $dir już istnieje"
        return 1
    fi
    if mkdir -p "$dir"; then
        log_action "[OK] Utworzono katalog $dir"
        return 0
    else
        log_action "[ERROR] Błąd przy tworzeniu $dir"
        return 1
    fi
}

create_gitignore() {
    local project="$1"
    if [[ $language == "python" ]]; then
        cat > "$project/.gitignore" << EOF
__pycache__/
*.pyc
.env
venv/
EOF
    elif [[ $language == "js" ]]; then
        cat > "$project/.gitignore" << EOF
node_modules/
.env
dist/
EOF
    elif [[ $language == "go" ]]; then
        cat > "$project/.gitignore" << EOF
*.exe
*.out
vendor/
EOF
    else
        log_action "[WARNING] Nieznany język - tworzę pusty .gitignore"
        touch "$project/.gitignore"
    fi
    log_action "[OK] Utworzono .gitignore dla $language"
}

create_main_file() {
    local project="$1"
    if [[ $language == "python" ]]; then
        echo 'print("Hello World")' > "$project/src/main.py"
    elif [[ $language == "js" ]]; then
        echo 'console.log("Hello World")' > "$project/src/index.js"
    elif [[ $language == "go" ]]; then
        cat > "$project/src/main.go" << EOF
package main

import "fmt"

func main() {
    fmt.Println("Hello World")
}
EOF
    else
        log_action "[WARNING] Nieznany język"
    fi
    log_action "[OK] Utworzono plik startowy dla $language"
}

create_readme() {
    local project="$1"
    cat > "$project/README.md" << EOF
# $project
## O projekcie
Opis projektu
## Struktura
$(for dir in "${base_dirs[@]}"; do echo "- \`$dir/\`"; done)
## Instalacja
\`\`\`bash
git clone ...
cd $project
\`\`\`
EOF
    log_action "[OK] Utworzono README.md"
}

if ! create_dir "$project_name"; then
    echo "[ERROR] Nie można utworzyć projektu"
    exit 1
fi

log_action "[INFO] Tworzenie struktury projektu $project_name..."

for dir in "${base_dirs[@]}"; do
    create_dir "$project_name/$dir"
done

create_gitignore "$project_name"
create_main_file "$project_name"
create_readme "$project_name"

if command -v git &>/dev/null; then
    (
        cd "$project_name" &&
        git init &&
        log_action "[OK] Zainicjalizowano repozytorium Git"
    )
fi

log_action "[SUCCESS] Projekt $project_name został pomyślnie utworzony!"
