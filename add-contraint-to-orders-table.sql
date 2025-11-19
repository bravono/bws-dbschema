ALTER TABLE payments
DROP CONSTRAINT constraint_1,
ADD CONSTRAINT constraint_1
FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE;

-- Find duplicates
SELECT user_id, category_id, COUNT(*)
FROM orders
GROUP BY user_id, category_id
HAVING COUNT(*) > 1;

-- Optionally delete duplicates (keep one)
DELETE FROM orders
WHERE ctid NOT IN (
  SELECT MIN(ctid)
  FROM orders
  GROUP BY user_id, category_id
);
CREATE UNIQUE INDEX orders_user_category_idx ON orders(user_id, category_id);

ALTER TABLE payments
DROP CONSTRAINT constraint_1,
ADD CONSTRAINT constraint_1
FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE NO ACTION;