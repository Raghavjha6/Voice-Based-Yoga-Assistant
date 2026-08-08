import librosa
import numpy as np

from backend.utils.feature_extractor import extract_features
from backend.predictor.ensemble_predictor import (
    ensemble_predict_with_confidence,
)


def predict_audio_file(file_path):
    """
    Receives a WAV file path.
    Audio conversion is already handled by audio_converter.py.
    """

    # Load audio
    audio, sr = librosa.load(
        file_path,
        sr=22050,
        mono=True
    )

    print("Sample Rate:", sr)
    print("Samples:", len(audio))
    print("Max amplitude:", np.max(np.abs(audio)))

    # Remove silence
    audio, _ = librosa.effects.trim(
        audio,
        top_db=35
    )

    # Ignore very short recordings
    if len(audio) < sr * 0.2:
        return None, 0.0, 0.0

    # Calculate duration
    duration = round(len(audio) / sr, 2)

    # Calculate energy
    energy = np.mean(audio ** 2)

    print(f"Energy : {energy:.6f}")
    
    print("Energy:", energy)
    # Temporary: do not reject low-energy audio
    # if energy < 0.0005:
    #     return None, 0.0, duration

    # Extract features
    features = extract_features(
        audio,
        sr
    )

    prediction, confidence = (
        ensemble_predict_with_confidence(
            features
        )
    )

    print(
        f"Prediction : {prediction} ({confidence:.2f})"
    )

    return (
        prediction,
        confidence,
        duration
    )