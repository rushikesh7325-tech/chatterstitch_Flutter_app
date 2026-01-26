const pool = require('../db'); // Your DB connection

exports.onboardingdata = async (req, res) => {
    try {
        const userId = req.user.id; // From JWT middleware
        const {
            language_id,
            proficiency_level,
            learning_reasons,
            daily_goal,
            is_premium
        } = req.body;

        // SQL Query: Insert or Update on conflict of user_id
        const query = `
            INSERT INTO user_profiles (user_id, language_id, proficiency_level, learning_reasons, daily_goal, is_premium, updated_at)
            VALUES ($1, $2, $3, $4, $5, $6, NOW())
            ON CONFLICT (user_id) 
            DO UPDATE SET 
                language_id = EXCLUDED.language_id,
                proficiency_level = EXCLUDED.proficiency_level,
                learning_reasons = EXCLUDED.learning_reasons,
                daily_goal = EXCLUDED.daily_goal,
                is_premium = EXCLUDED.is_premium,
                updated_at = NOW();
        `;

        const values = [userId, language_id, proficiency_level, learning_reasons, daily_goal, is_premium];

        await pool.query(query, values);

        return res.status(200).json({
            success: true,
            message: 'Profile synced with PostgreSQL successfully!'
        });

    } catch (error) {
        console.error('Postgres Save Error:', error);
        res.status(500).json({ success: false, message: 'Database error' });
    }
};