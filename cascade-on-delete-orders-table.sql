ALTER TABLE orders
DROP CONSTRAINT fk_projects_category1,
ADD CONSTRAINT fk_product_category1
FOREIGN KEY (category_id)
REFERENCES product_categories(category_id)
ON UPDATE CASCADE
ON DELETE CASCADE