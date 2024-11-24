// routes/auth.js

const express = require('express');
const router = express.Router();
const db = require('../db');  // Import the db connection from db.js

// Sign Up Endpoint (User Registration)
router.post('/signup', async (req, res) => {
  const { firstName, lastName, email, password } = req.body;

  // Validation: Ensure that all required fields are provided
  if (!firstName || !lastName || !email || !password) {
    return res.status(400).json({ error: 'All fields are required' });
  }

  try {
    // Check if the user already exists
    const existingUser = await db.oneOrNone('SELECT * FROM Users WHERE email = $1', [email]);

    if (existingUser) {
      return res.status(400).json({ error: 'User with this email already exists' });
    }

    // Insert the new user into the database
    const result = await db.one(
      'INSERT INTO Users (firstName, lastName, email, userPass) VALUES ($1, $2, $3, $4) RETURNING userID',
      [firstName, lastName, email, password]
    );

    res.status(201).json({ message: 'User successfully created', userID: result.userID });
  } catch (err) {
    console.error('Error during sign-up:', err.stack);
    res.status(500).json({ error: 'An error occurred during sign-up', details: err.message });
  }
});

// Sign In Endpoint (User Authentication)
router.post('/signin', async (req, res) => {
  const { email, password } = req.body;

  // Validation: Ensure that email and password are provided
  if (!email || !password) {
    return res.status(400).json({ error: 'Email and password are required' });
  }

  try {
    // Retrieve the user from the database by email
    const user = await db.oneOrNone('SELECT * FROM Users WHERE email = $1', [email]);

    if (!user) {
      return res.status(401).json({ error: 'Invalid email or password' });
    }

    // Check the password (to be implemented with hashing when ready)
    if (user.userPass === password) {
      res.json({ message: 'Login successful', userID: user.userID });
    } else {
      res.status(401).json({ error: 'Invalid email or password' });
    }
  } catch (err) {
    console.error('Error during sign-in:', err.stack);
    res.status(500).json({ error: 'An error occurred during sign-in', details: err.message });
  }
});

module.exports = router;