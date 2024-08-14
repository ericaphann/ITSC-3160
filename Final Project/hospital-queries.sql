-- Views
-- Patient Info
CREATE VIEW Patient_Info AS
SELECT pat.Patient_ID, per.Name, h.Health_Disease,
	pat.RoomNum, SUM(DISTINCT(i1.Instruc_Fee) + (r.fee*pat.Days_Hospitalized)) AS Fees
FROM Person per
JOIN Patient pat ON per.ID = pat.Patient_ID
JOIN Room r ON r.Room_Num = pat.RoomNum
JOIN Health_Record h ON h.Health_ID = pat.Patient_ID 
JOIN Invoice i ON i.I_Patient_ID = pat.Patient_ID
LEFT JOIN Payment pay ON pay.P_Invoice_ID = i.Invoice_ID
JOIN Instruction i1 ON i1.Instruc_Patient_ID = pat.Patient_ID
GROUP BY pat.Patient_ID, h.Health_Disease, i1.Instruc_Fee;

-- Calling the Patient Information
SELECT *
FROM Patient_Info;

-- Medication Info
CREATE VIEW Medication_Info AS
SELECT per2.name AS Patient, per1.name AS Nurse, m.Medicine_name AS Medicine, med.Dosage 
FROM Medicine m
JOIN Medication med ON med.Medication_Name = m.Medicine_name
JOIN Patient p ON p.Patient_ID = med.M_Patient_ID 
JOIN Nurse n ON n.Nurse_ID = med.M_Nurse_ID
JOIN Person per1 ON per1.ID = n.Nurse_ID 
JOIN Person per2 ON per2.ID = p.Patient_ID;

-- Calling Medicine Information
SELECT *
FROM Medication_Info;

-- Instruction Info
CREATE VIEW Instruction_Info AS
SELECT per1.name AS Patient, per2.name AS Nurse, per3.name AS Doctor, 
	instru.Instruc_Description AS Instructions, 
    perform.Perform_Status AS Status, instru.Instruc_Fee AS Fees
FROM Instruction instru 
JOIN Instruction_Order o ON o.Order_Code = instru.Instruc_Code
JOIN Instruction_Performed perform ON perform.Perform_Code = instru.Instruc_Code
JOIN Patient p ON p.Patient_ID = instru.Instruc_Patient_ID
JOIN Nurse n ON n.Nurse_ID = perform.Perform_Nurse_ID
JOIN Doctor d ON d.Doctor_ID = o.Order_Doctor_ID
JOIN Person per1 ON per1.ID = p.Patient_ID
JOIN Person per2 ON per2.ID = n.Nurse_ID 
JOIN Person per3 ON per3.ID = d.Doctor_ID;

-- Calling Instruction Information
SELECT *
FROM Instruction_Info;

-- Queries

-- Join Queries

-- Shows each patient’s name and ID, as well as information about their room. 
SELECT P.Patient_ID AS ID, Per.Name AS Name, R.room_num AS 'Room Number', 
R.capacity AS 'Room Capacity', R.fee AS 'Room Fee', 
P.Days_Hospitalized AS 'Days Hospitalized'
FROM Patient P
JOIN Room R ON P.RoomNum = R.room_num
JOIN Person Per ON P.Patient_ID = Per.ID;

-- Shows the Invoice of Patients, with the cost and status of it.
SELECT I.Invoice_ID AS Invoice_ID, per1.name AS Patient, 
SUM(i1.Instruc_Fee + (r.fee*p.Days_Hospitalized)) AS Total_Cost,
I.Status, pay.amount AS Amount_Paid
FROM Invoice I
LEFT JOIN Payment pay ON pay.P_Invoice_ID = I.Invoice_ID 
JOIN Patient p ON p.Patient_ID = I.I_Patient_ID
JOIN Room r ON r.Room_Num = p.RoomNum
JOIN Person per1 ON per1.ID = p.Patient_ID
JOIN Instruction i1 ON i1.Instruc_Patient_ID = p.Patient_ID
GROUP BY I.Invoice_ID, pay.Payment_Date, pay.Payment_ID, i1.Instruc_Fee;

-- Breaks down the total amount of money owed by each patient, ordered from highest to lowest.
SELECT 
    per.Name AS Patient_Name,
    SUM(instru.Instruc_Fee) AS 'Instruction Cost',
    SUM(r.fee * pat.Days_Hospitalized) AS 'Total Room Cost',
    SUM(instru.Instruc_Fee) + SUM(r.fee * pat.Days_Hospitalized) AS 'Total Owed'
FROM 
    Person per
JOIN 
    Patient pat ON per.ID = pat.Patient_ID
JOIN 
    Room r ON r.room_num = pat.RoomNum
JOIN 
    Health_Record h ON h.Health_ID = pat.Patient_ID
JOIN 
    Instruction instru ON instru.Instruc_Patient_ID = pat.Patient_ID
GROUP BY 
    per.Name
ORDER BY 
    'Total Owed' DESC;

-- Aggregation Queries

