import sounddevice as sd
from scipy.io.wavfile import write


def record_audio(
    filename="temp.wav",
    duration=2,
    sample_rate=22050
):

    print("\nListening...")

    audio = sd.rec(
        int(duration * sample_rate),
        samplerate=sample_rate,
        channels=1,
        dtype="float32"
    )

    sd.wait()

    write(
        filename,
        sample_rate,
        audio
    )

    print("Recording Complete")

    return filename