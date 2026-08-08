import joblib

from sklearn.svm import SVC

from backend.utils.dataset_loader import load_dataset
from backend.utils.evaluation import evaluate_model
from backend.utils.model_saver import save_model


print("\nLoading Dataset...")

X_train, X_test, y_train, y_test, encoder = load_dataset()
print("\nTraining SVM...")
model = SVC(kernel="rbf", C=10, gamma="scale", probability=True, random_state=42)
model.fit(X_train, y_train)

print("\nPredicting...")
y_pred = model.predict(X_test)
accuracy = evaluate_model("svm", y_test, y_pred, encoder)

save_model(

    model,

    "svm_model.pkl"

)

joblib.dump(

    encoder,

    "backend/models/encoder.pkl"

)

print("\nSVM Training Complete")

print(
    f"\nFinal Accuracy : {accuracy*100:.2f}%"
)