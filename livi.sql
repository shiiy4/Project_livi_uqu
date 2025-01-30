CREATE DATABASE livi;
USE livi;


CREATE TABLE Manager (
    Manager_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(150),
    Department VARCHAR(50),
    Phone_No VARCHAR(20)
);
INSERT INTO Manager (Manager_ID, Name, Email, Department, Phone_No) 
VALUES 
(1, 'Ahmed Ali', 'ahmed.ali@example.com', 'IT', '0551234567'),
(2, 'Sara Mohammed', 'sara.mohammed@example.com', 'HR', '0557654321');


CREATE TABLE Employee (
    Employee_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Date_joined DATE NOT NULL,
    Email VARCHAR(255) UNIQUE,
    Department VARCHAR(255) NOT NULL,
    Role VARCHAR(50) -- إضافة عمود الدور (مدير أو موظف)
);
ALTER TABLE Employee ADD COLUMN password VARCHAR(255) NOT NULL;
INSERT INTO Employee (Name, Position, Date_joined, Email, Phone_No, Status, Department, Manager_ID, password) 
VALUES 
('Omar Khaled', 'Software Engineer', '2023-01-15', 'omar.khaled@example.com', '0551112233', 'Active', 'IT', 1, 'password123'),
('Fatima Hassan', 'HR Specialist', '2022-07-10', 'fatima.hassan@example.com', '0552223344', 'Active', 'HR', 2, 'password456'),
('Ali Ahmed', 'Project Manager', '2021-03-20', 'ali.ahmed@example.com', '0553334455', 'Active', 'IT', 1, 'password789');


CREATE TABLE Surveys (
    Survey_ID INT PRIMARY KEY AUTO_INCREMENT,
    Manager_ID INT NOT NULL,
    Survey_Date DATE NOT NULL,
    Burnout_Level INT,
    Survey_Title VARCHAR(255),  
    FOREIGN KEY (Manager_ID) REFERENCES Manager(Manager_ID)
);
INSERT INTO Surveys (Manager_ID, Survey_Date, Burnout_Level, Survey_Title)
VALUES
(1, '2024-12-01', NULL, 'Burnout Assessment Survey'),
(2, '2024-12-10', NULL, 'Employee Burnout Evaluation');



CREATE TABLE Report (
    Report_ID INT AUTO_INCREMENT PRIMARY KEY,
    Manager_ID INT NOT NULL,
    Report_Date DATE NOT NULL,
    Summary TEXT NOT NULL,
    Report_Type VARCHAR(50), -- إضافة نوع التقرير (مثل: يومي، شهري)
    FOREIGN KEY (Manager_ID) REFERENCES Manager(Manager_ID)
);

-- جدول الأسئلة المرتبطة بالاحتراق الوظيفي
CREATE TABLE Questions (
    Question_ID INT AUTO_INCREMENT PRIMARY KEY,
    Survey_ID INT NOT NULL,
    Question_Text TEXT NOT NULL,
    FOREIGN KEY (Survey_ID) REFERENCES Surveys(Survey_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- تعديل جدول ردود الاستبيانات ليشمل الإجابة النصية
CREATE TABLE survey_responses (
    Response_ID INT NOT NULL AUTO_INCREMENT,
    Survey_ID INT NOT NULL,
    Employee_ID INT NOT NULL,
    Question_ID INT NOT NULL,  -- إضافة العمود للسؤال
    Response_Text TEXT,  -- الإجابة النصية
    Response_Date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (Response_ID),
    FOREIGN KEY (Survey_ID) REFERENCES Surveys(Survey_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Question_ID) REFERENCES Questions(Question_ID) ON DELETE CASCADE ON UPDATE CASCADE -- الربط بالسؤال
);


INSERT INTO Questions (Survey_ID, Question_Text)
VALUES 
(1, 'Do you feel mentally exhausted at work?'),
(1, 'Do you find that everything you do at work requires a great deal of effort?'),
(1, 'After a day at work, do you find it hard to recover your energy?'),
(1, 'Do you feel physically exhausted at work?'),
(1, 'When you get up in the morning, do you lack the energy to start a new day at work?'),
(1, 'Do you want to be active at work but find it difficult to manage?'),
(1, 'Do you quickly get tired when exerting yourself at work?'),
(1, 'Do you feel mentally exhausted and drained at the end of your workday?'),
(1, 'Do you struggle to find enthusiasm for your work?'),
(1, 'Do you feel indifferent about your job?'),
(1, 'Are you cynical about the impact your work has on others?'),
(1, 'Do you have trouble staying focused at work?'),
(1, 'Do you struggle to think clearly at work?'),
(1, 'Are you forgetful and easily distracted at work?'),
(1, 'Do you have trouble concentrating while working?'),
(1, 'Do you make mistakes at work because your mind is on other things?'),
(1, 'Do you feel unable to control your emotions at work?'),
(1, 'Do you feel that you no longer recognize yourself in your emotional reactions at work?'),
(1, 'Do you become irritable when things don\'t go your way at work?'),
(1, 'Do you feel sad or upset at work without knowing why?');
SELECT * FROM Manager;
SELECT * FROM Employee;
SELECT * FROM Surveys;
SELECT * FROM Report;
SELECT * FROM Questions;
SELECT * FROM survey_responses;