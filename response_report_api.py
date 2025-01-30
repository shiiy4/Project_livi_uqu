from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy

# تعريف التطبيق
app = Flask(__name__)

# إعداد قاعدة البيانات
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:a10077shsh0@localhost/livi'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# تعريف SQLAlchemy
db = SQLAlchemy(app)

# تعريف نموذج قاعدة البيانات
class SurveyResponse(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    Survey_ID = db.Column(db.Integer, nullable=False)
    Employee_ID = db.Column(db.Integer, nullable=False)
    Burnout_Level = db.Column(db.Integer, nullable=False)

# نقطة نهاية لإرسال الردود
@app.route('/api/submit-response', methods=['POST'])
def submit_response():
    try:
        # قراءة البيانات من الطلب
        data = request.json
        survey_id = data.get('Survey_ID')
        employee_id = data.get('Employee_ID')
        burnout_level = data.get('Burnout_Level')

        # التحقق من المدخلات
        if not all([survey_id, employee_id, burnout_level]):
            return jsonify({'error': 'Missing required fields'}), 400

        # إضافة البيانات إلى قاعدة البيانات
        new_response = SurveyResponse(
            Survey_ID=survey_id,
            Employee_ID=employee_id,
            Burnout_Level=burnout_level
        )
        db.session.add(new_response)
        db.session.commit()

        return jsonify({'message': 'Response submitted successfully!'}), 201

    except Exception as e:
        return jsonify({'error': str(e)}), 500

# تشغيل التطبيق
if __name__ == '__main__':
    with app.app_context():
        db.create_all()  # إنشاء الجداول عند تشغيل التطبيق
    app.run(debug=True)