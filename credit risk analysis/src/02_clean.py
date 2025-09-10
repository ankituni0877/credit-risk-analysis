import pandas as pd

# Load raw dataset
df = pd.read_csv("data/raw/credit_risk_dataset.csv")

# -----------------
# 1. Handle missing values
# -----------------
print("Missing values before:\n", df.isnull().sum())

# Example: fill numeric nulls with median, categorical with mode
for col in df.columns:
    if df[col].dtype in ['float64', 'int64']:
        df[col] = df[col].fillna(df[col].median())
    else:
        df[col] = df[col].fillna(df[col].mode()[0])

# -----------------
# 2. Fix data types
# -----------------
# Convert date columns if any
if "issue_date" in df.columns:
    df["issue_date"] = pd.to_datetime(df["issue_date"], errors="coerce")

# -----------------
# 3. Remove duplicates
# -----------------
df = df.drop_duplicates()

# -----------------
# 4. Save cleaned dataset
# -----------------
df.to_csv("data/processed/credit_risk_cleaned.csv", index=False)

print("✅ Cleaning complete. Cleaned dataset saved at data/processed/credit_risk_cleaned.csv")
