DROP TABLE IF EXISTS Salesman;

CREATE TABLE Salesman(
    Salesman_id TEXT PRIMARY KEY,
    name TEXT,
    city TEXT,
    commission TEXT
);

INSERT INTO Salesman(Salesman_id, name, city, commission)
VALUES
    ("5001","James Hoog","New York",0.15),
    ("5002","Nail Knite","Paris",0.13),
    ("5003","Pit Alex","London",0.11),
    ("5004","Mc Lyon","Paris",0.14),
    ("5005","Paul Adam","Rome",0.13),
    ("5006","Allen Mathews","London",0.12),
    ("5007","Teddy Staton","Paris",0.16);

DROP TABLE IF EXISTS Customer;

CREATE TABLE Customer(
    customer_id TEXT PRIMARY KEY,
    cust_name TEXT,
    city TEXT,
    grade INTEGER,
    Salesman_id TEXT,
    FOREIGN KEY (Salesman_id) REFERENCES Salesman(Salesman_id)
);

INSERT INTO Customer(customer_id, cust_name, city, grade, Salesman_id)
VALUES
    ("3002","Nick Rimando","New York",100,"5001"),
    ("3007","Brad Davis","New York",200,"5001"),
    ("3005","Graham Zusi","California",200,"5002"),
    ("3008","Julian Green","London",300,"5003"),
    ("3004","Fabian Johnson","Paris",300,"5004"),
    ("3009","Geoff Cameron","Berlin",100,"5006"),
    ("3003","Jozy Altidore","Moscow",200,"5005"),
    ("3001","Brad Guzan","London",150,"5003");

DROP TABLE IF EXISTS Orders;

CREATE TABLE Orders(
    ord_no TEXT PRIMARY KEY,
    purch_amt REAL,
    ord_date TEXT,
    customer_id TEXT,
    Salesman_id TEXT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (Salesman_id) REFERENCES Salesman(Salesman_id)
);

INSERT INTO Orders(ord_no, purch_amt, ord_date, customer_id, Salesman_id)
VALUES
    ("70001",150.5,"2012-10-05","3005","5002"),
    ("70009",270.65,"2012-09-10","3001","5003"),
    ("70002",65.26,"2012-10-05","3002","5001"),
    ("70004",110.5,"2012-08-17","3009","5006"),
    ("70007",948.5,"2012-09-10","3005","5005"),
    ("70005",2400.6,"2012-07-27","3007","5004");

-- Queries
-- Matching customers and salesmen by city

SELECT Customer.cust_name, Salesman.name, Salesman.city
FROM Customer
JOIN Salesman ON Customer.city = Salesman.city;

-- Linking customers to their salesmen
SELECT Customer.cust_name, Salesman.name
FROM Customer
JOIN Salesman ON Customer.Salesman_id = Salesman.Salesman_id;

-- Orders where coustomer's city is different from salesman's city
SELECT Orders.ord_no, Customer.cust_name, Orders.customer_id, Orders.Salesman_id
FROM Orders 
JOIN Customer ON Orders.customer_id = Customer.customer_id
JOIN Salesman ON Orders.Salesman_id = Salesman.Salesman_id
WHERE Customer.city <> Salesman.city;

-- All orders with customer names
SELECT Orders.ord_no, Customer.cust_name
FROM Orders
JOIN Customer ON Orders.customer_id = Customer.customer_id;

-- Customers with grades (not NULL)
SELECT cust_name, grade
FROM Customer
WHERE grade IS NOT NULL;

-- Customers with salesmen where commission is between 0.12 and 0.14
SELECT Customer.cust_name AS "Customer",
       Customer.city AS "City",
       Salesman.name AS "Salesman",
       Salesman.commission
FROM Customer
JOIN Salesman ON Customer.Salesman_id = Salesman.Salesman_id
WHERE Salesman.commission BETWEEN 0.12 AND 0.14;

-- Commission for orders where customer grade is 200 or more
SELECT Orders.ord_no, 
        Customer.cust_name,
        Salesman.commission AS "Commission%",
        Orders.purch_amt * Salesman.commission AS "Commission"
FROM Orders
JOIN Customer ON Orders.customer_id = Customer.customer_id
JOIN Salesman ON Orders.Salesman_id = Salesman.Salesman_id
WHERE Customer.grade >= 200;

-- Orders on a specific date
SELECT *
FROM Orders
JOIN Customer ON Orders.customer_id = Customer.customer_id
WHERE Orders.ord_date = "2012-10-05";