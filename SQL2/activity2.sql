IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'PRODUCTS')
CREATE TABLE PRODUCTS(
    PRO_ID TEXT PRIMARY KEY,
    PRO_NAME TEXT,
    PRO_PRICE TEXT,
    PRO_COM TEXT
);
INSERT INTO PRODUCTS (PRO_ID, PRO_NAME, PRO_PRICE, PRO_COM) VALUES
('P1', 'Laptop', '800.00', 'TechCorp'),
('P2', 'Smartphone', '600.00', 'MobileInc'),
('P3', 'Tablet', '300.00', 'GadgetCo'),
('P4', 'Monitor', '200.00', 'DisplayLtd'),
('P5', 'Keyboard', '50.00', 'InputDevices'),
('P6', 'Mouse', '25.00', 'InputDevices');
SELECT pro_name, pro_price
FROM PRODUCTS
WHERE pro_price = (SELECT MAX(pro_price) FROM PRODUCTS); 