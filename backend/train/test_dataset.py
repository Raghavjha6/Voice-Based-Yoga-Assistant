from backend.utils.dataset_loader import load_dataset

X_train, X_test, y_train, y_test, encoder = load_dataset()

print()

print("Training Samples :", len(X_train))

print("Testing Samples :", len(X_test))

print()

print("Classes :")

print(encoder.classes_)

print()

print("Feature Length :", X_train.shape[1])