from flask import Flask, jsonify

app = Flask(__name__)


@app.route("/health")
@app.route("/service-a/health")
def health():
    return jsonify(status="healthy", service="service-a"), 200


@app.route("/")
@app.route("/service-a")
@app.route("/service-a/")
def index():
    return jsonify(message="Hello from Service A"), 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
