from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:a10077shsh0@localhost/livi'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

class Survey(db.Model):
    __tablename__ = 'Surveys'
    Survey_ID = db.Column(db.Integer, primary_key=True)
    Manager_ID = db.Column(db.Integer, db.ForeignKey('Manager.Manager_ID'), nullable=False)
    Survey_Date = db.Column(db.Date, nullable=False)
    Burnout_Level = db.Column(db.String(50))

# إنشاء الجداول إذا لم تكن موجودة
with app.app_context():
    db.create_all()

# GET: عرض جميع الاستبيانات
@app.route('/surveys', methods=['GET'])
def get_surveys():
    surveys = Survey.query.all()
    return jsonify([{
        'Survey_ID': survey.Survey_ID,
        'Manager_ID': survey.Manager_ID,
        'Survey_Date': survey.Survey_Date.isoformat() if survey.Survey_Date else None,
        'Burnout_Level': survey.Burnout_Level
    } for survey in surveys])

# PUT: تحديث استبيان
@app.route('/survey/<int:id>', methods=['PUT'])
def update_survey(id):
    survey = Survey.query.get_or_404(id)
    data = request.get_json()

    # تحديث البيانات
    survey.Burnout_Level = data.get('Burnout_Level', survey.Burnout_Level)
    survey.Survey_Date = data.get('Survey_Date', survey.Survey_Date)
    
    db.session.commit()
    
    return jsonify({
        'message': 'تم تعديل الاستبيان بنجاح',
        'Survey_ID': survey.Survey_ID
    })

if __name__ == '__main__':
    app.run(debug=True)