from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/guidance', methods=['POST'])
def guidance():
    data = request.get_json()

    args = data.get('args', {})
    payload = data.get('payload', "")

    # use args and payload as needed
    return jsonify({"message": "Received", "args": args, "payload": payload})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8181)
