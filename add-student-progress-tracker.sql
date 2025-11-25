CREATE TABLE student_sessions (
  student_session_id SERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  session_id INT NOT NULL,
  finished BOOLEAN DEFAULT FALSE,
  completed_at TIMESTAMP NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (session_id) REFERENCES sessions(session_id) ON DELETE CASCADE,
  UNIQUE (user_id, session_id)
);

CREATE INDEX idx_student_sessions_user_id ON student_sessions(user_id);
CREATE INDEX idx_student_sessions_session_id ON student_sessions(session_id);
CREATE INDEX idx_student_sessions_finished ON student_sessions(finished);


CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON student_sessions
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();