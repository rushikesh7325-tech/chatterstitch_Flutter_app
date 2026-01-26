const db = require('../db'); // Your PostgreSQL pool connection
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

// --- SIGNUP USER ---
exports.signupuser = async (req, res) => {
  try {
    const { username, email, password } = req.body;

    if (!username || !email || !password) {
      return res.status(400).json({ success: false, message: 'All fields are required.' });
    }

    // 1. Hash the password before saving
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    // 2. Insert into PostgreSQL
    // We use $1, $2, $3 to prevent SQL Injection
    const newUser = await db.query(
      'INSERT INTO users (username, email, password) VALUES ($1, $2, $3) RETURNING id, username, email',
      [username, email, hashedPassword]
    );

    return res.status(201).json({
      success: true,
      message: 'User registered successfully!',
      user: newUser.rows[0]
    });

  } catch (error) {
    // Catch PostgreSQL Unique Constraint error (Email/Username already exists)
    if (error.code === '23505') {
      return res.status(400).json({ success: false, message: 'Username or Email already exists.' });
    }
    console.error('Signup Error:', error);
    res.status(500).json({ success: false, message: 'Internal Server Error' });
  }
};

// --- LOGIN USER ---
exports.loginuser = async (req, res) => {
  try {
    const { username, password } = req.body;

    if (!username || !password) {
      return res.status(400).json({ success: false, message: 'Provide username and password.' });
    }

    // 1. Find user by username
    const result = await db.query('SELECT * FROM users WHERE username = $1', [username]);

    if (result.rows.length === 0) {
      return res.status(401).json({ success: false, message: 'Invalid Credentials.' });
    }

    const user = result.rows[0];

    // 2. Compare hashed password
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(401).json({ success: false, message: 'Invalid Credentials.' });
    }

    // 3. Generate JWT Token
    const token = jwt.sign(
      { id: user.id, username: user.username },
      process.env.JWT_SECRET || 'your_secret_key',
      { expiresIn: '1d' }
    );

    return res.status(200).json({
      success: true,
      message: `Welcome back, ${username}!`,
      token,
      user: { id: user.id, username: user.username }
    });

  } catch (error) {
    console.error('Login Error:', error);
    res.status(500).json({ success: false, message: 'Internal Server Error' });
  }
};
// controllers/user.controller.js

// ... your existing signupuser and loginuser code ...

exports.getMe = async (req, res) => {
    try {
        const result = await db.query(
            'SELECT id, username, email FROM users WHERE id = $1',
            [req.user.id]
        );

        if (result.rows.length === 0) {
            return res.status(404).json({ success: false, message: "User not found" });
        }

        res.json({ success: true, user: result.rows[0] });
    } catch (error) {
        console.error("getMe error:", error);
        res.status(500).json({ success: false, message: "Internal Server Error" });
    }
};