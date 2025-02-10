import pandas as pd
import numpy as np
import torch
from transformers import BertTokenizer, BertModel
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics import classification_report
import joblib

# 1. تحميل بيانات التدريب
data_file = "work_exhaustion_responses.csv"  # تأكد من أن الملف موجود بنفس المجلد
df = pd.read_csv(data_file)

# 2. التأكد من تنسيق البيانات الصحيح
df.columns = ["Category", "Keyword", "Response"]

# 3. استخراج النصوص والتصنيفات
X_keywords = df["Keyword"]
X_responses = df["Response"]
y = df["Category"]  # التصنيف (Positive / Negative)

# 4. إنشاء قاموس للكلمات المفتاحية المرتبطة بالتصنيفات
keyword_dict = {}
for category, keyword in zip(y, X_keywords):
    keyword_dict[keyword.lower()] = category  # تخزين التصنيف لكل كلمة مفتاحية

# 5. دمج الكلمات المفتاحية والجمل في نص واحد لكل إدخال
X_combined = X_keywords + " " + X_responses

# 6. استخدام TF-IDF لاستخراج الميزات النصية
tfidf_vectorizer = TfidfVectorizer()
X_tfidf = tfidf_vectorizer.fit_transform(X_combined)

# 7. تحميل نموذج BERT
tokenizer = BertTokenizer.from_pretrained("bert-base-uncased")
model = BertModel.from_pretrained("bert-base-uncased")

def get_bert_embeddings(text):
    """تحويل الجملة إلى تمثيل عددي باستخدام BERT"""
    inputs = tokenizer(text, return_tensors="pt", padding=True, truncation=True, max_length=512)
    with torch.no_grad():
        outputs = model(**inputs)
    return outputs.last_hidden_state.mean(dim=1).squeeze().numpy()

# 8. استخراج ميزات BERT لكل جملة
X_bert = np.array([get_bert_embeddings(text) for text in X_combined])

# 9. دمج ميزات BERT مع ميزات TF-IDF
X_combined_features = np.hstack((X_tfidf.toarray(), X_bert))

# 10. تقسيم البيانات إلى مجموعة تدريب واختبار
X_train, X_test, y_train, y_test = train_test_split(X_combined_features, y, test_size=0.2, random_state=42, stratify=y)

# 11. تدريب نموذج Random Forest
classifier = RandomForestClassifier(n_estimators=500, max_depth=50, min_samples_split=3, random_state=42, class_weight="balanced")
classifier.fit(X_train, y_train)

# 12. تقييم النموذج
y_pred = classifier.predict(X_test)
print("\nClassification Report:")
print(classification_report(y_test, y_pred))

# 13. حفظ النموذج والمدخلات المستخدمة
joblib.dump(classifier, "random_forest_model_tfidf_bert.pkl")
joblib.dump(tfidf_vectorizer, "tfidf_vectorizer.pkl")
joblib.dump(keyword_dict, "keyword_dict.pkl")
joblib.dump(tokenizer, "bert_tokenizer.pkl")
joblib.dump(model, "bert_model.pkl")

print("✅ تم تدريب النموذج بنجاح باستخدام TF-IDF + BERT + Random Forest!")
