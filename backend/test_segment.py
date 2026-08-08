from pathlib import Path
from utils.audio_segment import split_audio

BASE_DIR = Path(__file__).resolve().parent
PROJECT_DIR = BASE_DIR.parent

file = PROJECT_DIR / "dataset" / "Om" / "asana8.wav"

segments = split_audio(str(file))

print("Total Segments:", len(segments))

for i, segment in enumerate(segments):
    print(f"Segment {i+1}: {len(segment)} samples")