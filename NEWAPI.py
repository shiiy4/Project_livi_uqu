from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS
from datetime import datetime
import pymysql

# Fix for MySQL connection
pymysql.install_as_MySQLdb()

# Initialize Flask app
app = Flask(__name__)
CORS(app)  # Enable CORS to allow cross-origin requests

# Configure the database
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:a10077shsh0@localhost/livi'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# Initialize the database
db = SQLAlchemy(app)

# Define database models
class Manager(db.Model):
    __tablename__ = 'Manager'
    Manager_ID = db.Column(db.Integer, primary_key=True)
    Name = db.Column(db.String(100), nullable=False)
    Email = db.Column(db.String(150), nullable=False, unique=True)
    Department = db.Column(db.String(50), nullable=False)
    Phone_No = db.Column(db.String(20), nullable=False, unique=True)


class Employee(db.Model):
    __tablename__ = 'Employee'
    Employee_ID = db.Column(db.Integer, primary_key=True, autoincrement=True)
    Name = db.Column(db.String(255), nullable=False)
    Position = db.Column(db.String(255))
    Date_joined = db.Column(db.Date, nullable=False)
    Email = db.Column(db.String(255), unique=True, nullable=False)
    Phone_No = db.Column(db.String(20), unique=True, nullable=False)
    Status = db.Column(db.String(255), default='Active', nullable=False)
    Department = db.Column(db.String(255), nullable=False)
    Manager_ID = db.Column(db.Integer, db.ForeignKey('Manager.Manager_ID'))


class Report(db.Model):
    __tablename__ = 'Report'
    Report_ID = db.Column(db.Integer, primary_key=True, autoincrement=True)
    Manager_ID = db.Column(db.Integer, db.ForeignKey('Manager.Manager_ID'), nullable=False)
    Report_Date = db.Column(db.Date, nullable=False)
    Summary = db.Column(db.Text, nullable=False)
    Employee_ID = db.Column(db.Integer, db.ForeignKey('Employee.Employee_ID'))


class Notification(db.Model):
    __tablename__ = 'Notification'
    Notification_ID = db.Column(db.Integer, primary_key=True, autoincrement=True)
    Employee_ID = db.Column(db.Integer, db.ForeignKey('Employee.Employee_ID'), nullable=False)
    Message = db.Column(db.Text, nullable=False)
    Sent_Date = db.Column(db.DateTime, default=datetime.utcnow, nullable=False)


# API: Create Report
@app.route('/create_report', methods=['POST'])
def create_report():
    data = request.get_json()
    try:
        if not data.get('Manager_ID') or not data.get('Summary') or not data.get('Report_Date'):
            return jsonify({"error": "Manager_ID, Summary, and Report_Date are required"}), 400

        report = Report(
            Manager_ID=data['Manager_ID'],
            Report_Date=datetime.strptime(data['Report_Date'], '%Y-%m-%d'),
            Summary=data['Summary'],
            Employee_ID=data.get('Employee_ID')
        )
        db.session.add(report)
        db.session.commit()
        return jsonify({"message": "Report created successfully!"}), 201
    except Exception as e:
        db.session.rollback()
        return jsonify({"error": str(e)}), 400


# API: Get Report
@app.route('/get_report/<int:report_id>', methods=['GET'])
def get_report(report_id):
    try:
        report = Report.query.get(report_id)
        if report:
            return jsonify({
                "Report_ID": report.Report_ID,
                "Manager_ID": report.Manager_ID,
                "Report_Date": report.Report_Date.strftime('%Y-%m-%d'),
                "Summary": report.Summary,
                "Employee_ID": report.Employee_ID
            }), 200
        else:
            return jsonify({"message": "Report not found."}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 400


# API: Send Notification
@app.route('/send_notification', methods=['POST'])
def send_notification():
    data = request.get_json()
    try:
        if not data.get('Employee_ID') or not data.get('Message'):
            return jsonify({"error": "Employee_ID and Message are required"}), 400

        notification = Notification(
            Employee_ID=data['Employee_ID'],
            Message=data['Message']
        )
        db.session.add(notification)
        db.session.commit()
        return jsonify({"message": "Notification sent successfully!"}), 201
    except Exception as e:
        db.session.rollback()
        return jsonify({"error": str(e)}), 400


# API: Get Notifications
@app.route('/get_notifications/<int:employee_id>', methods=['GET'])
def get_notifications(employee_id):
    try:
        notifications = Notification.query.filter_by(Employee_ID=employee_id).all()
        if notifications:
            return jsonify([{
                "Notification_ID": n.Notification_ID,
                "Employee_ID": n.Employee_ID,
                "Message": n.Message,
                "Sent_Date": n.Sent_Date.strftime('%Y-%m-%d %H:%M:%S')
            } for n in notifications]), 200
        else:
            return jsonify({"message": "No notifications found."}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 400


# Run the app
if __name__ == '__main__':
    with app.app_context():
        db.create_all()
        print("Database tables created successfully!")

    app.run(debug=True, host='0.0.0.0', port=5000)