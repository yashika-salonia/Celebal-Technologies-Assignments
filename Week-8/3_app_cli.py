import sqlite3
import pandas as pd
from tabulate import tabulate
import sys

def setup_database():
    conn = sqlite3.connect('ecommerce_analytics.db')
    try:
        pd.read_csv("dataset/clean_customers.csv").to_sql('customers', conn, if_exists='replace', index=False)
        pd.read_csv("dataset/clean_products.csv").to_sql('products', conn, if_exists='replace', index=False)
        pd.read_csv("dataset/clean_orders.csv").to_sql('orders', conn, if_exists='replace', index=False)
    except FileNotFoundError:
        print("Error: Clean CSV files not found. Please run '2_clean_data.py' first.")
        sys.exit(1)
    return conn

def run_query(conn, query, title):
    df = pd.read_sql_query(query, conn)
    if df.empty:
        print(f"\n--- {title} ---\nNo records found.")
    else:
        print(f"\n========== {title} ==========")
        print(tabulate(df, headers='keys', tablefmt='fancy_grid', showindex=False))
        print("=" * (len(title) + 22) + "\n")

def main():
    conn = setup_database()
    
    while True:
        print(" --- E-Commerce Analytics Menu --- ")
        print(" 1. View Revenue Trends")
        print(" 2. View Top VIP Customers (Window Func)")
        print(" 3. View Customer Segmentation")
        print(" 4. View Retention Metrics (Cohort)")
        print(" 5. Exit Program")
        print("-" * 44)
        
        choice = input("👉 Enter your choice (1-5): ")
        
        if choice == '1':
            # 1. Revenue Trends
            sql = """
            SELECT strftime('%Y-%m', o.order_date) as Month, p.category as Category, SUM(p.price * o.quantity) as Revenue
            FROM orders o JOIN products p ON o.product_id = p.product_id
            GROUP BY Month, Category ORDER BY Month DESC, Revenue DESC LIMIT 10;
            """
            run_query(conn, sql, "Monthly Revenue Trends by Category")
            
        elif choice == '2':
            # 2. Window Functions (Assignment Requirement)
            sql = """
            WITH Spend AS (
                SELECT c.customer_name, SUM(p.price * o.quantity) as LTV
                FROM customers c JOIN orders o ON c.customer_id = o.customer_id JOIN products p ON o.product_id = p.product_id
                GROUP BY c.customer_id
            )
            SELECT customer_name, ROUND(LTV, 2) as LTV, RANK() OVER(ORDER BY LTV DESC) as VIP_Rank FROM Spend LIMIT 5;
            """
            run_query(conn, sql, "Top 5 VIP Customers")
            
        elif choice == '3':
            # 3. Customer Segmentation
            sql = """
            SELECT c.customer_name, COUNT(o.order_id) as Orders,
                CASE WHEN COUNT(o.order_id) = 1 THEN 'One-time Buyer' ELSE 'Loyal Customer' END as Segment
            FROM customers c JOIN orders o ON c.customer_id = o.customer_id
            GROUP BY c.customer_id ORDER BY Orders DESC LIMIT 10;
            """
            run_query(conn, sql, "Customer Segmentation")
            
        elif choice == '4':
            # 4. Retention Metrics / Cohort Analysis
            sql = """
            WITH FirstBuy AS (
                SELECT customer_id, MIN(strftime('%Y-%m', order_date)) AS Cohort
                FROM orders GROUP BY customer_id
            ),
            Activity AS (
                SELECT o.customer_id, fp.Cohort, strftime('%Y-%m', o.order_date) AS Active_Month
                FROM orders o JOIN FirstBuy fp ON o.customer_id = fp.customer_id
            )
            SELECT Cohort, Active_Month, COUNT(DISTINCT customer_id) AS Active_Users
            FROM Activity
            GROUP BY Cohort, Active_Month;
            """
            run_query(conn, sql, "Retention Metrics (Cohort Analysis)")
            
        elif choice == '5':
            print("\n--- Exiting Analytics System. Have a great day! ---\n")
            break 
            
        else:
            print("\nInvalid input! Please just type 1, 2, 3, 4, or 5.")

    conn.close()

if __name__ == "__main__":
    main()