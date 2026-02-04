CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50),
    grade INT
);

INSERT INTO customers (customer_id, customer_name, city, grade) VALUES
(1, 'John', 'New York', 120),
(2, 'Alice', 'New York', 90),
(3, 'Bob', 'Chicago', 110),
(4, 'Emma', 'Boston', 95),
(5, 'Mike', 'New York', 130),
(6, 'Sophia', 'Chicago', 80);

SELECT * FROM customers WHERE city = 'New York' OR grade > 100;

SELECT * FROM customers WHERE city = 'NEWYORK' AND grade < 100;