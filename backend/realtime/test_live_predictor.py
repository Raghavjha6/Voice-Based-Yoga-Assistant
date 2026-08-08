from backend.realtime.live_predictor import (
    predict_audio_file
)

file_path = "dataset/Bhramari/asana6.wav"

prediction = predict_audio_file(
    file_path
)

print(
    "\nPrediction:",
    prediction
)