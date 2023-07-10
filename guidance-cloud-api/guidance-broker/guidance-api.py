from flask import Flask, request, jsonify
import guidance

port_number = os.getenv('TG_GUIDANCE_PORT_NUMBER', '9000')
guidance.llm = guidance.llms.TGWUI(f"http://127.0.0.1:{port_number}")

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
