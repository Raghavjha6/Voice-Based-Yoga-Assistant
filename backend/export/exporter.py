import os
import pandas as pd

from backend.database.session_repository import SessionRepository

repo = SessionRepository()

# Folder where exporter.py exists
CURRENT_DIR = os.path.dirname(os.path.abspath(__file__))

# backend/export/files
EXPORT_FOLDER = os.path.join(
    CURRENT_DIR,
    "files"
)

os.makedirs(
    EXPORT_FOLDER,
    exist_ok=True
)


def export_excel():

    history = repo.get_all_sessions()

    df = pd.DataFrame(history)

    filepath = os.path.join(
        EXPORT_FOLDER,
        "session_history.xlsx"
    )

    df.to_excel(
        filepath,
        index=False
    )

    return filepath


def export_csv():

    history = repo.get_all_sessions()

    df = pd.DataFrame(history)

    filepath = os.path.join(
        EXPORT_FOLDER,
        "session_history.csv"
    )

    df.to_csv(
        filepath,
        index=False
    )

    return filepath