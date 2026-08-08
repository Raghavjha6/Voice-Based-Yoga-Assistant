from flask import Flask
from flask_cors import CORS

from backend.api.routes import api

app = Flask(
    __name__,
    template_folder="../templates",
    static_folder="../static"
)

CORS(app)

app.register_blueprint(api)

if __name__ == "__main__":

    app.run(
        host="0.0.0.0",
        port=5000,
        debug=True
    )