from flask import Flask
app = Flask(__name__)

@app.get("/moshe")
def hello():
    return "Hello from Flask!"

@app.get("/edi")
def edi():
    return "Hello from edi!"

@app.get("/ping")
def ping():
    return "PONG"


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
