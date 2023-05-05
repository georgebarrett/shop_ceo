TRUNCATE TABLE orders RESTART IDENTITY CASCADE; 



INSERT INTO orders (customer_name, date, item_id) VALUES ('Nate', '2012-11-04', 1);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Will', '2012-07-09', 2);