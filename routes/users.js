var express = require('express');
var router = express.Router();
const db = require('../db'); // Import the database connection

/* GET users listing. */
router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});

module.exports = router;
