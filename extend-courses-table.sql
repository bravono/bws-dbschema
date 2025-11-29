ALTER TABLE courses
ADD COLUMN slug VARCHAR(255) UNIQUE,       -- URL-friendly version of the title
ADD COLUMN content TEXT,                   -- Entire body of the post
ADD COLUMN excerpt TEXT,                   -- Short summary for index/search
ADD COLUMN age_bracket VARCHAR(50),
ADD COLUMN updated_at TIMESTAMP DEFAULT NOW(); -- Last time modified

CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
   NEW.updated_at = NOW();
   RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_courses_updated_at
BEFORE UPDATE ON courses
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();