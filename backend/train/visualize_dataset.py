import matplotlib.pyplot as plt

from sklearn.decomposition import PCA
from sklearn.preprocessing import StandardScaler

from backend.utils.dataset_loader import load_dataset

# Load dataset
X_train, X_test, y_train, y_test, encoder = load_dataset()

# Merge
import numpy as np

X = np.vstack((X_train, X_test))
y = np.hstack((y_train, y_test))

# Scale
scaler = StandardScaler()

X = scaler.fit_transform(X)

# PCA
pca = PCA(n_components=2)

X_pca = pca.fit_transform(X)

# Plot
plt.figure(figsize=(8,6))

for label in np.unique(y):

    plt.scatter(

        X_pca[y==label,0],

        X_pca[y==label,1],

        label=encoder.inverse_transform([label])[0]

    )

plt.legend()

plt.title("PCA Visualization")

plt.xlabel("Principal Component 1")

plt.ylabel("Principal Component 2")

plt.grid(True)

plt.show()