/*CREATING TABLES*/

CREATE TABLE Buyer(
buyer_id CHAR(10) PRIMARY KEY NOT NULL,
name VARCHAR(50) NOT NULL,
email VARCHAR(100) CHECK(email LIKE '%@gmail.com%'),
password CHAR(30) CHECK (LEN(password) = 12),
address VARCHAR(100),
phone INT CHECK (dbo.PhoneNumberValidation(phone) = 1),
shipping_address VARCHAR(100)
);

CREATE TABLE Item(
item_no CHAR(10) PRIMARY KEY,
title VARCHAR(50) NOT NULL,
description VARCHAR(200) NOT NULL,
start_bid_price DECIMAL(10,2) NOT NULL,
increment DECIMAL(10,2),
start_date DATE ,
end_date DATE,
Cat_Id CHAR(10) NOT NULL,
CONSTRAINT ITEM_FK FOREIGN KEY (Cat_Id) REFERENCES Category_1(Cat_ID)
);

CREATE TABLE bid(
item_no CHAR(10) NOT NULL,
buyer_id CHAR(10) NOT NULL,
price DECIMAL(10,2) NOT NULL,
time DATETIME NOT NULL,
CONSTRAINT bid_PK PRIMARY KEY (item_no, buyer_id),
CONSTRAINT bid_FK1 FOREIGN KEY (item_no) REFERENCES Item(item_no),
CONSTRAINT bid_FK2 FOREIGN KEY (buyer_id) REFERENCES Buyer(buyer_id)
);

CREATE TABLE Seller( 
seller_id char(10) PRIMARY KEY,
email varchar(30),
seller_name varchar(50),
phone char(10),
address varchar(100),
password char(10) check (dbo.ValidatePassword(password)=1),
route_num char(10)
);

CREATE TABLE place( 
seller_id char(10),
item_no char(10)
CONSTRAINT place_pk PRIMARY KEY (seller_id,item_no),
CONSTRAINT place_fk2 FOREIGN KEY(item_no) REFERENCES Item(item_no),
CONSTRAINT place_fk1 FOREIGN KEY(seller_id) REFERENCES Seller(seller_id)
);

CREATE TABLE Bank_1 
(
	Bank_No char(10) NOT NULL,
	Acc_name varchar(50) NOT NULL,
	Branch_name varchar(50),
	Bank_name varchar(100),
	CONSTRAINT Bank_PK1 PRIMARY KEY(Bank_No),
);


CREATE TABLE Account_1 
(
	Acc_ID char(10) NOT NULL,
	Bank_No char (10) NOT NULL,
	Acc_name varchar(50) NOT NULL,
	Balance decimal(10,2) CHECK (Balance >= 0),
	buyer_ID char(10),
	seller_ID char(10),
	CONSTRAINT Account_PK1 PRIMARY KEY(Acc_ID),
	CONSTRAINT Account_FK11 FOREIGN KEY(buyer_ID) REFERENCES Buyer(buyer_id),
	CONSTRAINT Account_FK12 FOREIGN KEY(seller_ID) REFERENCES Seller(seller_id)
);


CREATE TABLE Category_1 
(
	Cat_ID char(10) NOT NULL,
	Cat_description varchar(200),
	CONSTRAINT Category_PK PRIMARY KEY(Cat_ID)
);

CREATE TABLE winner(
highest_bid DECIMAL(10, 2) PRIMARY KEY,
);

CREATE TABLE Transaction_(
seller_id CHAR(10),
buyer_id CHAR(10),
highest_bid DECIMAL(10, 2),
t_date DATE,
credit_account CHAR(10),
debit_account CHAR(10),
CONSTRAINT transaction_PK11 PRIMARY KEY (highest_bid, seller_id, buyer_id),
CONSTRAINT transaction_FK11 FOREIGN KEY (highest_bid) REFERENCES winner(highest_bid),
CONSTRAINT transaction_FK12 FOREIGN KEY (seller_id) REFERENCES seller(seller_id),
CONSTRAINT transaction_FK13 FOREIGN KEY (buyer_id) REFERENCES Buyer(buyer_id)
);

