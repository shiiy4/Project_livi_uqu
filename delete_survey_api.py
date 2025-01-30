from flask import Flask, jsonify
import mysql.connector

app = Flask(__name__)

# إعداد الاتصال بقاعدة البيانات
db = mysql.connector.connect(
    host="127.0.0.1",
    user="root",
    password="a10077shsh0",
    database="livi",
    port=3306
)
# DELETE: حذف استبيان
@app.route('/survey/<int:survey_id>', methods=['DELETE'])
def delete_survey(survey_id):
    try:
        # إنشاء المؤشر
        cursor = db.cursor(dictionary=True)

        # البحث عن الاستبيان في قاعدة البيانات
        cursor.execute("SELECT * FROM surveys WHERE Survey_ID = %s", (survey_id,))
        survey = cursor.fetchone()

        # التحقق من وجود الاستبيان
        if not survey:
            return jsonify({'error': f'Survey with ID {survey_id} not found'}), 404

        # حذف الاستبيان
        cursor.execute("DELETE FROM surveys WHERE Survey_ID = %s", (survey_id,))
        db.commit()
        cursor.close()

        return jsonify({'message': f'Survey with ID {survey_id} deleted successfully.'}), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500

# تشغيل التطبيق
if __name__ == "__main__":
    app.run(debug=True)