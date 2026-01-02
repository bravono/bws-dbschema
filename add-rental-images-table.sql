CREATE TABLE rental_images (
  image_id SERIAL PRIMARY KEY,
  rental_id INT,
  image_name VARCHAR(255),
  image_size VARCHAR(45),
  image_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
)