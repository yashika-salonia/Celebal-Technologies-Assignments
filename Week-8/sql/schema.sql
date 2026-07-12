CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY, 
    customer_name TEXT, 
    email TEXT, 
    signup_date DATE);

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY, 
    product_name TEXT, 
    category TEXT, 
    price REAL);
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY, 
    customer_id INTEGER, 
    product_id INTEGER, 
    quantity INTEGER, 
    order_date DATETIME, 
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id), 
    FOREIGN KEY(product_id) REFERENCES products(product_id));