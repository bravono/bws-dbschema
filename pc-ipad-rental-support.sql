CREATE TABLE IF NOT EXISTS rentals (
          rental_id SERIAL PRIMARY KEY,
          user_id INT NOT NULL,
          device_type VARCHAR(50) NOT NULL,
          device_name VARCHAR(255) NOT NULL,
          description TEXT,
          specs TEXT,
          hourly_rate DECIMAL(10, 2) NOT NULL,
          location_city VARCHAR(100) NOT NULL,
          location_address VARCHAR(255),
          location_lat DECIMAL(10, 8),
          location_lng DECIMAL(11, 8),
          has_internet BOOLEAN DEFAULT FALSE,
          has_backup_power BOOLEAN DEFAULT FALSE,
          status VARCHAR(20) DEFAULT 'active',
          created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
          updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
        );
        
CREATE TABLE IF NOT EXISTS rental_bookings (
          rental_booking_id SERIAL PRIMARY KEY,
          rental_id INT NOT NULL REFERENCES rentals(rental_id),
          client_id INT NOT NULL,
          start_time TIMESTAMP WITH TIME ZONE NOT NULL,
          end_time TIMESTAMP WITH TIME ZONE NOT NULL,
          total_amount DECIMAL(10, 2) NOT NULL,
          order_status_id INT,
          payment_reference VARCHAR(100),
          created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
        );

CREATE TABLE IF NOT EXISTS rental_reviews (
          rental_review_id SERIAL PRIMARY KEY,
          rental_booking_id INT NOT NULL REFERENCES rental_bookings(rental_booking_id),
          reviewer_id INT NOT NULL,
          reviewee_id INT NOT NULL,
          rating INT CHECK (rating >= 1 AND rating <= 5),
          comment TEXT,
          created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
        );

CREATE TABLE IF NOT EXISTS rental_demands (
          rental_demand_id SERIAL PRIMARY KEY,
          user_id INT,
          location_lat DECIMAL(10, 8),
          location_lng DECIMAL(11, 8),
          created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
        );