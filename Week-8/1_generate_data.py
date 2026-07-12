import pandas as pd
import numpy as np
from faker import Faker
import random
from datetime import datetime, timedelta

fake = Faker()
Faker.seed(42)
random.seed(42)
np.random.seed(42)

print("Generating messy e-commerce dataset")

# 1. CUSTOMERS
customers_data = [
    {"customer_id": i, 
     "customer_name": fake.name(), 
     "email": fake.email(), 
     "signup_date": fake.date_between(
        start_date="-2y", 
        end_date="today").strftime("%Y-%m-%d")
    } for i in range(1, 81)
]
customers_data.append(customers_data[0].copy()) # Duplicate
customers_data[5]["email"] = None # Null email

# 2. PRODUCTS
categories = ["Electronics", "Clothing", "Home Decor", "Books", "Beauty"]
products_data = [
    {
        "product_id": i, 
        "product_name": fake.word().capitalize() + " " + random.choice(["Pro", "Max", "Lite"]), 
        "category": random.choice(categories), 
        "price": round(random.uniform(15.0, 1200.0), 2)
    } for i in range(1, 31)
]
products_data[4]["price"] = -150.00 # Negative price anomaly

# 3. ORDERS
start_date = datetime.now() - timedelta(days=365)
orders_data = [
    {
        "order_id": i, 
        "customer_id": random.choice([999, 888]) if i in [50, 120] else random.randint(1, 80), 
        "product_id": 555 if i in [30, 210] else random.randint(1, 30), 
        "quantity": random.randint(1, 4), 
        "order_date": (start_date + timedelta(days=random.randint(0, 360))).strftime("%Y-%m-%d %H:%M:%S")
    } for i in range(1, 351)
]
orders_data[200]["order_date"] = (datetime.now() + timedelta(days=45)).strftime("%Y-%m-%d %H:%M:%S") # Future date anomaly

pd.DataFrame(customers_data).to_csv("dataset/customers.csv", index=False)
pd.DataFrame(products_data).to_csv("dataset/products.csv", index=False)
pd.DataFrame(orders_data).to_csv("dataset/orders.csv", index=False)
print("Raw CSV files generated in dataset folder.")