TRUNCATE TABLE items RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, unit_price, quantity) VALUES ('Cup', '4.99', 8);
INSERT INTO items (name, unit_price, quantity) VALUES ('Lamp', '9.98', 6);