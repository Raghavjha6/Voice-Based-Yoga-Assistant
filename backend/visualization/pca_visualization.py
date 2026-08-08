import matplotlib.pyplot as plt

from sklearn.decomposition import PCA

from backend.utils.dataset_loader import load_dataset


X_train, X_test, y_train, y_test, encoder = load_dataset()

# Combine train and test
import numpy as np

X = np.vstack([X_train, X_test])
y = np.hstack([y_train, y_test])

# PCA
pca = PCA(n_components=2)

X_pca = pca.fit_transform(X)

plt.figure(figsize=(8,6))

for label in np.unique(y):

    plt.scatter(
        X_pca[y == label, 0],
        X_pca[y == label, 1],
        label=encoder.classes_[label]
    )

plt.title("PCA Visualization")

plt.xlabel("Principal Component 1")
plt.ylabel("Principal Component 2")

plt.legend()

plt.grid(True)

import os

os.makedirs(
    "backend/results/pca",
    exist_ok=True
)

plt.savefig(
    "backend/results/pca/pca_visualization.png"
)

plt.show()