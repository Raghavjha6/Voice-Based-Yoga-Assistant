import librosa
import numpy as np


def split_audio(file_path,
                segment_duration=3,
                sample_rate=22050):

    """
    Split audio into fixed-length segments.

    Parameters:
        file_path : Path to WAV file
        segment_duration : Duration of each segment (seconds)
        sample_rate : Audio sampling rate

    Returns:
        List of NumPy arrays (audio segments)
    """

    audio, sr = librosa.load(
        file_path,
        sr=sample_rate
    )

    segment_length = segment_duration * sample_rate

    segments = []

    for start in range(0, len(audio), segment_length):

        end = start + segment_length

        segment = audio[start:end]

        # Pad last segment if needed
        if len(segment) < segment_length:

            padding = segment_length - len(segment)

            segment = np.pad(
                segment,
                (0, padding)
            )

        segments.append(segment)

    return segments