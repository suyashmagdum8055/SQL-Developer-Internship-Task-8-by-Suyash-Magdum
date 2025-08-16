USE ECommerceDB;

-- 1. Stored Procedure: Get all orders of a customer
DELIMITER //
CREATE PROCEDURE GetCustomerOrders(IN cust_id INT)
BEGIN
    SELECT o.OrderID, o.OrderDate, o.TotalAmount
    FROM Orders o
    WHERE o.CustomerID = cust_id;
END //
DELIMITER ;

-- Usage:
CALL GetCustomerOrders(1);


-- 2. Stored Procedure: Insert a new customer
DELIMITER //
CREATE PROCEDURE AddCustomer(
    IN cust_name VARCHAR(100),
    IN cust_email VARCHAR(100),
    IN cust_phone VARCHAR(15),
    IN cust_address TEXT
)
BEGIN
    INSERT INTO Customer(Name, Email, Phone, Address)
    VALUES (cust_name, cust_email, cust_phone, cust_address);
END //
DELIMITER ;

-- Usage:
CALL AddCustomer('Ravi Kumar', 'ravi@example.com', '9876543211', 'Delhi');


-- 3. User-Defined Function: Get total spent by a customer
DELIMITER //
CREATE FUNCTION GetTotalSpent(cust_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_spent DECIMAL(10,2);
    SELECT SUM(TotalAmount) INTO total_spent
    FROM Orders
    WHERE CustomerID = cust_id;
    RETURN IFNULL(total_spent, 0);
END //
DELIMITER ;

-- Usage:
SELECT GetTotalSpent(1) AS Total_Spent_By_Customer;


-- 4. User-Defined Function: Get order count for a customer
DELIMITER //
CREATE FUNCTION GetOrderCount(cust_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE order_count INT;
    SELECT COUNT(*) INTO order_count
    FROM Orders
    WHERE CustomerID = cust_id;
    RETURN order_count;
END //
DELIMITER ;

-- Usage:
SELECT GetOrderCount(1) AS Orders_Placed;

