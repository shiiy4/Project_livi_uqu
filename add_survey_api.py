from flask import Flask, request, jsonify
import mysql.connector

from flask_cors import CORS

app = Flask(__name__)

CORS(app)

@app.route('/example')
def example():
    return {'message': 'CORS enabled'}




# إعداد الاتصال بقاعدة البيانات
db = mysql.connector.connect(
    host="127.0.0.1",
    user="root",
    password="a10077shsh0",
    database="livi",
    port=3306
)

# تعريف مسار لإضافة استبيان جديد
@app.route('/survey', methods=['POST'])
def add_survey():
    try:
        data = request.get_json()
        number = data.get('number')
        Manager_ID = data.get('Manager_ID')

        if not number or not Manager_ID:
            return jsonify({"error": "Survey number and Manager ID are required"}), 400

        cursor = db.cursor()
        query = "INSERT INTO Surveys (Survey_ID, Manager_ID, Survey_Date) VALUES (%s, %s, NOW())"
        cursor.execute(query, (number, Manager_ID))
        db.commit()

        return jsonify({"message": f"Survey '{number}' has been added successfully."}), 201

    except Exception as e:
        return jsonify({"error": str(e)}), 500

# تشغيل التطبيق
if __name__ == '__main__':



    app.run(debug=True, port=5000)