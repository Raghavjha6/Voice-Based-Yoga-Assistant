import librosa

from backend.utils.feature_extractor import extract_features

from backend.predictor.ensemble_predictor import (
    ensemble_predict
)

# =====================================
# Test Audio File
# =====================================

file_path = "dataset/Bhramari/asana6.wav"

audio, sr = librosa.load(
    file_path,
    sr=22050
)

features = extract_features(
    audio,
    sr
)

prediction = ensemble_predict(
    features
)

print("\nPrediction :", prediction)