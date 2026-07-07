#!/bin/bash

if [[ $# -lt 2 ]]; then
echo "Użycie: $0 <plik_logu> <wzorzec> [liczba_wyników]"
exit 1

fi

log_file="$1"
pattern="$2"
max_results="${3:-10}"
count=0

validate_input() {

if [ ! -f "$log_file" ]; then
echo "Błąd plik nie istnieje"
exit 1

fi
}

search_logs() {
while read -r line; do
    if [[ "$line" == *"$pattern"* ]]; then
        count=$((count + 1))
		if [[ $count -le $max_results ]]; then
		echo "$line"
		fi
    fi
done < $log_file
echo "Znaleziono: $count"
}

generate_report() {

echo "Data: $(date +"%Y-%m-%d %H:%M:%S")" >> report.txt
echo "Plik: $log_file" >> report.txt
echo "Wzorzec: $pattern" >> report.txt
echo "Znaleziono: $count" >> report.txt
echo "=== Top 5 najczęstszych słów ===" >> report.txt
grep "$pattern" "$log_file" | tr ' ' '\n' | sort | uniq -c | sort -rn | head -5 >> report.txt
}

validate_input
search_logs
generate_report
