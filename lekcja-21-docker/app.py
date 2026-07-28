from flask import Flask, jsonify
import psycopg2
import os

app = Flask(__name__)

def get_db():
    return psycopg2.connect(
        host=os.environ.get('DB_HOST', 'localhost'),
        database=os.environ.get('DB_NAME', 'postgres'),
        user=os.environ.get('DB_USER', 'postgres'),
        password=os.environ.get('DB_PASSWORD', 'haslo123')
    )

@app.route('/')
def index():
    return "<h1>Aplikacja działa!</h1>"

@app.route('/db')
def test_db():
    try:
        conn = get_db()
        return "<h1>Połączono z bazą danych!</h1>"
    except Exception as e:
        return f"<h1>Błąd: {str(e)}</h1>"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
