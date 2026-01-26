const express = require('express');
const router = express.Router();
// Correct way to import if module.exports = verifyToken
const verifyToken = require('../middleware/auth.middleware'); 

// Ensure these names EXACTLY match what is written in your controller
const { signupuser, loginuser, getMe } = require('../controllers/user.controller');

router.post('/signup', signupuser);
router.post('/login', loginuser);
// Correct way to import if module.exports = verifyToken
router.get('/me', verifyToken, getMe);
module.exports = router;