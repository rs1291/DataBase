CREATE TABLE IF NOT EXISTS Salesman (
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
    Order_ID TEXT PRIMARY KEY,
    Order_Amount REAL,
    Order_Date TEXT,
    Salesman_ID TEXT,
    FOREIGN KEY (Salesman_ID) REFERENCES Salesman(Salesman_ID)
);