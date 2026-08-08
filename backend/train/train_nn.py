import numpy as np
import joblib
import matplotlib.pyplot as plt

from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Dropout
from tensorflow.keras.utils import to_categorical

from backend.utils.dataset_loader import load_dataset
from backend.utils.evaluation import evaluate_model


print("\nLoading Dataset...")

X_train, X_test, y_train, y_test, encoder = load_dataset()
# One-hot encoding
y_train_cat = to_categorical(y_train)
y_test_cat = to_categorical(y_test)
print("\nTraining Neural Network...")
model = Sequential()
model.add(Dense(128, activation="relu", input_shape=(22,)))
model.add(Dropout(0.3))
model.add(Dense(64, activation="relu"))
model.add(Dropout(0.3))
model.add(Dense(len(encoder.classes_), activation="softmax"))
model.compile(optimizer="adam", loss="categorical_crossentropy", metrics=["accuracy"])
history = model.fit(
    X_train,
    y_train_cat,
    validation_data=(X_test, y_test_cat),
    epochs=100,
    batch_size=8,
    verbose=1
)
y_pred_prob = model.predict(X_test)
y_pred = np.argmax(y_pred_prob, axis=1)
accuracy = evaluate_model("nn", y_test, y_pred, encoder)

# Accuracy Graph
plt.figure(figsize=(8,6))

plt.plot(history.history["accuracy"])
plt.plot(history.history["val_accuracy"])

plt.title("Neural Network Accuracy")

plt.xlabel("Epoch")
plt.ylabel("Accuracy")

plt.legend([
    "Train",
    "Validation"
])

plt.savefig(
    "backend/results/nn/accuracy_graph.png"
)

plt.show()

# Loss Graph
plt.figure(figsize=(8,6))

plt.plot(history.history["loss"])
plt.plot(history.history["val_loss"])

plt.title("Neural Network Loss")

plt.xlabel("Epoch")
plt.ylabel("Loss")

plt.legend([
    "Train",
    "Validation"
])

plt.savefig(
    "backend/results/nn/loss_graph.png"
)

plt.show()

model.save(
    "backend/models/nn_model.keras"
)

joblib.dump(
    encoder,
    "backend/models/encoder.pkl"
)

print(
    f"\nFinal Accuracy : {accuracy*100:.2f}%"
)