-- The sum of payments each month, and groups them by year and month.
SELECT YEAR(Payment_Date) AS Payment_Year, 
MONTH(Payment_Date) AS Payment_Month, 
SUM(Amount) AS Total_Payment
FROM Payment
GROUP BY YEAR(Payment_Date), MONTH(Payment_Date);

-- Counts the number of payments made by each patient
SELECT 
    p.Name AS 'Patient Name',
    COUNT(*) AS 'Num of Payments'
FROM 
    Payment pm
JOIN 
    Invoice inv ON pm.P_Invoice_ID = inv.Invoice_ID
JOIN 
    Patient pat ON inv.I_Patient_ID = pat.Patient_ID
JOIN 
    Person p ON pat.Patient_ID = p.ID
GROUP BY 
    p.Name
ORDER BY 
    COUNT(*) DESC;


-- Count the amount of Patients, Doctors, and Nurses.
SELECT COUNT(per1.ID) AS Patients, COUNT(per2.ID) AS Nurses, COUNT(per3.ID) AS Doctors
FROM Instruction instru 
JOIN Instruction_Order o ON o.Order_Code = instru.Instruc_Code
JOIN Instruction_Performed perform ON perform.Perform_Code = instru.Instruc_Code
JOIN Patient p ON p.Patient_ID = instru.Instruc_Patient_ID
JOIN Nurse n ON n.Nurse_ID = perform.Perform_Nurse_ID
JOIN Doctor d ON d.Doctor_ID = o.Order_Doctor_ID
JOIN Person per1 ON per1.ID = p.Patient_ID
JOIN Person per2 ON per2.ID = n.Nurse_ID 
JOIN Person per3 ON per3.ID = d.Doctor_ID;

-- Nested Queries

-- Lists all the names of the people who have not fully paid their hospital bill
SELECT Name
FROM Person
WHERE ID IN (
    SELECT I_Patient_ID
    FROM Invoice
    WHERE I_Patient_ID = ID AND Status != 'PAID'
);

-- Lists all the different types of medicines that were administered as medication to patients
SELECT DISTINCT Medicine_Name
FROM Medicine
WHERE Medicine_Name IN (
    SELECT Medication_Name
    FROM Medication
    );

-- Lists the names of the people who have paid 10000 dollars or more.
SELECT name 
FROM Person
WHERE ID IN (
	SELECT I_Patient_ID
    FROM Invoice
    WHERE Invoice_ID IN (
		SELECT P_Invoice_ID
        FROM Payment
        WHERE amount >= 10000
	)
);

-- Other Queries

-- Lists the patients who have recovered or are recovering
SELECT per.name AS 'Patient Name', h.Health_Status AS Status
FROM health_record h
JOIN Patient p ON p.Patient_ID = h.Health_ID
JOIN Person per ON per.ID = p.Patient_ID
WHERE h.Health_Status = 'Recovering' OR h.Health_Status = 'Recovered';

-- Lists each doctor as well as their speciality
SELECT p.Name AS 'Doctor Name', d.Field_of_Expertise AS Specialty
FROM Doctor d
JOIN Person p ON d.Doctor_ID = p.ID;

-- Lists all the instructions that have yet to be fully completed, as well as the nurse responsible, and the status of the instruction
SELECT p.NAME AS 'Nurse Name', Instruc_Description AS 'Instruction', ip.Perform_Status AS 'Status'
FROM Instruction_Performed ip
JOIN Nurse n ON ip.Perform_Nurse_ID = n.Nurse_ID
JOIN Person p ON n.Nurse_ID = p.ID
JOIN Instruction i ON ip.Perform_Code = i.Instruc_Code
WHERE ip.Perform_Status != 'Complete';

-- Total amount a doctor would have charged patients based on the instructions they ordered, as well as their name, and sorts the fee in ascending order.
SELECT p.Name AS 'Name', SUM(ins.Instruc_Fee) AS 'Total Fees Charged'
FROM Doctor d
JOIN Person p ON d.Doctor_ID = p.ID
JOIN Instruction_Order io ON d.Doctor_ID = io.Order_Doctor_ID
JOIN Instruction ins ON io.Order_Code = ins.Instruc_Code
GROUP BY d.Doctor_ID, p.Name
ORDER BY SUM(ins.Instruc_Fee) ASC;

-- Lists the rooms that have multiple patients in them, with the patient name, room number, and capacity
SELECT per.name AS 'Patient Name' , r.Room_Num, r.capacity
FROM Patient p
Inner JOIN Room r ON p.RoomNum = r.Room_Num
JOIN Person per ON per.ID = p.Patient_ID
WHERE r.capacity != 1;

-- Lists information about patients whose current condition is not stable
SELECT p.Name AS 'Patient Name', hr.Health_Date AS  'Date',
hr.Health_Description AS 'Description', hr.Health_Status AS 'Status'
FROM Health_Record hr
JOIN Patient pa ON hr.Health_ID = pa.Patient_ID
JOIN Person p ON pa.Patient_ID = p.ID
WHERE hr.Health_Status != 'Stable'; 
