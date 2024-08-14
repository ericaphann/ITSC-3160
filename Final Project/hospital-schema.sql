DROP DATABASE IF EXISTS hospital;
CREATE DATABASE hospital;
USE hospital;

DROP TABLE IF EXISTS Room;
DROP TABLE IF EXISTS Person;
DROP TABLE IF EXISTS Patient;
DROP TABLE IF EXISTS Nurse;
DROP TABLE IF EXISTS Doctor;
DROP TABLE IF EXISTS Health_Record;
DROP TABLE IF EXISTS Instruction;
DROP TABLE IF EXISTS Instruction_Order;
DROP TABLE IF EXISTS Instruction_Performed;
DROP TABLE IF EXISTS Medicine;
DROP TABLE IF EXISTS Medication;
DROP TABLE IF EXISTS Invoice;
DROP TABLE IF EXISTS Payment;

CREATE TABLE Room(
	room_num VARCHAR(50) NOT NULL,
    capacity VARCHAR(50) NOT NULL,
    fee VARCHAR(50) NOT NULL,
    PRIMARY KEY (room_num)
);

CREATE TABLE Person(
	ID VARCHAR(50) NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Address VARCHAR(50) NOT NULL,
    Phone_Number VARCHAR(50) NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE Patient(
	Patient_ID VARCHAR(50) NOT NULL,
    RoomNum VARCHAR(50) NOT NULL,
    Days_Hospitalized VARCHAR(50) NOT NULL,
    PRIMARY KEY (Patient_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Person(ID),
    FOREIGN KEY (RoomNum) REFERENCES Room(Room_Num)
);

CREATE TABLE Nurse(
	Nurse_ID VARCHAR(50) NOT NULL,
    Nurse_Cert_Num VARCHAR(50) NOT NULL,
    PRIMARY KEY (Nurse_ID),
    FOREIGN KEY (Nurse_ID) REFERENCES Person(ID)
);

CREATE TABLE Doctor(
	Doctor_ID VARCHAR(50) NOT NULL,
    Field_of_Expertise VARCHAR(50) NOT NULL,
    Doctor_Cert_Num VARCHAR(50) NOT NULL,
    PRIMARY KEY (Doctor_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Person(ID)
);

CREATE TABLE Health_Record(
	Health_ID VARCHAR(50) NOT NULL,
    Health_Date VARCHAR(50) NOT NULL,
    Health_Status VARCHAR(50) NOT NULL,
    Health_Description VARCHAR(50) NOT NULL,
    Health_Disease VARCHAR(50) NOT NULL,
    PRIMARY KEY (Health_ID, Health_Date, Health_Disease),
    FOREIGN KEY (Health_ID) REFERENCES Patient(Patient_ID)
);

CREATE TABLE Instruction(
	Instruc_Code VARCHAR(50) NOT NULL,
    Instruc_Description VARCHAR(50) NOT NULL,
    Instruc_Fee VARCHAR(50) NOT NULL,
    Instruc_Date VARCHAR(50) NOT NULL,
    Instruc_Patient_ID VARCHAR(50) NOT NULL,
    PRIMARY KEY (Instruc_Code),
    FOREIGN KEY	(Instruc_Patient_ID) REFERENCES Patient(Patient_ID)
);

CREATE TABLE Instruction_Order(
	Order_Doctor_ID VARCHAR(50) NOT NULL,
    Order_Code VARCHAR(50) NOT NULL,
    PRIMARY KEY (Order_Doctor_ID, Order_Code),
    FOREIGN KEY (Order_Doctor_ID) REFERENCES Doctor(Doctor_ID),
    FOREIGN KEY (Order_Code) REFERENCES Instruction(Instruc_Code)
);
  
CREATE TABLE Instruction_Performed(
	Perform_Nurse_ID VARCHAR(50) NOT NULL,
    Perform_Code VARCHAR(50) NOT NULL,
    Perform_Status VARCHAR(50) NOT NULL,
    PRIMARY KEY (Perform_Nurse_ID, Perform_Code),
    FOREIGN KEY (Perform_Nurse_ID) REFERENCES Nurse(Nurse_ID),
    FOREIGN KEY (Perform_Code) REFERENCES Instruction(Instruc_Code)
);

CREATE TABLE Medicine(
	Medicine_Name VARCHAR(50) NOT NULL,
    PRIMARY KEY (Medicine_Name)
);

CREATE TABLE Medication(
	Medication_ID VARCHAR(50) NOT NULL,
    Medication_Name VARCHAR(50) NOT NULL,
    M_Patient_ID VARCHAR(50) NOT NULL,
    M_Nurse_ID VARCHAR(50) NOT NULL,
    Medication_Type VARCHAR(50) NOT NULL,
    Dosage VARCHAR(50) NOT NULL,
    PRIMARY KEY (Medication_ID),
    FOREIGN KEY (Medication_Name) REFERENCES Medicine(Medicine_Name),
    FOREIGN KEY (M_Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (M_Nurse_ID) REFERENCES Nurse(Nurse_ID)
);

CREATE TABLE Invoice(
	Invoice_ID VARCHAR(50) NOT NULL,
    I_Patient_ID VARCHAR(50) NOT NULL,
    Status VARCHAR(50) NOT NULL,
    PRIMARY KEY (Invoice_ID),
    FOREIGN KEY (I_Patient_ID) REFERENCES Patient(Patient_ID)
);

CREATE TABLE Payment(
	Payment_ID VARCHAR(50) NOT NULL,
    P_Invoice_ID VARCHAR(50) NOT NULL,
    Payment_Date VARCHAR(50) NOT NULL,
    Amount VARCHAR(50) NOT NULL,
    PRIMARY KEY (Payment_ID),
    FOREIGN KEY (P_Invoice_ID) REFERENCES Invoice(Invoice_ID)
);
