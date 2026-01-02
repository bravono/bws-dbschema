ALTER TABLE IF EXISTS order_statuses
RENAME TO payment_statuses;

ALTER TABLE payment_statuses
DROP CONSTRAINT order_statuses_pkey;

ALTER TABLE payment_statuses
RENAME COLUMN order_status_id TO payment_status_id;

ALTER TABLE payment_statuses
ADD PRIMARY KEY (payment_status_id);

INSERT INTO payment_statuses
(payment_status_id, name) VALUES (7, 'overdue'), (8, 'refunded'), (9, 'cancelled');


