import pandas as pd
from datetime import datetime

print("Starting Data Cleaning Process...")

df_cust = pd.read_csv("dataset/customers.csv")
df_prod = pd.read_csv("dataset/products.csv")
df_ord = pd.read_csv("dataset/orders.csv")

# Clean Customers (Duplicates & Nulls)
df_cust = df_cust.drop_duplicates(subset=['customer_id'], keep='first')
df_cust['email'] = df_cust['email'].fillna('no_email@example.com')

# Clean Products (Negative Prices)
df_prod['price'] = df_prod['price'].apply(lambda x: abs(x) if x < 0 else x)
df_prod['category'] = df_prod['category'].fillna('General')

# Clean Orders (Future Dates & Orphan records)
today_str = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
df_ord['order_date'] = df_ord['order_date'].apply(lambda x: min(x, today_str))
df_ord = df_ord[df_ord['customer_id'].isin(df_cust['customer_id'].tolist())]
df_ord = df_ord[df_ord['product_id'].isin(df_prod['product_id'].tolist())]

# Save Clean Data
df_cust.to_csv("dataset/clean_customers.csv", index=False)
df_prod.to_csv("dataset/clean_products.csv", index=False)
df_ord.to_csv("dataset/clean_orders.csv", index=False)
print("Clean data saved in 'dataset/' folder.")