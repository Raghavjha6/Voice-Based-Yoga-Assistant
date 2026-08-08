import joblib
import os


def save_model(model,
               filename):

    os.makedirs(
        "backend/models",
        exist_ok=True
    )

    joblib.dump(
        model,
        f"backend/models/{filename}"
    )

    print(
        f"\nSaved: {filename}"
    )