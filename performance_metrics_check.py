from sklearn.metrics import classification_report, confusion_matrix
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.datasets import make_classification

# إنشاء بيانات عشوائية
X, y = make_classification(n_samples=100, n_features=5, random_state=42)

# تقسيم البيانات إلى تدريب واختبار
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# إنشاء نموذج الغابة العشوائية وتدريبه
model = RandomForestClassifier(n_estimators=100, random_state=42)
model.fit(X_train, y_train)

# التنبؤ على بيانات الاختبار
y_test_pred = model.predict(X_test)

# طباعة تقرير الأداء
print("Classification Report:\n", classification_report(y_test, y_test_pred))

# طباعة مصفوفة التشابك
print("Confusion Matrix:\n", confusion_matrix(y_test, y_test_pred))
