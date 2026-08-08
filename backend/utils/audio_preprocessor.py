import librosa
import soundfile as sf
import numpy as np
import tempfile

#This is for mobile application audio preprocessing
def preprocess_audio(input_file):
    """
    Preprocess uploaded audio for Flutter.

    Steps:
    1. Load audio
    2. Convert to mono
    3. Resample to 22050 Hz
    4. Trim leading/trailing silence
    5. Normalize volume
    6. Save processed WAV
    """

    audio, sr = librosa.load(
        input_file,
        sr=22050,
        mono=True
    )

    print(f"Original Samples : {len(audio)}")


    # Trim silence

    audio, _ = librosa.effects.trim(
        audio,
        top_db=25
    )

    # Normalize

    max_amp = np.max(np.abs(audio))

    if max_amp > 0:
        audio = audio / max_amp


    # Save processed audio

    processed = tempfile.NamedTemporaryFile(
        delete=False,
        suffix=".wav"
    )

    processed.close()

    sf.write(
        processed.name,
        audio,
        sr
    )

    return processed.name