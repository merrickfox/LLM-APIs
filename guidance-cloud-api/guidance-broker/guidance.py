from flask import Flask, request, jsonify
import guidance

guidance.llm = guidance.llms.TGWUI("http://127.0.0.1:9555")

app = Flask(__name__)

@app.route('/guidance-api', methods=['POST'])
def guidance():
    data = request.get_json()

    args = data.get('args', {})
    payload = data.get('payload', "")

    execute_prompt = guidance(payload)

    res = execute_prompt(**args)

    # use args and payload as needed
    return jsonify({"data": res})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8181)
