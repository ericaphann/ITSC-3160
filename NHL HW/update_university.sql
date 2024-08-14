/* Delete the tables if they already exist */
DROP DATABASE IF EXISTS university;
CREATE DATABASE university;
USE university;


DROP TABLE IF EXISTS student CASCADE;
DROP TABLE IF EXISTS prerequisite CASCADE;
DROP TABLE IF EXISTS section CASCADE; 
DROP TABLE IF EXISTS course CASCADE;
DROP TABLE IF EXISTS grade_report CASCADE;


CREATE TABLE student (
	name 	  	VARCHAR(50) NOT NULL,
	student_number  CHAR(9) NOT NULL,
	class_year 	CHAR(4),
	major		VARCHAR(20),
	PRIMARY KEY (student_number)
);

CREATE TABLE course (
	course_name 	VARCHAR(50) NOT NULL,
	course_number	INT NOT NULL,
	credit_hours	INT,
	department	VARCHAR(40) NOT NULL,
	PRIMARY KEY (course_number)
--     CONSTRAINT course_number_limit  CHECK (course_number > 1000 AND course_number < 6999)
);


CREATE TABLE prerequisite (
    course_number INT NOT NULL,
    prerequisite_number INT NOT NULL ,
    PRIMARY KEY (course_number, prerequisite_number),
    FOREIGN KEY (course_number) REFERENCES course(course_number),
    FOREIGN KEY (course_number) REFERENCES course(course_number)
);


INSERT INTO course VALUE ('Databases and SQL', 2215, 3, 'Computer Science');
INSERT INTO course VALUE ('Intro to C Programming', 1110, 3, 'Computer Science');
INSERT INTO course VALUE ('Data Structures and Algorithms', 2226, 3, 'Computer Science');

INSERT INTO course (course_name, course_number, department) 
VALUE ('Computer Organization Lab', 3331, 'Computer Science');


CREATE TABLE section (
    section_identifier INT NOT NULL,
    course_number INT NOT NULL,
    semester VARCHAR(10),
    year INT,
    instructor VARCHAR(50),
    PRIMARY KEY (section_identifier,course_number),
    FOREIGN KEY (course_number) REFERENCES course(course_number)
);

INSERT INTO section (section_identifier, course_number, semester, year)
SELECT 1, course_number, 'Fall', 2019 FROM course; 

INSERT INTO section VALUE (2, 1110, 'Fall', 2019, NULL);

DELETE FROM section WHERE course_number = 1110;

UPDATE section SET instructor = 'Sara Riazi' 
WHERE course_number = 2215;

ALTER TABLE section
ADD days CHAR(3); 

ALTER TABLE section
ADD fee INT
DEFAULT 240;

ALTER TABLE section
DROP fee;

INSERT INTO student VALUE ('erica', '123456789', 2026, 'Computer Science'); 
INSERT INTO student VALUE ('eric', '123456345', 2025, 'Business');
INSERT INTO student VALUE ('john', '123456700', 2024, 'Accounting');
INSERT INTO student VALUE ('sally', '123456738', 2027, 'Nursing');

CREATE TABLE grade_report(
	student_number  CHAR(9) NOT NULL,
    section_identifier INT NOT NULL,
    course_number INT NOT NULL,
    grade VARCHAR(3),
    PRIMARY KEY(student_number, section_identifier, course_number),
    FOREIGN KEY (student_number) references student(student_number),
    FOREIGN KEY (section_identifier,course_number) references section(section_identifier,course_number)
);

INSERT INTO grade_report VALUE ('123456789', 1, 2215, NULL);

UPDATE grade_report SET grade = 80
WHERE student_number = '123456789'
;

ALTER TABLE section
	add location VARCHAR(50)
;

UPDATE section SET location = 'BCKM 208'
WHERE course_number = (
SELECT cn.course_number
FROM course cn
WHERE course_name = 'Databases and SQL'
);

ALTER TABLE section
	drop location
;

DELETE FROM grade_report WHERE student_number = '123456789';

DROP TABLE grade_report;

DELETE FROM student 
WHERE student_number in ('123456789', '123456345' ,'123456700' ,'123456738');







