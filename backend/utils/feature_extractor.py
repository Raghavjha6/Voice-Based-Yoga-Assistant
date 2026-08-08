import librosa
import numpy as np


def extract_features(audio, sr):
    # Remove silence
    audio, _ = librosa.effects.trim(audio)
    # Pre-emphasis
    audio = librosa.effects.preemphasis(audio)
    # Normalize
    audio = librosa.util.normalize(audio)
    # MFCC (20)
    mfcc = librosa.feature.mfcc(y=audio,sr=sr,n_mfcc=20)
    mfcc_mean = np.mean(mfcc,axis=1)
    # Energy
    energy = np.sum(audio ** 2) / len(audio)
    # ZCR
    zcr = np.mean(librosa.feature.zero_crossing_rate(audio))
    # Final 22 Features
    features = np.hstack([mfcc_mean,energy,zcr])
    return features