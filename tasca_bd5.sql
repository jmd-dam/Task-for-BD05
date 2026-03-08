/*
 EXERCISE 2  insert payments

*/

INSERT INTO payments (customerNumber, checkNumber, paymentDate, amount)
VALUES (124, 'H123', '2024-02-06', 845.00);

INSERT INTO payments (customerNumber, checkNumber, paymentDate, amount)
VALUES (151, 'H124', '2024-02-07', 70.00);

INSERT INTO payments (customerNumber, checkNumber, paymentDate, amount)
VALUES (112, 'H125', '2024-02-05', 1024.00);

/*
EXERCISE 4 

Remember this : Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE 
 that uses a KEY column To disable safe mode, toggle the option -- in Preferences -> -- SQL Editor and reconnect.
*/
UPDATE orders
SET status      = 'Cancelled',
    shippedDate = CURDATE(),
    comments    = 'Order cancelled due to delay'
WHERE orderDate = '2003-09-28';

/*
EXERCISE 5 
*/
UPDATE products
SET productName = CONCAT(productName, ' (code ', productCode, ')')
WHERE productLine = 'Trains';


/*
 EXERCISE 6 - Increase buyPrice and MSRP 
*/

UPDATE products
SET buyPrice = buyPrice * 1.0002,
    MSRP     = MSRP     * 1.0002
WHERE quantityInStock > 500;

/*
EXERCISE 7 - Delete payments from Patterson's customers
*/

DELETE FROM payments
WHERE customerNumber IN (
    SELECT customerNumber
    FROM   customers
    WHERE  salesRepEmployeeNumber IN (
        SELECT employeeNumber
        FROM   employees
        WHERE  lastName = 'Patterson'
    )
);

/*
EXERCISE 8 - Delete customers from Lisbon with no payments
*/
DELETE FROM customers
WHERE city = 'Lisbon'
  AND customerNumber NOT IN (
      SELECT customerNumber
      FROM   payments
  );

/*
	EXERCISE 9 - Add employes from select
*/
INSERT INTO employees
    (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle)
SELECT
    customerNumber + 2000,
    contactLastName,
    contactFirstName,
    'x0000',
    'new@company.com',
    '1',
    NULL,
    'Sales Rep'
FROM customers;


/*
 EXERCISE 10 - Cancel orders from cElizabeth Lincoln's customers 
 */
 
UPDATE orders
SET status      = 'Cancelled',
    shippedDate = CURDATE(),
    comments    = 'Order cancelled by management'
WHERE customerNumber IN (
    SELECT customerNumber
    FROM   customers
    WHERE  salesRepEmployeeNumber = (
        SELECT salesRepEmployeeNumber
        FROM   customers
        WHERE  contactFirstName = 'Elizabeth'
          AND  contactLastName  = 'Lincoln'
    )
);


