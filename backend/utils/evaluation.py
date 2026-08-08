import os
import matplotlib.pyplot as plt
import seaborn as sns

from sklearn.metrics import (
    confusion_matrix,
    classification_report,
    accuracy_score
)


def evaluate_model(
    model_name,
    y_true,
    y_pred,
    encoder
):

    # Create Result Folder


    result_dir = f"backend/results/{model_name.lower()}"

    os.makedirs(
        result_dir,
        exist_ok=True
    )

    # Accuracy


    accuracy = accuracy_score(
        y_true,
        y_pred
    )

    print("\n===============================")
    print(model_name)
    print("===============================")

    print(
        f"Accuracy : {accuracy*100:.2f}%"
    )

    # Save Accuracy

    with open(
        f"{result_dir}/accuracy.txt",
        "w"
    ) as f:

        f.write(
            f"{accuracy*100:.2f}"
        )

    # Classification Report

    report = classification_report(

        y_true,

        y_pred,

        target_names=encoder.classes_

    )

    print("\nClassification Report\n")

    print(report)

    # Save Report

    with open(
        f"{result_dir}/classification_report.txt",
        "w"
    ) as f:

        f.write(report)


    # Confusion Matrix

    cm = confusion_matrix(

        y_true,

        y_pred

    )

    plt.figure(figsize=(6, 5))

    sns.heatmap(

        cm,

        annot=True,

        fmt="d",

        cmap="Blues",

        xticklabels=encoder.classes_,

        yticklabels=encoder.classes_

    )

    plt.title(
        f"{model_name} Confusion Matrix"
    )

    plt.xlabel(
        "Predicted"
    )

    plt.ylabel(
        "Actual"
    )

    plt.tight_layout()

    plt.savefig(
        f"{result_dir}/confusion_matrix.png"
    )

    plt.show()

    return accuracy