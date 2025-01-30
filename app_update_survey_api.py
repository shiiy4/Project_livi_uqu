from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

# إعداد التطبيق
app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:a10077shsh0@localhost/livi'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# تعريف SQLAlchemy
db = SQLAlchemy(app)

# تعريف نموذج Survey
class Survey(db.Model):
    __tablename__ = 'Surveys'
    Survey_ID = db.Column(db.Integer, primary_key=True, autoincrement=True)
    Manager_ID = db.Column(db.Integer, nullable=False)
    Survey_Date = db.Column(db.Date, nullable=False, default=datetime.utcnow)
    Burnout_Level = db.Column(db.String(50))  # فقط مستوى الاحتراق الوظيفي

# إنشاء الجداول إذا لم تكن موجودة
with app.app_context():
    db.create_all()

# GET: عرض جميع الاستبيانات
@app.route('/api/surveys', methods=['GET'])
def get_surveys():
    try:
        surveys = Survey.query.all()
        return jsonify([{
            'Survey_ID': survey.Survey_ID,
            'Manager_ID': survey.Manager_ID,
            'Survey_Date': survey.Survey_Date.isoformat(),
            'Burnout_Level': survey.Burnout_Level
        } for survey in surveys])
    except Exception as e:
        return jsonify({'error': str(e)}), 500

# PUT: تحديث استبيان
@app.route('/api/surveys/<int:id>', methods=['PUT'])
def update_survey(id):
    try:
        survey = Survey.query.get_or_404(id)
        data = request.get_json()
        survey.Burnout_Level = data.get('Burnout_Level', survey.Burnout_Level)
        db.session.commit()
        return jsonify({
            'Survey_ID': survey.Survey_ID,
            'Manager_ID': survey.Manager_ID,
            'Survey_Date': survey.Survey_Date.isoformat(),
            'Burnout_Level': survey.Burnout_Level
        })
    except Exception as e:
        return jsonify({'error': str(e)}), 500

# تشغيل التطبيق
if __name__ == '__main__':
    app.run(debug=True)