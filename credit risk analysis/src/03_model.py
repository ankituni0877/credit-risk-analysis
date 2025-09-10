# src/model/03_model.py

import pandas as pd
import pickle
import matplotlib.pyplot as plt
import seaborn as sns

from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score, roc_auc_score
from sklearn.pipeline import Pipeline
from sklearn.compose import ColumnTransformer
from sklearn.preprocessing import OneHotEncoder, StandardScaler
from sklearn.ensemble import RandomForestClassifier
from xgboost import XGBClassifier
from sklearn.linear_model import LogisticRegression

# ---------------- LOAD CLEANED DATA ----------------
df = pd.read_csv("data/processed/credit_risk_cleaned.csv")

X = df.drop("loan_status", axis=1)   # features
y = df["loan_status"]                # target

# Train-test split
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42, stratify=y
)

# ---------------- PREPROCESSOR ----------------
numeric_features = X.select_dtypes(include=["int64", "float64"]).columns
categorical_features = X.select_dtypes(include=["object"]).columns

preprocessor = ColumnTransformer(
    transformers=[
        ("num", StandardScaler(), numeric_features),
        ("cat", OneHotEncoder(handle_unknown="ignore"), categorical_features)
    ]
)

# ---------------- HELPER FUNCTION ----------------
def evaluate_model(model, name, results):
    y_pred = model.predict(X_test)
    y_prob = model.predict_proba(X_test)[:, 1] if hasattr(model, "predict_proba") else None

    acc = accuracy_score(y_test, y_pred)
    prec = precision_score(y_test, y_pred, zero_division=0)
    rec = recall_score(y_test, y_pred, zero_division=0)
    f1 = f1_score(y_test, y_pred, zero_division=0)
    roc = roc_auc_score(y_test, y_prob) if y_prob is not None else None

    results.append({
        "Model": name,
        "Accuracy": round(acc, 3),
        "Precision": round(prec, 3),
        "Recall": round(rec, 3),
        "F1-score": round(f1, 3),
        "ROC-AUC": round(roc, 3) if roc else "NA"
    })

# ---------------- MODELS ----------------
models = [
    ("Logistic Regression", LogisticRegression(max_iter=1000)),
    ("Random Forest", RandomForestClassifier(n_estimators=200, random_state=42)),
    ("XGBoost", XGBClassifier(use_label_encoder=False, eval_metric="logloss", random_state=42))
]

results = []
best_model = None
best_score = 0

for name, clf in models:
    pipe = Pipeline(steps=[("preprocessor", preprocessor), ("model", clf)])
    pipe.fit(X_train, y_train)
    evaluate_model(pipe, name, results)

    # Choose best by ROC-AUC
    y_prob = pipe.predict_proba(X_test)[:, 1] if hasattr(pipe, "predict_proba") else None
    roc = roc_auc_score(y_test, y_prob) if y_prob is not None else 0
    if roc > best_score:
        best_score = roc
        best_model = pipe

# ---------------- SAVE BEST MODEL ----------------
with open("src/credit_risk_best_model.pkl", "wb") as f:
    pickle.dump(best_model, f)

print("\n✅ Best model saved to src/credit_risk_best_model.pkl")

# ---------------- SHOW COMPARISON TABLE ----------------
results_df = pd.DataFrame(results)
print("\n📊 Model Comparison:\n", results_df)

# ---------------- VISUALIZE METRICS ----------------
metrics_to_plot = ["Accuracy", "Precision", "Recall", "F1-score", "ROC-AUC"]

plt.figure(figsize=(10, 6))
for metric in metrics_to_plot:
    if metric in results_df.columns:
        sns.barplot(x="Model", y=metric, data=results_df)
        plt.title(f"Model Comparison - {metric}")
        plt.ylabel(metric)
        plt.xlabel("Model")
        plt.ylim(0, 1)
        plt.show()