/*FUNCTIONS*/

/*Created fucntion for check the phone number that entere*/

CREATE FUNCTION PhoneNumberValidation (@phone INT)
RETURNS INT
AS
BEGIN
	DECLARE @pcount VARCHAR(20)
	DECLARE @result INT

	SET @pcount = CAST(@phone AS VARCHAR(20)); /*CAST: changes the data type*/
	SET @result = 0;

	IF LEN(@pcount) = 9 AND @pcount NOT LIKE '%[^0-9]%'
		SET @result = 1;
	
	RETURN @result;
		
END;

/*Drop the function*/
DROP FUNCTION PhoneNumberValidation

/*Created a function to check the password is validated*/
CREATE FUNCTION ValidatePassword(@password VARCHAR(10))
RETURNS char(10)
AS
BEGIN
    DECLARE @validp int=1;

    -- Check minimum length
    IF LEN(@password) < 10
        SET @validp = 0;

    -- Check for at least one uppercase letter
    IF @validp = 1 AND @password NOT LIKE '%[A-Z]%'
        SET @validp = 0;

    -- Check for at least one lowercase letter
    IF @validp = 1 AND @password NOT LIKE '%[a-z]%'
        SET @validp = 0;

    -- Check for at least one digit
    IF @validp = 1 AND @password NOT LIKE '%[0-9]%'
        SET @validp = 0;

    -- Check for at least one special character
    IF @validp = 1 AND @password NOT LIKE '%[^A-Za-z0-9]%'
        SET @validp = 0;

    RETURN @validp;
END;

/*Drop the function*/
DROP FUNCTION ValidatePassword


/*INSERTING DATA*/

INSERT INTO Buyer VALUES ('BYR001', 'Shenal Mario', 'shenalmario96@gmail.com', 'Aybk@334Op##', '101/58 Vihara Rd, Kaduwela.', 778349914, '101/58 Vihara Rd, Kaduwela.');
INSERT INTO Buyer VALUES ('BYR002', 'Lahiru Mihiranga', 'lahiru001mihiranga@gmail.com', 'YggUkfT01@44', '202/5 river Rd, Katunayaka.', 765323524, '202/5 river Rd, Katunayaka.');
INSERT INTO Buyer VALUES ('BYR003', 'Ama Perera', 'amaperera03@gmail.com', '14BujOama@03', '23/10 Madawachchiya, Kiribathgoda.', 751186604, '23/10 Madawachchiya, Kiribathgoda.');
INSERT INTO Buyer VALUES ('BYR004', 'Sithara Sewmini', 'shenalmario96@gmail.com', 'Dk88@33&$hkB', '33/6 Athul Rd, Nawagamuwa.', 771072628, '33/6 Athul Rd, Nawagamuwa.');
INSERT INTO Buyer VALUES ('BYR005', 'Saman Aloka', 'saman33@gmail.com', 'AFT23@44PqTT', '26/155 Katunayake, East.', 779966582, '26/155 Katunayake, East.');

INSERT INTO Item VALUES ('ITM001', 'Wrist Watch', 'A unique handamde luxury wrist watch.', 25000.00, 5000.00, '2023-08-23', '2023-09-17', 'Cat003');
INSERT INTO Item VALUES ('ITM002', 'Leather Wallet', 'A unique handamde rich looking genuine leather wallet.', 9400.00, 1800.00, '2023-08-24', '2023-09-11', 'Cat003');
INSERT INTO Item VALUES ('ITM003', 'Headset', 'Branded full feature super cool headset', 12500.00, 1000.00, '2023-08-23', '2023-09-17', 'Cat001');
INSERT INTO Item VALUES ('ITM004', 'MSI Laptop', 'Brand New user friendly extreme performance laptop with high performance.', 297000.00, 10000.00, '2023-08-23', '2023-09-23', 'Cat001');
INSERT INTO Item VALUES ('ITM005', 'ASUS Laptop', 'Brand New user friendly full feature laptop with high performance.', 295000.00, 14000.00, '2023-09-23', '2023-10-23', 'Cat001');

