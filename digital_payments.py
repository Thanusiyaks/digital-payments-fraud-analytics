import mysql.connector

connection = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Thanusiya",
    database="digital_payments"
)

print("MySQL connection successful!")

connection.close()
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
df = pd.read_csv(
    r"C:\Users\thanu\Downloads\digital_payments_fraud_analytics_1000 (1).csv"
)
print(df.head())
print(df.shape)
print(df.info())
print(df.isnull().sum())
print(df.duplicated().sum())
print(df["Fraud_Flag"].value_counts())
fraud_rate = df["Fraud_Flag"].mean() * 100
print(f"Fraud Rate: {fraud_rate:.2f}%")
fraud_payment = (
    df.groupby("Payment_Method")["Fraud_Flag"]
    .sum()
    .sort_values(ascending=False)
)

print(fraud_payment)
fraud_location = (
    df.groupby("Location")["Fraud_Flag"]
    .sum()
    .sort_values(ascending=False)
)

print(fraud_location)
fraud_device = (
    df.groupby("Device_Type")["Fraud_Flag"]
    .sum()
    .sort_values(ascending=False)
)

print(fraud_device)
fraud_merchant = (
    df.groupby("Merchant_Category")["Fraud_Flag"]
    .sum()
    .sort_values(ascending=False)
)

print(fraud_merchant)
df["Time_Hour"] = df["Transaction_Time"].astype(str).str.split(":").str[0].astype(int)

df["Time_Period"] = pd.cut(
    df["Time_Hour"],
    bins=[-1, 5, 11, 17, 23],
    labels=["Night", "Morning", "Afternoon", "Evening"]
)

fraud_time = (
    df.groupby("Time_Period", observed=False)["Fraud_Flag"]
    .sum()
    .sort_values(ascending=False)
)

print(fraud_time)
fraud_payment.plot(kind="bar")

plt.title("Fraud Transactions by Payment Method")
plt.xlabel("Payment Method")
plt.ylabel("Fraud Transactions")
plt.tight_layout()
plt.show()
fraud_location.plot(kind="bar")

plt.title("Fraud Transactions by Location")
plt.xlabel("Location")
plt.ylabel("Fraud Transactions")
plt.tight_layout()
plt.show()

