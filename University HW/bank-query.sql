DROP DATABASE IF EXISTS Bank;
CREATE DATABASE Bank;
USE Bank;

DROP TABLE IF EXISTS transaction;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS account;


CREATE TABLE customer (
    name VARCHAR(20),
    sex CHAR(1),
    ssn CHAR(9) NOT NULL,
    phone CHAR(15),
    dob DATE,
    address VARCHAR(50),
    PRIMARY KEY(ssn)

);
    
CREATE TABLE account (
    number CHAR(16) UNIQUE NOT NULL,
    open_date DATE,
    type CHAR(20),
    owner_ssn CHAR(9) NOT NULL,
    PRIMARY KEY(number)
    );
    
CREATE TABLE transaction (
    id INT(20) UNIQUE NOT NULL,
    amount DECIMAL(9,2),
    tdate DATE,
    type CHAR(10),
    account_num CHAR(16),
    PRIMARY KEY(id) 
);


INSERT INTO customer VALUE ('John Adam', 'M', '512432341', '(438) 321-2553', '1987-11-15',NULL);
INSERT INTO customer VALUE ('Alexander Felix', 'M', '724432341', '(541) 321-8553', '1991-05-22', NULL);
INSERT INTO customer VALUE ('Andrew William', 'M', '861894272', '(308) 692-1110', '1995-01-04', NULL);
INSERT INTO customer VALUE ('Ana Bert', 'F', '844192241', '(203) 932-7000', '1982-12-07', '23 Boston Post Rd, West Haven, CT 06516');

INSERT INTO account VALUE ('1111222233331441', '2018-12-03', 'Checking', '861894272');
INSERT INTO account VALUE ('2111222233332442', '2019-01-06', 'Saving', '512432341');
INSERT INTO account VALUE ('3111222233333443', '2017-09-22', 'Checking', '844192241');
INSERT INTO account VALUE ('4111222233335444', '2016-04-11', 'Checking', '724432341');
INSERT INTO account VALUE ('5111222233339445', '2018-11-05', 'Saving', '724432341');
INSERT INTO transaction VALUE (1001, 202.50, '2019-08-15', 'Deposit', '5111222233339445');
INSERT INTO transaction VALUE (1002, 100.00, '2019-09-21', 'Deposit','2111222233332442');
INSERT INTO transaction VALUE (1003, 200.00, '2019-09-29', 'Deposit', '2111222233332442');
INSERT INTO transaction VALUE (1004, 50.00, '2019-09-29', 'Deposit', '2111222233332442');
INSERT INTO transaction VALUE (1005, 1000.00, '2019-09-29', 'Deposit','3111222233333443');
INSERT INTO transaction VALUE (1006, -202.50, '2019-08-29', 'Withdraw', '5111222233339445');
INSERT INTO transaction VALUE (1007, 50.00, '2019-09-29', 'Deposit', '2111222233332442');
INSERT INTO transaction VALUE (1008, 50.00, '2019-09-29', 'Deposit', '2111222233332442');
INSERT INTO transaction VALUE (1009, -10.00, '2019-09-26', 'Withdraw', '2111222233332442');
INSERT INTO transaction VALUE (1010, 50.00, '2019-09-29', 'Deposit', '4111222233335444');
INSERT INTO transaction VALUE (1011, 320.00, '2019-09-29', 'Deposit', '5111222233339445');
INSERT INTO transaction VALUE (1012, 50.00, '2019-09-18', 'Deposit', '4111222233335444');
INSERT INTO transaction VALUE (1013, 5000.00, '2019-06-21', 'Deposit', '1111222233331441');
INSERT INTO transaction VALUE (1014, -100.00, '2019-09-02', 'Withdraw', '1111222233331441');
INSERT INTO transaction VALUE (1015, -200.00, '2019-09-08', 'Withdraw', '1111222233331441');

SELECT COUNT(t.type) AS Total_Deposit_Count
FROM transaction t
WHERE type = "Deposit";

SELECT t.amount, t.tdate, t.type
FROM transaction t
WHERE t.account_num = "1111222233331441" and t.tdate >= "2019-09-01" and t.tdate <= "2019-09-30"
ORDER BY t.tdate
;

SELECT SUM(t.amount) AS Balance
FROM transaction t
WHERE t.account_num = "1111222233331441" and t.tdate < "2019-09-01"
;

SELECT c.name, t.amount
FROM customer c
JOIN account a ON a.owner_ssn = c.ssn
JOIN transaction t ON a.number = t.account_num
WHERE t.amount = (
	SELECT MAX(t.amount)
	FROM transaction t
	WHERE t.type = "Deposit"
);

SELECT c.name
FROM customer c
JOIN account a ON a.owner_ssn = c.ssn
WHERE c.sex = "M" and a.type = "Checking"
;

SELECT a.number, a.open_date, a.type, a.owner_ssn
FROM account a
JOIN customer c ON a.owner_ssn = c.ssn
WHERE c.name = "Alexander Felix"
;

SELECT SUM(t.amount) AS Balance, a.number AS Account_Number, a.type
FROM account a
JOIN customer c ON a.owner_ssn = c.ssn
JOIN transaction t ON a.number = t.account_num
WHERE c.name = "Alexander Felix" and a.type = "Checking" 
GROUP BY a.type, a.number
UNION
SELECT SUM(t.amount) AS Balance, a.number AS Account_Number, a.type
FROM account a
JOIN customer c ON a.owner_ssn = c.ssn
JOIN transaction t ON a.number = t.account_num
WHERE c.name = "Alexander Felix" and a.type = "Saving" 
GROUP BY a.type, a.number
;

SELECT c.name AS name_NESTED
FROM customer c
WHERE c.ssn IN (
	SELECT a.owner_ssn
    FROM account a
    WHERE a.number IN (
		SELECT t.account_num
        FROM transaction t
        WHERE t.amount >= 1000
	)
);

SELECT c.name AS name_JOINS
FROM customer c
JOIN account a ON a.owner_ssn = c.ssn
JOIN transaction t ON a.number = t.account_num
WHERE t.amount >= 1000
;

SELECT c.name
FROM customer c
WHERE c.ssn IN (
	SELECT a.owner_ssn
    FROM account a
    WHERE a.number IN (
		SELECT t.account_num
        FROM transaction t
        WHERE t.type = "Deposit"
        GROUP BY t.account_num
        HAVING Count(t.type) >=2
	)
);


