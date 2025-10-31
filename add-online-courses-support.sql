ALTER TABLE courses
  DROP COLUMN published,
  DROP COLUMN duration;

CREATE TABLE tags (
	tag_id SERIAL PRIMARY KEY,
	tag_name VARCHAR(100)
);

CREATE TABLE instructors (
  instructor_id SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  bio TEXT,
  photo_url TEXT,
  email VARCHAR(255) UNIQUE
);


-- Add columns
ALTER TABLE courses
  ADD COLUMN is_active BOOLEAN DEFAULT FALSE,
  ADD COLUMN start_date DATE,
  ADD COLUMN end_date DATE,
  ADD COLUMN instructor_id INTEGER,
  ADD COLUMN max_students INTEGER,
  ADD COLUMN price_in_kobo INTEGER DEFAULT 0,
  ADD COLUMN thumbnail_url TEXT,
  ADD COLUMN course_category_id INTEGER,
  ADD COLUMN level VARCHAR(50),
  ADD COLUMN language VARCHAR(50),
  ADD COLUMN tag_id INTEGER;

-- Add foreign key constraints
ALTER TABLE courses
  ADD CONSTRAINT fk_course_instructor
    FOREIGN KEY (instructor_id)
    REFERENCES instructors(instructor_id);

ALTER TABLE courses
  ADD CONSTRAINT fk_course_category
    FOREIGN KEY (category_id)
    REFERENCES product_categories(category_id);

ALTER TABLE courses
  ADD CONSTRAINT fk_course_tag
    FOREIGN KEY (tag_id)
    REFERENCES tags(tag_id);

CREATE TABLE course_categories (
  category_id SERIAL PRIMARY KEY,
  category_name VARCHAR(100) NOT NULL,
  description TEXT
);


CREATE TABLE course_sessions (
  session_id SERIAL PRIMARY KEY,
  course_id INTEGER REFERENCES courses(course_id),
  session_number INTEGER NOT NULL,
  session_date DATE NOT NULL,
  session_time TIME NOT NULL,
  session_link TEXT
);

--DROP TABLE IF EXISTS course_enrollment;

ALTER TABLE course_enrollments
  ADD COLUMN enrolment_id SERIAL PRIMARY KEY,
  ADD COLUMN payment_status INTEGER DEFAULT 3,
  ADD COLUMN course_id INTEGER;
  ADD COLUMN enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE course_enrollments
  ADD CONSTRAINT fk_course_enrolment
	FOREIGN KEY (course_id)
	REFERENCES courses(course_id);

CREATE TABLE sessions (
  session_id SERIAL PRIMARY KEY,
  course_id INTEGER REFERENCES courses(course_id),
  session_number INTEGER NOT NULL,
  session_date DATE NOT NULL,
  session_time TIME NOT NULL,
  session_link TEXT
);

ALTER TABLE course_enrollments
  ADD COLUMN preferred_session_id INTEGER,
  ADD CONSTRAINT fk_preferred_session
    FOREIGN KEY (preferred_session_id)
    REFERENCES sessions(session_id);

ALTER TABLE course_enrollments
ADD CONSTRAINT unique_user_course_enrollment
UNIQUE (user_id, course_id);

ALTER TABLE user_roles
ADD CONSTRAINT unique_user_role
UNIQUE (user_id, role_id);
