const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
dotenv.config();
require('./db'); // Connecting to your Database

 


const app = express();
const PORT = process.env.PORT || 3000;

// --- MIDDLEWARE ---
app.use(cors()); // Allows Flutter (different origin) to talk to this server
app.use(express.json()); // CRITICAL: This parses JSON bodies sent from Flutter

// --- ROUTES ---
app.get('/', (req, res) => {
    res.send("Hello Rushi - ChatterStitch API is live!");
});
const userRouter = require('./routes/user.routes'); // Import your routes
app.use('/users', userRouter);
const onboardingRouter= require('./routes/onboarding.routes');
app.use('/onboarding',onboardingRouter);

// Link your user routes here
// This prefix means your full URL is: http://localhost:3000/api/users/signup


app.listen(PORT, () => {
    console.log(`Server is listening on Port http://localhost:${PORT}`);
});

module.exports = app;