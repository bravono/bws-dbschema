CREATE TABLE IF NOT EXISTS rental_earnings (
    rental_earning_id SERIAL PRIMARY KEY,
    user_id INTEGER,
    booking_id INTEGER,
    amount_kobo INTEGER,
    created_at TIMESTAMP DEFAULT NOW()
);