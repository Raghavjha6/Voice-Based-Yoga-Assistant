from backend.utils.evaluation import evaluate_model

y_true = [0,0,1,1,0,1,0,1]

y_pred = [0,0,1,0,0,1,1,1]


class DummyEncoder:

    classes_=["Bhramari","Om"]


accuracy = evaluate_model(

    "Dummy",

    y_true,

    y_pred,

    DummyEncoder()

)

print(accuracy)