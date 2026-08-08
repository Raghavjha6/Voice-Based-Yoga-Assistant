import numpy as np

from backend.utils.model_loader import (
    load_all_models
)

svm, lr, dt, nn, encoder = load_all_models()


def ensemble_predict(features):
    features = np.array(features).reshape(1, -1)
    svm_pred = svm.predict(features)[0]
    lr_pred = lr.predict(features)[0]
    dt_pred = dt.predict(features)[0]
    nn_pred = np.argmax(nn.predict(features, verbose=0), axis=1)[0]

    votes = [svm_pred, lr_pred, dt_pred, nn_pred]
    final_vote = max(set(votes), key=votes.count)
    label = encoder.inverse_transform([final_vote])[0]
    
    return label

def ensemble_predict_with_confidence(features):

    features = np.array(features).reshape(1, -1)

    svm_prob = svm.predict_proba(
        features
    )[0]

    lr_prob = lr.predict_proba(
        features
    )[0]

    dt_prob = dt.predict_proba(
        features
    )[0]

    nn_prob = nn.predict(
        features,
        verbose=0
    )[0]

    avg_prob = (

        svm_prob +

        lr_prob +

        dt_prob +

        nn_prob

    ) / 4

    class_index = np.argmax(
        avg_prob
    )

    confidence = float(
        avg_prob[class_index]
    )

    label = encoder.inverse_transform(
        [class_index]
    )[0]

    return (label,confidence)