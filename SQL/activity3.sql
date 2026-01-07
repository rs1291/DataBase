CREATE TABLE Salesman (
    Salesman_ID TEXT PRIMARY KEY,
    Salesman_Name TEXT,
    Commission REAL,
    City TEXT
);

INSERT INTO Salesman (Salesman_ID, Salesman_Name, Commission, City) VALUES
('SM1', 'Johnson', 0.15, 'New York'),
('SM2', 'Williams', 0.10, 'Los Angeles'),
('SM3', 'Brown', 0.20, 'Chicago'),
('SM4', 'Jones', 0.12, 'Houston'),
('SM5', 'Garcia', 0.18, 'Phoenix');

SELECT * FROM Salesman;

CREATE TABLE IF NOT EXISTS Orders (
    ord_no TEXT PRIMARY KEY,
    purch_amt TEXT,
    ord_date TEXT,
    costumer_id TEXT,
    salesman_id TEXT,
    FOREIGN KEY (salesman_id) REFERENCES Salesman(Salesman_ID)
);

INSERT INTO Orders (ord_no, purch_amt, ord_date, costumer_id, salesman_id) VALUES
('O1', '250.00', '2024-01-15', 'C1', 'SM1'),
('O2', '450.00', '2024-02-20', 'C2', 'SM2'),
('O3', '300.00', '2024-03-10', 'C3', 'SM3'),
('O4', '150.00', '2024-04-05', 'C4', 'SM4'),
('O5', '500.00', '2024-05-25', 'C5', 'SM5');
SELECT * FROM Orders;

SELECT * FROM Orders
WHERE Salesman_id= (SELECT Salesman_ID FROM Salesman WHERE city='London');

CREATE TABLE IF NOT EXISTS Salesman (
    Salesman_ID TEXT PRIMARY KEY,
    Salesman_Name TEXT,
    Commission REAL,
    City TEXT
);

CREATE TABLE IF NOT EXISTS Orders (
    Order_ID TEXT PRIMARY KEY,
    Order_Amount REAL,
    Order_Date TEXT,
    Salesman_ID TEXT,
    FOREIGN KEY (Salesman_ID) REFERENCES Salesman(Salesman_ID)
);

INSERT INTO Salesman (Salesman_ID, Salesman_Name, Commission, City) VALUES
('SM1', 'Johnson', 0.15, 'New York'),
('SM2', 'Williams', 0.10, 'Los Angeles'),
('SM3', 'Brown', 0.20, 'Chicago'),
('SM4', 'Jones', 0.12, 'Houston'),
('SM5', 'Garcia', 0.18, 'Phoenix');

INSERT INTO Orders (Order_ID, Order_Amount, Order_Date, Salesman_ID) VALUES
('O1', 250.00, '2024-01-15', 'SM1'),
('O2', 450.00, '2024-02-20', 'SM2'),
('O3', 300.00, '2024-03-10', 'SM3'),
('O4', 150.00, '2024-04-05', 'SM4'),
('O5', 500.00, '2024-05-25', 'SM5');

SELECT * FROM Salesman;   

SELECT * FROM Orders;

SELECT * FROM Orders
WHERE Salesman_ID = (SELECT Salesman_ID FROM Salesman WHERE City = 'London');\