from flask import Flask, request, jsonify
from flask_cors import CORS
import pymysql

# إعدادات قاعدة البيانات
class Config:
    MYSQL_HOST = 'localhost'  # اسم المضيف لقاعدة البيانات
    MYSQL_USER = 'root'       # اسم المستخدم لقاعدة البيانات
    MYSQL_PASSWORD = 'a10077shsh0'   # كلمة مرور قاعدة البيانات
    MYSQL_DB = 'livi'         # اسم قاعدة البيانات
    MYSQL_PORT = 3306         # المنفذ الافتراضي لـ MySQL

# تعريف التطبيق
app = Flask(__name__)
CORS(app)  # السماح بالطلبات الخارجية

# إعداد الاتصال بقاعدة البيانات باستخدام pymysql
def get_db_connection():
    return pymysql.connect(
        host=Config.MYSQL_HOST,
        user=Config.MYSQL_USER,
        password=Config.MYSQL_PASSWORD,
        database=Config.MYSQL_DB,
        port=Config.MYSQL_PORT,
        cursorclass=pymysql.cursors.DictCursor
    )

# نموذج بيانات
class Employee:
    def __init__(self, id, name, email, department, created_at):
        self.id = id
        self.name = name
        self.email = email
        self.department = department
        self.created_at = created_at

    def to_dict(self):
        return {
            "id": self.id,
            "name": self.name,
            "email": self.email,
            "department": self.department,
            "created_at": self.created_at,
        }

# تعريف المسارات
@app.route('/register', methods=['POST'])
def register_employee():
    try:
        # استقبال البيانات من الطلب
        data = request.json
        print("Received Data:", data)

        # التحقق من وجود Date_joined أو تحديده افتراضيًا
        date_joined = data.get('Date_joined', None)  # إذا لم تُرسل، تكون القيمة None
        if not date_joined:
            from datetime import datetime
            date_joined = datetime.now().strftime('%Y-%m-%d')  # تعيين تاريخ اليوم

        # معالجة البيانات وإضافتها إلى قاعدة البيانات
        connection = get_db_connection()
        with connection.cursor() as cursor:
            cursor.execute("""
                INSERT INTO Employee (name, email, password, department, Date_joined)
                VALUES (%s, %s, %s, %s, %s)
            """, (data['name'], data['email'], data['password'], data['department'], date_joined))
            connection.commit()

        return jsonify({"message": "Employee registered successfully!"}), 201
    except Exception as e:
        print("Error:", str(e))
        return jsonify({"error": str(e)}), 400

@app.route('/employees', methods=['GET'])
def get_employees():
    try:
        connection = get_db_connection()
        with connection.cursor() as cursor:
            cursor.execute("SELECT * FROM Employee")
            result = cursor.fetchall()

        employees = [{"id": row['id'], "name": row['name'], "email": row['email'], "department": row['department']} for row in result]
        return jsonify(employees), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 400

@app.route('/delete_employee/<int:employee_id>', methods=['DELETE'])
def delete_employee(employee_id):
    try:
        # الاتصال بقاعدة البيانات
        connection = get_db_connection()
        with connection.cursor() as cursor:
            # التحقق من وجود الموظف
            cursor.execute("SELECT * FROM Employee WHERE Employee_ID = %s", (employee_id,))
            employee = cursor.fetchone()
            if not employee:
                return jsonify({"error": "Employee not found"}), 404

            # حذف الموظف
            cursor.execute("DELETE FROM Employee WHERE Employee_ID = %s", (employee_id,))
            connection.commit()

        return jsonify({"message": "Employee deleted successfully!"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 400


@app.route('/routes', methods=['GET'])
def list_routes():
    output = []
    for rule in app.url_map.iter_rules():
        methods = ','.join(rule.methods)
        line = f"{rule.rule} [{methods}]"
        output.append(line)
    return jsonify(output)

# تشغيل التطبيق
if __name__ == "__main__":
    app.run(debug=True)