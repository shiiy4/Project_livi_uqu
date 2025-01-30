from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from random import randint
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)

# Configuration for database

app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:a10077shsh0@localhost/livi'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

# Database Models
class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    phone = db.Column(db.String(15), unique=True, nullable=False)
    password = db.Column(db.String(255), nullable=False)
    validation_code = db.Column(db.String(6), nullable=True)

# Helper function to send validation code (mock function)
def send_validation_code(phone_or_email, code):
    print(f"Validation code {code} sent to {phone_or_email}")
    return True

# API Endpoints
@app.route('/login', methods=['POST'])
def login():
    data = request.json
    username_or_email = data.get('username_or_email')
    password = data.get('password')

    user = User.query.filter((User.username == username_or_email) | (User.email == username_or_email)).first()

    if user and check_password_hash(user.password, password):
        # Generate a validation code and save it
        validation_code = str(randint(100000, 999999))
        user.validation_code = validation_code
        db.session.commit()

        send_validation_code(user.phone, validation_code)
        return jsonify({"message": "Validation code sent.", "next": "/validate"}), 200
    else:
        return jsonify({"message": "Invalid credentials."}), 401

@app.route('/send-validation-code', methods=['POST'])
def send_code():
    data = request.json
    username_or_email = data.get('username_or_email')

    user = User.query.filter((User.username == username_or_email) | (User.email == username_or_email)).first()

    if user:
        validation_code = str(randint(100000, 999999))
        user.validation_code = validation_code
        db.session.commit()

        send_validation_code(user.phone, validation_code)
        return jsonify({"message": "Validation code sent."}), 200
    return jsonify({"message": "User not found."}), 404

@app.route('/verify-code', methods=['POST'])
def verify_code():
    data = request.json
    username_or_email = data.get('username_or_email')
    code = data.get('code')

    user = User.query.filter((User.username == username_or_email) | (User.email == username_or_email)).first()

    if user and user.validation_code == code:
        user.validation_code = None
        db.session.commit()
        return jsonify({"message": "Validation successful.", "next": "/home"}), 200
    return jsonify({"message": "Invalid code."}), 400

@app.route('/forgot-password', methods=['POST'])
def forgot_password():
    data = request.json
    email = data.get('email')

    user = User.query.filter_by(email=email).first()

    if user:
        validation_code = str(randint(100000, 999999))
        user.validation_code = validation_code
        db.session.commit()

        send_validation_code(user.email, validation_code)
        return jsonify({"message": "Validation code sent."}), 200
    return jsonify({"message": "Email not found."}), 404

@app.route('/reset-password', methods=['POST'])
def reset_password():
    data = request.json
    email = data.get('email')
    code = data.get('code')
    new_password = data.get('new_password')

    user = User.query.filter_by(email=email).first()

    if user and user.validation_code == code:
        user.password = generate_password_hash(new_password)
        user.validation_code = None
        db.session.commit()
        return jsonify({"message": "Password reset successful.", "next": "/login"}), 200
    return jsonify({"message": "Invalid code or email."}), 400

if __name__ == '__main__':
    with app.app_context():
        db.create_all()  # Ensure tables are created
    app.run(debug=True)