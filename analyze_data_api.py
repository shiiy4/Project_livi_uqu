from flask import Flask, request, jsonify
import joblib
import numpy as np
import torch
from transformers import BertTokenizer, BertModel

app = Flask(__name__)

# ✅ تحميل النموذج والمكونات المحفوظة
classifier = joblib.load("random_forest_model_tfidf_bert.pkl")  # نموذج التصنيف الجديد
tfidf_vectorizer = joblib.load("tfidf_vectorizer.pkl")
keyword_dict = joblib.load("keyword_dict.pkl")
tokenizer = joblib.load("bert_tokenizer.pkl")  # تحميل BERT tokenizer
model = joblib.load("bert_model.pkl")  # تحميل BERT model

def get_bert_embeddings(text):
    """تحويل الجملة إلى تمثيل عددي باستخدام BERT"""
    inputs = tokenizer(text, return_tensors="pt", padding=True, truncation=True, max_length=512)
    with torch.no_grad():
        outputs = model(**inputs)
    return outputs.last_hidden_state.mean(dim=1).squeeze().numpy()

def classify_text(text):
    """تصنيف الجملة بناءً على الكلمات المفتاحية أو باستخدام TF-IDF + BERT"""
    words = text.lower().split()
    
    # ✅ البحث عن الكلمات المفتاحية في الجملة
    detected_categories = [keyword_dict[word] for word in words if word in keyword_dict]

    if detected_categories:
        # إذا تم العثور على كلمات مفتاحية، يتم التصنيف بناءً على أكثر الكلمات تكرارًا
        prediction = max(set(detected_categories), key=detected_categories.count)
        return prediction

    # ✅ إذا لم تكن هناك كلمات مفتاحية، نستخدم TF-IDF + BERT مع النموذج المدرب
    X_tfidf = tfidf_vectorizer.transform([text]).toarray()  # استخراج ميزات TF-IDF
    X_bert = get_bert_embeddings(text).reshape(1, -1)  # استخراج ميزات BERT
    X_combined = np.hstack((X_tfidf, X_bert))  # دمج الميزات

    prediction = classifier.predict(X_combined)[0]  # التنبؤ النهائي
    return prediction

@app.route("/analyze", methods=["POST"])
def analyze():
    data = request.json
    user_answers = data.get("answers", [])

    if not user_answers or len(user_answers) != 20:
        return jsonify({"error": "Exactly 20 answers are required"}), 400

    negative_count = 0
    total_answers = len(user_answers)  # عدد الإجابات (يجب أن يكون 20)
    results = []

    for answer in user_answers:
        prediction = classify_text(answer)
        label = "Positive" if prediction == "Positive" else "Negative"
        results.append({"answer": answer, "classification": label})

        if prediction == "Negative":
            negative_count += 1

    # ✅ تحسين طريقة التشخيص بناءً على النسبة وليس العدد فقط
    negative_ratio = negative_count / total_answers  # نسبة الإجابات السلبية

    if negative_ratio <= 0.35:  # 7/20 = 0.35
        diagnosis = "Normal"
    elif 0.36 <= negative_ratio <= 0.50:  # 8/20 إلى 10/20
        diagnosis = "Need Monitoring"
    else:  # 11/20 فأكثر
        diagnosis = "At Risk"

    return jsonify({
        "negative_answers": negative_count,
        "negative_ratio": round(negative_ratio, 2),  # إظهار النسبة المئوية للإجابات السلبية
        "diagnosis": diagnosis,
        "detailed_results": results
    })

if __name__ == "__main__":
    app.run(debug=True)
