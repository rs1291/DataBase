/* =========================================================
   1) TABLES
   ========================================================= */

-- Customers
CREATE TABLE customers (
  customer_id   INT PRIMARY KEY,
  customer_name VARCHAR(100) NOT NULL,
  email         VARCHAR(120),
  phone         VARCHAR(30)
);

-- Products
CREATE TABLE products (
  product_id    INT PRIMARY KEY,
  product_name  VARCHAR(120) NOT NULL,
  category      VARCHAR(80),
  unit_price    DECIMAL(10,2) NOT NULL
);

-- Countries (export destinations)
CREATE TABLE countries (
  country_id    INT PRIMARY KEY,
  country_name  VARCHAR(100) NOT NULL,
  iso_code      VARCHAR(3)
);

-- Orders (customer purchases)
CREATE TABLE orders (
  order_id      INT PRIMARY KEY,
  customer_id   INT NOT NULL,
  order_date    DATE NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Order items (products in each order)
CREATE TABLE order_items (
  order_id      INT NOT NULL,
  product_id    INT NOT NULL,
  quantity      INT NOT NULL,
  unit_price    DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (order_id, product_id),
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Export mapping (which countries an order is exported to)
CREATE TABLE order_exports (
  order_id     INT NOT NULL,
  country_id   INT NOT NULL,
  PRIMARY KEY (order_id, country_id),
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (country_id) REFERENCES countries(country_id)
);


/* =========================================================
   2) FINAL JOIN QUERY (Harish’s requirement)
   Customers whose name starts with 'a' and contains 'or',
   plus product details and export country details
   ========================================================= */

SELECT
  c.customer_id,
  c.customer_name,
  o.order_id,
  o.order_date,
  p.product_id,
  p.product_name,
  p.category,
  oi.quantity,
  oi.unit_price,
  (oi.quantity * oi.unit_price) AS line_total,
  co.country_name AS exported_to
FROM customers c
JOIN orders o
  ON o.customer_id = c.customer_id
JOIN order_items oi
  ON oi.order_id = o.order_id
JOIN products p
  ON p.product_id = oi.product_id
JOIN order_exports oe
  ON oe.order_id = o.order_id
JOIN countries co
  ON co.country_id = oe.country_id
WHERE LOWER(c.customer_name) LIKE 'a%'
  AND LOWER(c.customer_name) LIKE '%or%'
ORDER BY c.customer_name, o.order_date, o.order_id, p.product_name, co.country_name;