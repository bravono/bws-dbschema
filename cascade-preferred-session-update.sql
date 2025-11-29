ALTER TABLE course_enrollments
DROP CONSTRAINT fk_preferred_session,
ADD CONSTRAINT fk_preferred_session
FOREIGN KEY (preferred_session_id)
REFERENCES sessions(session_id)
ON UPDATE CASCADE
ON DELETE CASCADE;