#!/usr/bin/env python3
import string
from collections import Counter

user_text = input("Wprowadź tekst do analizy: ")

# Statystyki znaków
total_chars = len(user_text)
chars_no_spaces = len(user_text.replace(" ", ""))
word_count = len(user_text.split())
sentence_count = user_text.count(".") + user_text.count("!") + user_text.count("?")

# Najdłuższe słowo
longest_word = max(user_text.split(), key=len)

# Najczęstsze słowo
clean_text = user_text.lower()
for char in string.punctuation:
    clean_text = clean_text.replace(char, "")
word_counts = Counter(clean_text.split())
most_common = word_counts.most_common(1)

# Wyniki
print(f"Znaki ze spacjami: {total_chars}")
print(f"Znaki bez spacji: {chars_no_spaces}")
print(f"Liczba słów: {word_count}")
print(f"Liczba zdań: {sentence_count}")
print(f"Najdłuższe słowo: {longest_word}")
print(f"Najczęstsze słowo: {most_common}")
