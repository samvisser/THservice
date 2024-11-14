// In routes/courseCodes.js
var express = require('express');
var router = express.Router();
const db = require('../db');  // Import the database connection

// GET /classCodes - get all alass codes
router.get('/', function (req, res, next) {
  db.any('SELECT courseCode FROM Courses;')
    .then(courseCodes => {
      console.log(courseCodes);
      res.json(courseCodes);
    })
    .catch(err => {
      res.status(500).json({ error: err.message });
    });
});

// GET /coursecodes/:courseCode - get tutors for a specific course code
router.get('/:courseCode', function (req, res, next) {
  const courseCode = req.params.courseCode;

  db.any(
    `SELECT t.firstName || ' ' || t.lastName AS tutorName
     FROM Tutors t
     JOIN CourseTutor ct ON t.tutorID = ct.tutorID
     JOIN Courses c ON ct.courseID = c.courseID
     WHERE LOWER(c.courseCode) = LOWER($1);`, 
    [courseCode]
  )
    .then(tutors => {
      if (tutors.length === 0) {
        return res.status(404).json({ message: "No tutors found for this course code" });
      }
      res.json(tutors);
    })
    .catch(err => {
      res.status(500).json({ error: err.message });
    });
});

module.exports = router;