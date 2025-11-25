ALTER TABLE users 
	ADD COLUMN referral_code VARCHAR(255) UNIQUE;

ALTER TABLE users 
	ADD COLUMN referred_by_id INTEGER REFERENCES users(user_id);

	  CREATE TABLE IF NOT EXISTS referral_earnings (
        referral_earning_id SERIAL PRIMARY KEY,
        referrer_id INTEGER NOT NULL REFERENCES users(user_id),
        referred_user_id INTEGER NOT NULL REFERENCES users(user_id),
        amount_kobo BIGINT NOT NULL,
        order_id INTEGER REFERENCES orders(order_id),
        created_at TIMESTAMP DEFAULT NOW(),
        is_used BOOLEAN DEFAULT FALSE
      );

	  CREATE TABLE IF NOT EXISTS wallet_usages (
        wallet_usage_id SERIAL PRIMARY KEY,
        user_id INTEGER NOT NULL REFERENCES users(user_id),
        order_id INTEGER REFERENCES orders(order_id),
        amount_kobo BIGINT NOT NULL,
        created_at TIMESTAMP DEFAULT NOW()
      );


      