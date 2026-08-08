import joblib

from tensorflow.keras.models import load_model


def load_all_models():

    svm = joblib.load(
        "backend/models/svm_model.pkl"
    )

    lr = joblib.load(
        "backend/models/lr_model.pkl"
    )

    dt = joblib.load(
        "backend/models/dt_model.pkl"
    )

    nn = load_model(
        "backend/models/nn_model.keras"
    )

    encoder = joblib.load(
        "backend/models/encoder.pkl"
    )

    return svm, lr, dt, nn, encoder