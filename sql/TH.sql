-- TH.sql

-- Drop tables if they already exist
DROP TABLE IF EXISTS Courses CASCADE;
DROP TABLE IF EXISTS Tutors CASCADE;
DROP TABLE IF EXISTS CourseTutor CASCADE;

-- Create Courses Table
CREATE TABLE Courses (
    courseID SERIAL PRIMARY KEY,
    courseCode VARCHAR(255) NOT NULL,
    courseName VARCHAR(255) NOT NULL
);

-- Create Tutors Table
CREATE TABLE Tutors (
    tutorID SERIAL PRIMARY KEY,
    firstName VARCHAR(100) NOT NULL,
    lastName VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL

);

-- Create CourseTutor Junction Table for Many-to-Many Relationship
CREATE TABLE CourseTutor (
    tutorID INT REFERENCES Tutors(tutorID) ON DELETE CASCADE,
    courseID INT REFERENCES Courses(courseID) ON DELETE CASCADE,
    PRIMARY KEY (tutorID, courseID)
);

-- Allow for selecting
GRANT SELECT ON Courses TO PUBLIC;
GRANT SELECT ON Tutors TO PUBLIC;
GRANT SELECT ON CourseTutor TO PUBLIC;

-- Inserts for courses
INSERT INTO Courses (courseCode, courseName) 
VALUES 
    ('CS 108', 'Introduction to Computing'),
    ('CS 112', 'Introduction to Data Structures'),
    ('CS 212', 'Data Structures and Algorithms'),
    ('CS 214', 'Programming Language Concepts'),
    ('CS 232', 'Operating Systems and Networking'),
    ('CS 262', 'Software Engineering'),
    ('CS 384', 'Perspectives on Computing'),
    ('CS 396', 'Senior Project in Computing'),
    ('CS 398', 'Senior Project in Computing II'),
    ('CS 300', 'Special Topics in Computer Science'),
    ('CS 312', 'Logic, Computability, and Complexity'),
    ('CS 320', 'Advanced Computer Architecture'),
    ('CS 326', 'Embedded Systems and the Internet of Things'),
    ('CS 332', 'Advanced Computer Networks'),
    ('CS 336', 'Web Development'),
    ('CS 338', 'System Administration: Infrastructure'),
    ('CS 339', 'System Administration: Cloud Services'),
    ('CS 354', 'Database Management Systems'),
    ('CS 375', 'Artificial Intelligence'),
    ('CS 376', 'Machine Learning'),
    ('CS 372', 'Computer Graphics'),
    ('CS 364', 'Computer Security'),
    ('CS 374', 'High Performance Computing'),
    ('ENGR 304', 'Fundamentals of Digital Systems'),
    ('ENGR 325', 'Computer Architecture and Digital Systems Design'),
    ('COMM 101', 'Oral Rhetoric'),
    ('ENGR 220', 'Introduction to Computer Architecture'),
    ('MATH 171', 'Calculus I'),
    ('MATH 251', 'Discrete Mathematics I'),
    ('MATH 252', 'Discrete Mathematics II'),
    ('STAT 243', 'Statistics'),
    ('STAT 343', 'Probability and Statistics'),
    ('MATH 172', 'Calculus II'),
    ('MATH 255', 'Introductory Linear Algebra'),
    ('STAT 245', 'Applied Data Analysis'),
    ('STAT 341', 'Computational Bayesian Statistics'),
    ('STAT 344', 'Mathematical Statistics');

-- Insert for tutors
INSERT INTO Tutors (firstName, lastName, email) 
VALUES 
    ('John', 'Doe', 'john.doe@example.com'),
    ('Jane', 'Smith', 'jane.smith@example.com'),
    ('Michael', 'Johnson', 'michael.johnson@example.com'),
    ('Emily', 'Davis', 'emily.davis@example.com'),
    ('William', 'Brown', 'william.brown@example.com'),
    ('Olivia', 'Wilson', 'olivia.wilson@example.com'),
    ('James', 'Taylor', 'james.taylor@example.com'),
    ('Sophia', 'Miller', 'sophia.miller@example.com'),
    ('David', 'Martinez', 'david.martinez@example.com'),
    ('Isabella', 'Hernandez', 'isabella.hernandez@example.com'),
    ('Lucas', 'Garcia', 'lucas.garcia@example.com'),
    ('Ava', 'Rodriguez', 'ava.rodriguez@example.com'),
    ('Ethan', 'Lee', 'ethan.lee@example.com'),
    ('Mia', 'Perez', 'mia.perez@example.com'),
    ('Alexander', 'Martinez', 'alexander.martinez@example.com'),
    ('Charlotte', 'Gonzalez', 'charlotte.gonzalez@example.com'),
    ('Benjamin', 'Wilson', 'benjamin.wilson@example.com'),
    ('Amelia', 'Anderson', 'amelia.anderson@example.com'),
    ('Henry', 'Thomas', 'henry.thomas@example.com'),
    ('Lily', 'Jackson', 'lily.jackson@example.com');

