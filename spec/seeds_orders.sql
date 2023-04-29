TRUNCATE TABLE orders RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO orders (customer_name, date, item_id) VALUES ('Nate', '2012-11-04', 1);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Will', '2012-07-09', 2);