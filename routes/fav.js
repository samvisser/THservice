// in fav.js
const express = require('express');
const router = express.Router();
const db = require('../db'); // Assuming your database connection file is `db.js`

// Add Tutor to Favorites
router.post('/', async (req, res) => {
  const { userID, tutorID } = req.body;
  console.log('Add to favorites request received!', req.body);

  if (!userID || !tutorID) {
    return res.status(400).json({ error: 'userID and tutorID are required' });
  }

  try {
    // Add the favorite record
    await db.none(
      'INSERT INTO Favorites (userID, tutorID) VALUES ($1, $2) ON CONFLICT DO NOTHING',
      [userID, tutorID]
    );

    res.status(200).json({ message: 'Tutor added to favorites successfully' });
  } catch (err) {
    console.error('Error adding tutor to favorites:', err.stack);
    res.status(500).json({ error: 'An error occurred while adding to favorites', details: err.message });
  }
});

// Remove Tutor from Favorites
// Delete from Favorites
router.delete('/', async (req, res) => {
  const { userID, tutorID } = req.body;
  console.log('Remove from favorites request received!', req.body);

  if (!userID || !tutorID) {
    return res.status(400).json({ error: 'userID and tutorID are required' });
  }

  try {
    // Delete the favorite record
    await db.none(
      'DELETE FROM Favorites WHERE userID = $1 AND tutorID = $2',
      [userID, tutorID]
    );

    res.status(200).json({ message: 'Tutor removed from favorites successfully' });
  } catch (err) {
    console.error('Error removing tutor from favorites:', err.stack);
    res.status(500).json({ error: 'An error occurred while removing from favorites', details: err.message });
  }
});

// Fetch Tutor's Favorite Count
router.get('/fetch/:id', async (req, res) => {
    const tutorID = req.params.id;
  
    try {
      const result = await db.one(
        'SELECT COUNT(*) AS favoritesCount FROM Favorites WHERE tutorID = $1',
        [tutorID]
      );
  
      // Log the result to verify that favoritesCount is already an integer
      console.log('Query Result:', result); // Ensure it shows a number like 1, not a string
  
      // Return the result directly if it's already an integer
      res.json({
        tutorID: tutorID,
        favoritesCount: result.favoritescount, // directly use it
      });
    } catch (error) {
      console.error('Error fetching favorites count:', error);
      res.status(500).json({ error: 'Failed to fetch favorites count' });
    }
  });

module.exports = router;