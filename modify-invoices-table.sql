ALTER TABLE invoices
DROP COLUMN IF EXISTS duedate,
DROP COLUMN IF EXISTS status,
ADD COLUMN due_date DATE,
ADD COLUMN payment_status_id SMALLINT,
ADD COLUMN user_id INT,
ADD CONSTRAINT fk_payment_status FOREIGN KEY (payment_status_id) REFERENCES payment_statuses(payment_status_id),
ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(user_id);

