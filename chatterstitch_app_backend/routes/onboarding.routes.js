const express = require('express');
const router = express.Router();
const { onboardingdata } = require('../controllers/onboarding.controller');
const verifyToken = require('../middleware/auth.middleware'); // Ensure this import is correct

// verifyToken MUST come first!
router.post('/save', verifyToken, onboardingdata);

module.exports = router;