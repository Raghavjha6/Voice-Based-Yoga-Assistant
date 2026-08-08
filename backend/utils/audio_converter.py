import os
import tempfile
import subprocess


# -----------------------------
# Project Root
# -----------------------------
PROJECT_ROOT = os.path.abspath(
    os.path.join(
        os.path.dirname(__file__),
        "..",
        ".."
    )
)

# -----------------------------
# Bundled FFmpeg
# -----------------------------
FFMPEG_PATH = os.path.join(
    PROJECT_ROOT,
    "ffmpeg",
    "bin",
    "ffmpeg.exe"
)


def convert_to_wav(input_file):
    """
    Converts any audio file to WAV using
    the bundled FFmpeg executable.
    Returns:
        wav_file_path
    """

    extension = os.path.splitext(input_file)[1].lower()

    # Already WAV
    if extension == ".wav":
        return input_file

    wav_file = tempfile.NamedTemporaryFile(
        delete=False,
        suffix=".wav"
    )

    wav_file.close()

    command = [
        FFMPEG_PATH,
        "-y",
        "-hide_banner",
        "-loglevel", "error",
        "-i", input_file,
        "-vn",
        "-acodec", "pcm_s16le",
        "-ac", "1",
        "-ar", "22050",
        wav_file.name,
    ]

    result = subprocess.run(

        command,

        stdout=subprocess.PIPE,

        stderr=subprocess.PIPE,

        text=True

    )

    print("FFmpeg stdout:")
    print(result.stdout)

    print("FFmpeg stderr:")
    print(result.stderr)

    if result.returncode != 0:
        raise RuntimeError(result.stderr)

    return wav_file.name