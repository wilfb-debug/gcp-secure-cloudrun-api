from flask import Flask, jsonify


app = Flask(__name__)

@app.route("/")
def root():
    return {"status": "Sentinal API running"}

@app.get("/health")
def health():
    return {"status": "ok"}

@app.get("/")
def root():
    return {
        "service": "gcp-secure-cloudrun-api",
        "status": "running"
    }

import os

if __name__ == "__main__":
    port = int(os.environ.get("PORT", "8080"))
    app.run(host="0.0.0.0", port=port)
