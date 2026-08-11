#!/usr/bin/env python3
import requests
import yaml

urls = [
    "https://api.github.com",
    "https://google.com"
]

services = {}

for url in urls:
    try:
        response = requests.get(url, timeout=5)
        if response.status_code == 200:
            services[url] = "🟢 UP"
        else:
            services[url] = "🔴 DOWN"
    except:
        services[url] = "🔴 DOWN"

# pobierz pogodę
weather = requests.get("https://wttr.in/Dublin?format=j1")
weather_data = weather.json()
temp = weather_data['current_condition'][0]['temp_C']

# stwórz raport
raport = {
    'services_status': services,
    'environment_info': {'temperatura_Dublin': temp}
}

# zapisz do pliku YAML
with open('daily_report.yaml', 'w') as f:
    yaml.dump(raport, f, allow_unicode=True)

print("Raport zapisany do daily_report.yaml")
