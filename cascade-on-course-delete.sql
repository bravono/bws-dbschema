ALTER TABLE sessions
DROP CONSTRAINT sessions_course_id_fkey,
ADD CONSTRAINT sessions_course_id_fkey
FOREIGN KEY (course_id)
REFERENCES courses (course_id)
ON UPDATE CASCADE
ON DELETE CASCADE;