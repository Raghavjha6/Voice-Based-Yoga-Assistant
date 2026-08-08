from utils.feature_extractor import extract_features

file = "../dataset/Om/asana8.wav"

features = extract_features(file)

print("Feature Length:", len(features))
print(features)