INSERT INTO bid VALUES ('ITM001', 'BYR001', 30000.00, '12:15:55');
INSERT INTO bid VALUES ('ITM002', 'BYR002', 10000.00, '16:35:23');
INSERT INTO bid VALUES ('ITM003', 'BYR003', 13500.00, '18:05:05');
INSERT INTO bid VALUES ('ITM004', 'BYR004', 307000.00, '21:53:43');
INSERT INTO bid VALUES ('ITM005', 'BYR005', 302000.00, '23:55:31');

INSERT Seller(seller_id,email,seller_name,phone,address,password,route_num ) VALUES('SLR001','adhithi_s23@gmail.com','Adhithi samaranayake','0777320752','83/2,bhathiya mawatha,pamunuwila,gonawala,kelaniya.','adhithi1.#','RN001');
INSERT Seller(seller_id,email,seller_name,phone,address,password,route_num ) VALUES('SLR002','agranir@gmail.com','Agrani ranaweera','0743529714','321a,Janadhipathi Mawatha,Colombo 1,Sri Lanka.','aGrAn.#I11','RN002');
INSERT Seller(seller_id,email,seller_name,phone,address,password,route_num ) VALUES('SLR003','pdniry12@gmail.com','Daniru ekanayake','0761535714','380/5,ihala bomiliya,kaduwela','xx1235m.#1','RN003');
INSERT Seller(seller_id,email,seller_name,phone,address,password,route_num ) VALUES('SLR004','hkenula12@gmail.com','Kenula hewage','0772545931','280/2,lawulugahawatte,karagoda uyangoda.','kenula123$','RN004');
INSERT Seller(seller_id,email,seller_name,phone,address,password,route_num ) VALUES('SLR005','shdileka@gmail.com','Dileka rajapaksha','0751186604','2B,pahala biyanwila,kadawatha.','dilekash1%','RN005');

INSERT INTO place VALUES ('SLR001','ITM001');
INSERT INTO place VALUES ('SLR002','ITM002');
INSERT INTO place VALUES ('SLR003','ITM003');
INSERT INTO place VALUES ('SLR004','ITM004');
INSERT INTO place VALUES ('SLR005','ITM005');

insert into Account_1 values('Acc1122','BNK112233','Shenal Mario', 50000.00, 'BYR001', NULL) 
insert into Account_1 values('Acc6622','BNK334455','Lahiru Mihiranga', 25000.00, 'BYR002', NULL)
insert into Account_1 values('Acc9988','BNK556677','Adhithi samaranayake', 30000.00, NULL,'SLR001')
insert into Account_1 values('Acc4455','BNK778899','Daniru ekanayake', 400000.00, NULL,'SLR003')
insert into Account_1 values('Acc2233','BNK446688','Saman Aloka', 500000.00,'BYR005',NULL)

insert into Category_1 values('Cat001','Electronic items are diverse,powered by electricity, and include gadgets like smartphones,laptops,appliances,and entertainment devices.Integral to modern life.') 
insert into Category_1 values('Cat002','Accessories are supplementary items enhancing functionality or aesthetics, often used with electronic gadgets, fashion,or vehicles, offering personalization and utility.')
insert into Category_1 values('Cat003','Clothes are garment that individuals wear for protection,comfort and style.They include various clothing items like shirts,pants,dresses and more.')
insert into Category_1 values('Cat004','Beauty items encompass cosmetics, skincare products,and grooming tools.They enhance apperance,hygiene and confidence,contributing to personal care aesthetics.')
insert into Category_1 values('Cat005','Home and garden:transform your space with our exquisite outdoor furniture. Enhance your interior with elegant decore pieces.')

