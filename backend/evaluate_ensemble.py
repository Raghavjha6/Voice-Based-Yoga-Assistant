import os
import matplotlib.pyplot as plt
import seaborn as sns

from sklearn.metrics import (
    accuracy_score,
    confusion_matrix,
    classification_report
)

from backend.utils.dataset_loader import load_dataset
from backend.predictor.ensemble_predictor import ensemble_predict
# ---------------------------------------
# Load Test Dataset
# ---------------------------------------

_, X_test, _, y_test, encoder = load_dataset()

# ---------------------------------------
# Predict using Ensemble
# ---------------------------------------

y_pred = []

for features in X_test:
    label = ensemble_predict(features)
    y_pred.append(label)

# Convert labels back to encoded values
y_pred = encoder.transform(y_pred)

# ---------------------------------------
# Accuracy
# ---------------------------------------

accuracy = accuracy_score(y_test, y_pred)

print("\n==============================")
print("Majority Voting Ensemble")
print("==============================")
print(f"Accuracy : {accuracy*100:.2f}%")

# ---------------------------------------
# Classification Report
# ---------------------------------------

report = classification_report(
    y_test,
    y_pred,
    target_names=encoder.classes_
)

print("\nClassification Report\n")
print(report)

# ---------------------------------------
# Save Results
# ---------------------------------------

result_dir = "backend/results/ensemble"

os.makedirs(result_dir, exist_ok=True)

with open(
    f"{result_dir}/accuracy.txt",
    "w"
) as f:
    f.write(f"{accuracy*100:.2f}")

with open(
    f"{result_dir}/classification_report.txt",
    "w"
) as f:
    f.write(report)


# Confusion Matrix

cm = confusion_matrix(
    y_test,
    y_pred
)

plt.figure(figsize=(6,5))

sns.heatmap(
    cm,
    annot=True,
    fmt="d",
    cmap="Blues",
    xticklabels=encoder.classes_,
    yticklabels=encoder.classes_
)

plt.title("Majority Voting Ensemble")
plt.xlabel("Predicted")
plt.ylabel("Actual")

plt.tight_layout()

plt.savefig(
    f"{result_dir}/confusion_matrix.png"
)

plt.show()

print("\nResults saved successfully.")