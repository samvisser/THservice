// In routes/tutors.js
var express = require('express');
var router = express.Router();
const db = require('../db'); // Import the database connection

// GET /tutors - get all tutors with their full names
router.get('/', function(req, res, next) {
  db.any("SELECT firstName || ' ' || lastName AS tutorName FROM Tutors")
    .then(tutors => {
      console.log(tutors);
      res.json(tutors);
    })
    .catch(err => {
      res.status(500).json({ error: err.message });
    });
});

// GET /tutors/:tutorName - get courses a specific tutor teaches
router.get('/:tutorName', function(req, res, next) {
  const tutorName = req.params.tutorName;
  const [firstName, lastName] = tutorName.split(' '); // Split the full name into firstName and lastName

  if (!firstName || !lastName) {
    return res.status(400).json({ error: "Please provide a valid tutor name in the format 'First Last'" });
  }

  db.any(
    `SELECT c.courseCode 
     FROM Courses c
     JOIN CourseTutor ct ON c.courseId = ct.courseId
     JOIN Tutors t ON ct.tutorId = t.tutorId
     WHERE t.firstName = $1 AND t.lastName = $2`,
    [firstName, lastName]
  )
    .then(courses => {
      if (courses.length === 0) {
        return res.status(404).json({ message: "No courses found for this tutor" });
      }
      res.json(courses);
    })
    .catch(err => {
      res.status(500).json({ error: err.message });
    });
});

module.exports = router;