insert into Bank_1 values('BNK112233','Shenal Mario','Kaduwela branch','Peoples bank') 
insert into Bank_1 values('BNK334455','Lahiru Mihiranga','Katunayake branch','Sampath bank')
insert into Bank_1 values('BNK556677','Adhithi samaranayake','Kiribathgoda branch','Sampath bank')
insert into Bank_1 values('BNK778899','Daniru ekanayake','Kaduwela branch','DFCC bank')
insert into Bank_1 values('BNK446688','Saman Aloka','Katunayake branch','DFCC bank')

INSERT INTO winner VALUES ('30000')
INSERT INTO winner VALUES ('10000')
INSERT INTO winner VALUES ('13500')
INSERT INTO winner VALUES ('307000')
INSERT INTO winner VALUES ('302000')

INSERT INTO Transaction_ VALUES ('SLR001','BYR001','30000','02:03:23','CA001','DA002')
INSERT INTO Transaction_ VALUES ('SLR002','BYR002','10000','12:06:23','CA003','DA006')
INSERT INTO Transaction_  VALUES ('SLR003','BYR003','13500','18:06:23','CA005','DA004')
INSERT INTO Transaction_  VALUES ('SLR004','BYR004','307000','10:10:23','CA007','DA010')
INSERT INTO Transaction_  VALUES ('SLR005','BYR005','302000','23:10:23','CA009','DA008')

/*SELECTING DATA TO CHECK*/

SELECT * FROM Buyer
SELECT * FROM Item
SELECT * FROM bid
SELECT * FROM Seller
SELECT * FROM place
SELECT * FROM Account_1 
SELECT * FROM Bank_1
SELECT * FROM Category_1
SELECT * FROM winner
SELECT * FROM Transaction_

SELECT item_no, buyer_id, price, CONVERT(VARCHAR(8), time, 108) AS formatted_time
FROM bid;
/*TIME FORMAT- 108: HH:mm:ss*/


/*DROP TABLES*/

DROP TABLE Buyer
DROP TABLE Item
DROP TABLE bid
DROP TABLE Seller
DROP TABLE place
DROP TABLE Account_1
DROP TABLE Bank_1
DROP TABLE Category_1
DROP TABLE winner
DROP TABLE Transaction_

/*STORED PROCEDURES*/

/*01*/
CREATE PROCEDURE GetSampathbankMembers
AS
BEGIN
    SELECT B.name AS Names_of_buyers, B.address AS buyer_address
    FROM Buyer B
    WHERE EXISTS (
        SELECT 1
        FROM Account_1 A
        INNER JOIN Bank_1 Bnk ON A.Bank_No = Bnk.Bank_No
        WHERE A.buyer_ID = B.buyer_id 
        AND Bnk.Bank_name = 'Sampath bank'
    );
	 SELECT S.seller_name AS Name_of_sellers, S.address AS seller_address
    FROM Seller S
    WHERE EXISTS (
        SELECT 1
        FROM Account_1 A
        INNER JOIN Bank_1 Bnk ON A.Bank_No = Bnk.Bank_No
        WHERE A.seller_ID = S.seller_id 
        AND Bnk.Bank_name = 'Sampath bank'
    );
END;



/*02*/
CREATE PROCEDURE GetLaptopBids
AS
BEGIN
	SELECT B.name AS MemberName, B.email AS MemberEmail, bd.price AS BidPrice
	FROM Buyer B
	JOIN bid bd ON B.buyer_id = bd.buyer_id
	JOIN Item I ON bd.item_no = I.item_no
	WHERE I.title LIKE '%Laptop'
	ORDER BY bd.price
END


/*03*/

CREATE PROCEDURE getSellerhighestbidSum
AS
BEGIN
	SELECT S.seller_name AS Name_of_seller
	FROM Seller S
	JOIN place p ON S.seller_id = p.seller_id
	JOIN Item I ON p.item_no = I.item_no
	GROUP BY S.seller_name
	HAVING SUM(I.start_bid_price) > 30000.00
END

/*04*/

