ALTER TABLE payments ADD COLUMN IF NOT EXISTS rental_booking_id INTEGER;
ALTER TABLE wallet_usages ADD COLUMN IF NOT EXISTS rental_booking_id INTEGER;