const jwt = require('jsonwebtoken');

/**
 * Auth Middleware
 * Checks for a JWT in the Authorization header and verifies it.
 */
const verifyToken = (req, res, next) => {
    // 1. Get the token from the header (Format: Bearer <token>)
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];

    if (!token) {
        return res.status(401).json({ 
            success: false, 
            message: "No token provided. Access denied." 
        });
    }

    try {
        // 2. Verify the token using your secret key
        const decoded = jwt.verify(token, process.env.JWT_SECRET || 'your_secret_key');

        // 3. Attach the decoded payload (user id, etc.) to the request object
        req.user = decoded;

        // 4. Move to the next function (the controller)
        next();
    } catch (err) {
        return res.status(403).json({ 
            success: false, 
            message: "Invalid or expired token." 
        });
    }
};

// IMPORTANT: Exporting directly as a function
module.exports = verifyToken;