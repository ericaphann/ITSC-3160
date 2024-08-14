INSERT INTO Room VALUES 
('100', '2', '100'),
('101', '1', '200'),
('102', '1', '300'),
('103', '3', '400'),
('104', '2', '500'),
('105', '2', '600'),
('106', '1', '700'),
('107', '1', '800'),
('108', '3', '900'),
('109', '2', '1000'),
('2222', '1', '2000');

INSERT INTO Person Values
('1234', 'Erica', '432 Wood St', '120930901'),
('5678', 'Bob', '987 River ln', '999999999'),
('4321', 'Sally', '224 Spring rd', '223456679'),
('1111', 'Rajeev', '123 Birch rd', '123456789'),
('1512', 'Ani', '321 Test ln', '122611332'),

('6383', 'Bob', '135 Birch St', '129084112'),
('9326', 'Donal', '35 Snake Hill', '160936319'),
('1241', 'Emory', '912 Oakwood Drive', '695001183'),
('4498', 'Josh', '124 Boring street', '231651067'),
('2831', 'Master Oogway', 'Valley of Peace', '111666111'),

('4444', 'Jhin', 'Somewhere in canada, probably.', '4444444444'),
('7777', 'Moana', 'Motunui', '624242090'),
('1391', 'Jonsey', 'Tilted Towers', '111656131'),
('1020', 'Monkey D. Luffy', 'East Blue', '9999999999'),
('8711', 'Carol', '246 Cedar St', '346346326');

INSERT INTO Patient VALUES
('1234', '2222', '3'),
('5678', '100', '5'),
('4321', '100', '3'),
('1111', 101,'12'),
('1512', '102', '7');

INSERT INTO Nurse VALUES 
('6383', 'N-1'),
('9326', 'N-2'),
('1241', 'N-3'),
('4498', 'N-4'),
('2831', 'N-5');

INSERT INTO Doctor VALUES
('4444', 'Neurosurgery', 'D-1'),
('7777', 'Orthopedics', 'D-2'),
('1391', 'Pediatrics', 'D-3'),
('1020', 'Anesthesiology', 'D-4'),
('8711', 'General Surgery', 'D-3');

INSERT INTO Health_Record VALUES
('1234', '2024-06-21', 'Stable', 'Routine Checkup', 'Headache'),
('5678', '2024-05-01', 'Recovered', 'Surgery', 'Appendicitis'),
('4321', '2024-06-18', 'Recovering', 'Cast', 'Fractured wrist'),
('1111', '2024-06-20', 'Critical', 'Surgery', 'Heart Attack'),
('1512', '2024-06-19', 'Recovering', 'Post-Surgery', 'Heart Surgery');


INSERT INTO Instruction VALUES 
('0001', 'Check Blood Pressure', '5', '2024-06-21', '1234'),
('0002', 'Remove Appendix', '5000', '2024-04-31', '5678'),
('0003', 'Apply Cast', '400', '2024-06-18', '4321'),
('0004', 'Stent', '100000', '2024-06-20', '1111'),
('0005', 'Post-Surgery Care', '12000', '2024-06-19', '1512');

INSERT INTO Instruction_Order VAlUES
('4444', '0001'),
('7777', '0002'),
('1391', '0003'),
('1020', '0004'),
('8711', '0005');

INSERT INTO Instruction_Performed VALUES
('6383','0001', 'Complete'),
('9326', '0002', 'Complete'),
('1241', '0003', 'Incomplete'),
('4498', '0004', 'Complete'),
('2831', '0005', 'In Progress');


INSERT INTO Medicine VALUES
('Tylenol'),
('Ibuprofen'),
('Opioids'),
('Aspirin'),
('Spironolactone');

INSERT INTO Medication VALUES
('00001', 'Tylenol', '1234', '6383', 'Headache Relief', '200 mg'),
('00002', 'Ibuprofen', '5678', '9326', 'Anti-Inflamation', '400 mg'),
('00003', 'Opioids', '4321', '1241', 'Painkiller', '100 mg'),
('00004', 'Aspirin', '1111', '4498', 'Pain Relief', '200 mg'),
('00005', 'Spironolactone', '1512', '2831', 'Treat Heart Failure', '25 mg');

INSERT INTO Invoice VALUES
('000001', '1234', 'PAID'),
('000002', '5678', 'PAID'),
('000003', '4321', 'NOT PAID'),
('000004', '1111', 'PARTIALLY PAID'),
('000005', '1512', 'PAID');

INSERT INTO Payment VALUES
('0001', '000001', '2024-06-21', '6005'),
('0002', '000002', '2024-05-10', '2500'),
('0003', '000002', '2024-05-24', '2500'),
('0004', '000002', '2024-06-10', '500'),
('0005', '000004', '2024-06-20', '50000'),
('0006', '000005', '2024-06-20', '14100');



