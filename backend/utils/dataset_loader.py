import os
import numpy as np
import librosa

from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder

from backend.utils.feature_extractor import extract_features

# ---------------------------------------
# Project Path
# ---------------------------------------

CURRENT_DIR = os.path.dirname(os.path.abspath(__file__))

BACKEND_DIR = os.path.dirname(CURRENT_DIR)

PROJECT_DIR = os.path.dirname(BACKEND_DIR)

DATASET_PATH = os.path.join(PROJECT_DIR, "dataset")

# ---------------------------------------
# Load Dataset
# ---------------------------------------

def load_dataset():

    X = []

    y = []

    print("\nLoading Dataset...\n")

    for label in os.listdir(DATASET_PATH):

        folder = os.path.join(DATASET_PATH, label)

        if not os.path.isdir(folder):

            continue

        print(f"Loading {label}")

        for file in os.listdir(folder):

            if file.endswith(".wav"):

                file_path = os.path.join(folder, file)

                try:
                    #features = extract_features(file_path)
                    audio, sr = librosa.load(
                        file_path,
                        sr=22050
                    )

                    features = extract_features(audio, sr)

                    X.append(features)

                    y.append(label)

                except Exception as e:

                    #print("Skipped:", file)
                    print("\n-------------------------")
                    print(file_path)
                    print(e)
                    print("-------------------------")

    X = np.array(X)

    y = np.array(y)

    print("\nDataset Loaded")

    print("Total Samples :", len(X))

    print("Classes :", np.unique(y))

    encoder = LabelEncoder()

    y = encoder.fit_transform(y)

    X_train, X_test, y_train, y_test = train_test_split(

        X,

        y,

        test_size=0.20,

        random_state=42,

        stratify=y

    )

    return (

        X_train,

        X_test,

        y_train,

        y_test,

        encoder

    )