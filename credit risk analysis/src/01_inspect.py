import pandas as pd

# Load dataset from raw folder
df = pd.read_csv("data/raw/credit_risk_dataset.csv")

# Show dataset shape (rows, columns)
print("Shape:", df.shape)

# First 5 rows
print("\nHead:\n", df.head())

# Column data types
print("\nData types:\n", df.dtypes)

# Missing values per column
print("\nMissing values:\n", df.isnull().sum())

# Quick stats (numerical + categorical)
print("\nSummary:\n", df.describe(include='all').transpose())
