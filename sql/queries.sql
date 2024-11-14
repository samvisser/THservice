-- queries.sql

-- List all offered courses
SELECT *
FROM Courses;

-- List all tutors with their courses
SELECT T.firstName, T.lastName, C.courseCode
FROM Tutors T
JOIN CourseTutor CT ON T.tutorID = CT.tutorID
JOIN Courses C ON CT.courseID = C.courseID;

-- List all tutors for CS112
SELECT T.firstName, T.lastName, T.email
FROM Tutors T
JOIN CourseTutor CT ON T.tutorID = CT.tutorID
JOIN Courses C ON CT.courseID = C.courseID
WHERE C.courseCode = 'CS112';

-- Count number of tutors for each course
SELECT C.courseName, COUNT(CT.tutorID) AS numberOfTutors
FROM Courses C
JOIN CourseTutor CT ON C.courseID = CT.courseID
GROUP BY C.courseName;

-- List courses with 2 tutors
SELECT C.courseName
FROM Courses C
JOIN CourseTutor CT ON C.courseID = CT.courseID
GROUP BY C.courseName
HAVING COUNT(CT.tutorID) = 2;