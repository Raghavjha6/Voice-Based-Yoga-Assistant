import joblib

from sklearn.linear_model import LogisticRegression

from backend.utils.dataset_loader import load_dataset
from backend.utils.evaluation import evaluate_model
from backend.utils.model_saver import save_model


print("\nLoading Dataset...")

X_train, X_test, y_train, y_test, encoder = load_dataset()
print("\nTraining Logistic Regression...")
model = LogisticRegression(max_iter=1000, random_state=42)
model.fit(X_train, y_train)
print("\nPredicting...")
y_pred = model.predict(X_test)
accuracy = evaluate_model("lr", y_test, y_pred, encoder)

save_model(

    model,

    "lr_model.pkl"

)

print("\nLogistic Regression Training Complete")

print(
    f"\nFinal Accuracy : {accuracy*100:.2f}%"
)