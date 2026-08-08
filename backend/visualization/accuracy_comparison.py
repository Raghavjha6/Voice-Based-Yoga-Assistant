import os
import pandas as pd
import matplotlib.pyplot as plt

models = [
    "Logistic Regression",
    "Decision Tree",
    "SVM",
    "Neural Network"
]

accuracies = [
    83.72,
    79.70,
    88.37,
    86.05
]

os.makedirs(
    "backend/results/comparison",
    exist_ok=True
)

# CSV Table
df = pd.DataFrame({

    "Model": models,

    "Accuracy (%)": accuracies

})

df.to_csv(

    "backend/results/comparison/model_comparison.csv",

    index=False

)

# Graph
plt.figure(figsize=(8,6))

plt.bar(

    models,

    accuracies

)

plt.title(
    "Model Accuracy Comparison"
)

plt.ylabel(
    "Accuracy (%)"
)

plt.ylim(
    0,
    100
)

for i, value in enumerate(accuracies):

    plt.text(

        i,

        value + 1,

        f"{value:.2f}%",

        ha="center"

    )

plt.tight_layout()

plt.savefig(

    "backend/results/comparison/accuracy_comparison.png"

)

plt.show()