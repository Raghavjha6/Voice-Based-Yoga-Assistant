import joblib

from sklearn.tree import DecisionTreeClassifier

from backend.utils.dataset_loader import load_dataset
from backend.utils.evaluation import evaluate_model
from backend.utils.model_saver import save_model


print("\nLoading Dataset...")

X_train, X_test, y_train, y_test, encoder = load_dataset()

print("\nTraining Decision Tree...")
model = DecisionTreeClassifier(criterion="gini", max_depth=10, random_state=42)
model.fit(X_train, y_train)
print("\nPredicting...")
y_pred = model.predict(X_test)
accuracy = evaluate_model("dt", y_test, y_pred, encoder)

save_model(

    model,

    "dt_model.pkl"

)

print("\nDecision Tree Training Complete")

print(
    f"\nFinal Accuracy : {accuracy*100:.2f}%"
)