-- Insert for coursetutor
INSERT INTO CourseTutor (tutorID, courseID) 
VALUES 
    -- 1 tutor for CS108
    (1, 1),  -- John Doe for CS108
    
    -- 2 tutors for CS112
    (2, 2),  -- Jane Smith for CS112
    (3, 2),  -- Michael Johnson for CS112
    
    -- 1 tutor for CS212
    (4, 3),  -- Emily Davis for CS212
    
    -- 2 tutors for CS214
    (5, 4),  -- William Brown for CS214
    (6, 4),  -- Olivia Wilson for CS214
    
    -- 1 tutor for CS232
    (7, 5),  -- James Taylor for CS232
    
    -- 2 tutors for CS262
    (8, 6),  -- Sophia Miller for CS262
    (9, 6),  -- David Martinez for CS262
    
    -- 1 tutor for CS384
    (10, 7), -- Isabela Hernandez for CS384
    
    -- 2 tutors for CS396
    (11, 8), -- Lucas Garcia for CS396
    (12, 8), -- Ava Rodriguez for CS396
    
    -- 1 tutor for CS398
    (13, 9), -- Ethan Lee for CS398
    
    -- 2 tutors for CS300
    (14, 10), -- Mia Perez for CS300
    (15, 10), -- Alexander Martinez for CS300
    
    -- 3 tutors for CS312
    (16, 11), -- Charlotte Gonzalez for CS312
    (17, 11), -- Benjamin Wilson for CS312
    (18, 11), -- Amelia Anderson for CS312
    
    -- 2 tutors for CS320
    (19, 12), -- Henry Thomas for CS320
    (20, 12), -- Lily Jackson for CS320
    
    -- 1 tutor for CS326
    (1, 13),  -- John Doe for CS326
    
    -- 2 tutors for CS332
    (2, 14),  -- Jane Smith for CS332
    (3, 14),  -- Michael Johnson for CS332
    
    -- 3 tutors for CS336
    (4, 15),  -- Emily Davis for CS336
    (5, 15),  -- William Brown for CS336
    (6, 15),  -- Olivia Wilson for CS336
    
    -- 2 tutors for CS338
    (7, 16),  -- James Taylor for CS338
    (8, 16),  -- Sophia Miller for CS338
    
    -- 1 tutor for CS339
    (9, 17),  -- David Martinez for CS339
    
    -- 2 tutors for CS354
    (10, 18), -- Isabela Hernandez for CS354
    (11, 18), -- Lucas Garcia for CS354
    
    -- 3 tutors for CS375
    (12, 19), -- Ava Rodriguez for CS375
    (13, 19), -- Ethan Lee for CS375
    (14, 19), -- Mia Perez for CS375
    
    -- 1 tutor for CS376
    (15, 20), -- Alexander Martinez for CS376
    
    -- 2 tutors for CS372
    (16, 21), -- Charlotte Gonzalez for CS372
    (17, 21), -- Benjamin Wilson for CS372
    
    -- 3 tutors for CS364
    (18, 22), -- Amelia Anderson for CS364
    (19, 22), -- Henry Thomas for CS364
    (20, 22), -- Lily Jackson for CS364
    
    -- 2 tutors for CS374
    (1, 23),  -- John Doe for CS374
    (2, 23),  -- Jane Smith for CS374
    
    -- 1 tutor for ENGR304
    (3, 24),  -- Michael Johnson for ENGR304
    
    -- 2 tutors for ENGR325
    (4, 25),  -- Emily Davis for ENGR325
    (5, 25),  -- William Brown for ENGR325
    
    -- 3 tutors for COMM101
    (6, 26),  -- Olivia Wilson for COMM101
    (7, 26),  -- James Taylor for COMM101
    (8, 26),  -- Sophia Miller for COMM101
    
    -- 2 tutors for ENGR220
    (9, 27),  -- David Martinez for ENGR220
    (10, 27), -- Isabela Hernandez for ENGR220
    
    -- 1 tutor for MATH171
    (11, 28), -- Lucas Garcia for MATH171
    
    -- 2 tutors for MATH251
    (12, 29), -- Ava Rodriguez for MATH251
    (13, 29), -- Ethan Lee for MATH251
    
    -- 1 tutor for MATH252
    (14, 30), -- Mia Perez for MATH252
    
    -- 2 tutors for STAT243
    (15, 31), -- Alexander Martinez for STAT243
    (16, 31), -- Charlotte Gonzalez for STAT243
    
    -- 3 tutors for STAT343
    (17, 32), -- Benjamin Wilson for STAT343
    (18, 32), -- Amelia Anderson for STAT343
    (19, 32), -- Henry Thomas for STAT343
    
    -- 2 tutors for MATH172
    (20, 33), -- Lily Jackson for MATH172
    (1, 33),  -- John Doe for MATH172
    
    -- 1 tutor for MATH255
    (2, 34),  -- Jane Smith for MATH255
    
    -- 3 tutors for STAT245
    (3, 35),  -- Michael Johnson for STAT245
    (4, 35),  -- Emily Davis for STAT245
    (5, 35),  -- William Brown for STAT245
    
    -- 2 tutors for STAT341
    (6, 36),  -- Olivia Wilson for STAT341
    (7, 36),  -- James Taylor for STAT341
    
    -- 3 tutors for STAT344
    (8, 37),  -- Sophia Miller for STAT344
    (9, 37),  -- David Martinez for STAT344
    (10, 37); -- Isabela Hernandez for STAT344
