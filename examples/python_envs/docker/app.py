from flask import Flask
import os
from os import environ

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello, World from py-env!"

@app.route("/secret")
def secret():
    SECRET_KEY = environ.get('SECRET_KEY')
    return "Le secret est : {}".format(SECRET_KEY)

if __name__ == "__main__":
    port = int(os.environ.get('PORT', 5000))
    app.run(debug=True, host='0.0.0.0', port=port)