CREATE PROCEDURE getIncreasedBidBySaman
AS
BEGIN
	DECLARE @increment DECIMAL(5,2) = 1.15;

	UPDATE bid
	SET price = price * @increment
	WHERE buyer_id = 'BYR005'
END

/*To execute these procedures*/

EXEC getIncreasedBidBySaman
EXEC getSellerhighestbidSum
EXEC GetLaptopBids
EXEC GetSampathbankMembers;

/*Deleting procedures*/

DROP PROCEDURE GetSampathbankMembers;
DROP PROCEDURE GetLaptopBids
DROP PROCEDURE getSellerhighestbidSum
DROP PROCEDURE getIncreasedBidBySaman


/*Triggers*/
--01--
/*This trigger checks the buyers bid count per a day and if it exceeds the limit of bids per day it will return an error messege. */

CREATE TRIGGER trgLimitBuyerBidsPerDay
ON bid
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    /* Calculate the current date*/
    DECLARE @CurrentDate DATE;
    SET @CurrentDate = CAST(GETDATE() AS DATE);

    /* Check if any of the inserted rows exceed the daily bid limit */
    IF (
        SELECT COUNT(*) 
        FROM Inserted
        WHERE CAST(CONVERT(DATETIME, time) AS DATE) = @CurrentDate
    ) > 3
    BEGIN
        RAISERROR('Buyer has exceeded the daily bid limit of 3 items.', 16, 1);
    END
END;


/*Insert four bids for buyer BYR002 on the same day and checking whether the trigger is working or not*/

INSERT INTO bid (item_no, buyer_id, price, time)
VALUES
    ('ITM001', 'BYR002', 40000.00, GETDATE()),
    ('ITM005', 'BYR002', 40000.00, GETDATE()),
    ('ITM004', 'BYR002', 40000.00, GETDATE()),
    ('ITM003', 'BYR002', 40000.00, GETDATE());

DROP TABLE bid

DROP TRIGGER trgLimitBuyerBidsPerDay


--02--

/*Create a trigger to check buyer's balance before placing a bid*/

CREATE TRIGGER trgCheckBuyerBalance
ON bid
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    /* Check if the buyer has sufficient balance before placing the bid */
    IF EXISTS (
        SELECT 1
        FROM Inserted I
        JOIN Account_1 A ON I.buyer_id = A.buyer_ID
        WHERE A.Balance >= I.price
    )
    BEGIN
        /* Insert the bid if the buyer has sufficient balance */
        INSERT INTO bid (item_no, buyer_id, price, time)
        SELECT item_no, buyer_id, price, GETDATE()
        FROM Inserted;
    END
    ELSE
    BEGIN
        /* Buyer doesn't have sufficient balance */
        RAISERROR ('Buyer does not have sufficient balance to place the bid.', 16, 1);
        ROLLBACK TRANSACTION; 
    END
END;

/* CHECKING THE TRIGGER */

/* Insert a bid for a buyer with sufficient balance (no errors will occur when you enter these data)*/
INSERT INTO bid (item_no, buyer_id, price, time)
VALUES ('ITM001', 'BYR001', 30000.00, GETDATE());

/* Insert a bid for a buyer with insufficient balance (should raise an error) */
INSERT INTO bid (item_no, buyer_id, price, time)
VALUES ('ITM002', 'BYR002', 50000.00, GETDATE());


/* Deleting the trigger if want to */
DROP TRIGGER trgCheckBuyerBalance


/* CREATING VIEWS */
/* 01 */
/* provide the information about the items placed by the sellers */

CREATE VIEW PDetails AS
SELECT p.seller_name, p.item_no, i.title, i.start_bid_price, i.start_date, i.end_date
FROM place p
JOIN Item i ON p.item_no = i.item_no;


/* 02 */
/* Outputs all the details of the buyer */

CREATE VIEW BDetails AS
SELECT buyer_id, name, email, address, phone
FROM Buyer;



/* CREATING INDEXES */

CREATE INDEX index_ItemTitleSearch ON Item(title);
CREATE INDEX indexAccBalSearch ON Account_1(Balance);