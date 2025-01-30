from flask import Flask, request, jsonify

app = Flask(__name__)

# Example in-memory settings store
user_privacy_settings = {}

@app.route('/update-privacy', methods=['POST'])
def update_privacy():
    """
    Update user privacy settings.
    """
    try:
        data = request.json
        user_id = data.get('user_id')
        settings = data.get('settings')

        if not user_id or not settings:
            return jsonify({"status": "error", "message": "Invalid input"}), 400

        user_privacy_settings[user_id] = settings
        return jsonify({"status": "success", "message": "Privacy settings updated"}), 200
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)