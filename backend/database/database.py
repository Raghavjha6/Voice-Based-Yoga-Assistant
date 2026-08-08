import sqlite3
import os


DATABASE_PATH = os.path.join(
    "backend",
    "database_files",
    "yoga.db"
)


def get_connection():

    conn = sqlite3.connect(DATABASE_PATH)

    conn.row_factory = sqlite3.Row

    return conn


def initialize_database():

    conn = get_connection()

    cursor = conn.cursor()

    cursor.execute("""

        CREATE TABLE IF NOT EXISTS session_history(

            id INTEGER PRIMARY KEY AUTOINCREMENT,

            date TEXT NOT NULL,

            time TEXT NOT NULL,

            pranayama TEXT NOT NULL,

            duration REAL NOT NULL,

            confidence REAL NOT NULL

        )

    """)

    conn.commit()

    conn.close()


if __name__ == "__main__":

    initialize_database()

    print("Database Initialized Successfully.")