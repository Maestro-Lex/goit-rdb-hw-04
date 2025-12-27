-- 1 --

CREATE SCHEMA IF NOT EXISTS LibraryManagement;

USE LibraryManagement;

CREATE TABLE IF NOT EXISTS authors
(
	author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(45) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT = 1;
	
CREATE TABLE IF NOT EXISTS genres
(
	genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(45) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS books
(
	book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(45) NOT NULL,
    publication_year YEAR NOT NULL,
    author_id INT NOT NULL,
    genre_id INT NOT NULL,
    FOREIGN KEY (author_id) REFERENCES authors(author_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
) ENGINE=InnoDB AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS users
(
	user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(45) NOT NULL,
    email VARCHAR(45) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS borrowed_books
(
	borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    user_id INT NOT NULL,
    borrow_date DATE NOT NULL,
    return_date DATE NOT NULL,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
) ENGINE=InnoDB AUTO_INCREMENT = 1;

-- 2 --

INSERT INTO authors(author_name)
VALUES
("John Tolkien"),
("Alexandre Dumas");

INSERT INTO genres(genre_name)
VALUES
("Fantasy"),
("Adventure");

INSERT INTO books(title, publication_year, author_id, genre_id)
VALUES
("The Lord of the Rings", 1999, 1, 1),
("The Graph Monte Cristo", 2005, 2, 2);

INSERT INTO users(username, email)
VALUES
("Alex", "alex@mail.com"),
("Boris", "boris@mail.com");

INSERT INTO borrowed_books(book_id, user_id, borrow_date, return_date)
VALUES
(1, 1, "2025-01-20", "2025-11-17"),
(2, 2, "2025-03-15", "2025-12-23");

SELECT * FROM authors;
SELECT * FROM genres;
SELECT * FROM books;
SELECT * FROM users;
SELECT * FROM borrowed_books;

-- 3 --

USE hw_3;

SELECT *
FROM order_details
	INNER JOIN orders ON orders.id = order_details.order_id
	INNER JOIN customers ON customers.id = orders.customer_id
    INNER JOIN products ON products.id = order_details.product_id
    INNER JOIN categories ON categories.id = products.category_id
    INNER JOIN employees ON employees.employee_id = orders.employee_id
    INNER JOIN shippers ON shippers.id = orders.shipper_id
    INNER JOIN suppliers ON suppliers.id = products.supplier_id
 ;
 
-- 4 --

-- 4.1 --
SELECT COUNT(*)
FROM order_details
	INNER JOIN orders ON orders.id = order_details.order_id
	INNER JOIN customers ON customers.id = orders.customer_id
    INNER JOIN products ON products.id = order_details.product_id
    INNER JOIN categories ON categories.id = products.category_id
    INNER JOIN employees ON employees.employee_id = orders.employee_id
    INNER JOIN shippers ON shippers.id = orders.shipper_id
    INNER JOIN suppliers ON suppliers.id = products.supplier_id
;

-- 4.2 --
SELECT COUNT(*)
FROM order_details
	INNER JOIN orders ON orders.id = order_details.order_id
	LEFT JOIN customers ON customers.id = orders.customer_id
    RIGHT JOIN products ON products.id = order_details.product_id
    INNER JOIN categories ON categories.id = products.category_id
    LEFT JOIN employees ON employees.employee_id = orders.employee_id
    RIGHT JOIN shippers ON shippers.id = orders.shipper_id
    INNER JOIN suppliers ON suppliers.id = products.supplier_id
;
SELECT COUNT(*)
FROM order_details
	RIGHT JOIN orders ON orders.id = order_details.order_id
	RIGHT JOIN customers ON customers.id = orders.customer_id
    LEFT JOIN products ON products.id = order_details.product_id
    LEFT JOIN categories ON categories.id = products.category_id
    LEFT JOIN employees ON employees.employee_id = orders.employee_id
    LEFT JOIN shippers ON shippers.id = orders.shipper_id
    LEFT JOIN suppliers ON suppliers.id = products.supplier_id
;

-- 4.3 --

SELECT *
FROM order_details
	INNER JOIN orders ON orders.id = order_details.order_id
	INNER JOIN customers ON customers.id = orders.customer_id
    INNER JOIN products ON products.id = order_details.product_id
    INNER JOIN categories ON categories.id = products.category_id
    INNER JOIN employees ON employees.employee_id = orders.employee_id
    INNER JOIN shippers ON shippers.id = orders.shipper_id
    INNER JOIN suppliers ON suppliers.id = products.supplier_id
WHERE employees.employee_id > 3 AND employees.employee_id <= 10;
 
-- 4.4 --
 
SELECT
	categories.name AS category,
    COUNT(categories.name) AS count,
    AVG(order_details.quantity) AS avg_quantity
FROM order_details
	INNER JOIN orders ON orders.id = order_details.order_id
	INNER JOIN customers ON customers.id = orders.customer_id
    INNER JOIN products ON products.id = order_details.product_id
    INNER JOIN categories ON categories.id = products.category_id
    INNER JOIN employees ON employees.employee_id = orders.employee_id
    INNER JOIN shippers ON shippers.id = orders.shipper_id
    INNER JOIN suppliers ON suppliers.id = products.supplier_id
WHERE employees.employee_id > 3 AND employees.employee_id <= 10
GROUP BY categories.name;
 
-- 4.5 --
 
SELECT
	categories.name AS category,
    COUNT(categories.name) AS count,
    AVG(order_details.quantity) AS avg_quantity
FROM order_details
	INNER JOIN orders ON orders.id = order_details.order_id
	INNER JOIN customers ON customers.id = orders.customer_id
    INNER JOIN products ON products.id = order_details.product_id
    INNER JOIN categories ON categories.id = products.category_id
    INNER JOIN employees ON employees.employee_id = orders.employee_id
    INNER JOIN shippers ON shippers.id = orders.shipper_id
    INNER JOIN suppliers ON suppliers.id = products.supplier_id
WHERE employees.employee_id > 3 AND employees.employee_id <= 10
GROUP BY categories.name
HAVING avg_quantity > 21;

-- 4.6 --
 
SELECT
	categories.name AS category,
    COUNT(categories.name) AS count,
    AVG(order_details.quantity) AS avg_quantity
FROM order_details
	INNER JOIN orders ON orders.id = order_details.order_id
	INNER JOIN customers ON customers.id = orders.customer_id
    INNER JOIN products ON products.id = order_details.product_id
    INNER JOIN categories ON categories.id = products.category_id
    INNER JOIN employees ON employees.employee_id = orders.employee_id
    INNER JOIN shippers ON shippers.id = orders.shipper_id
    INNER JOIN suppliers ON suppliers.id = products.supplier_id
WHERE employees.employee_id > 3 AND employees.employee_id <= 10
GROUP BY categories.name
HAVING avg_quantity > 21
ORDER BY count DESC;

-- 4.7 --
 
SELECT
	categories.name AS category,
    COUNT(categories.name) AS count,
    AVG(order_details.quantity) AS avg_quantity
FROM order_details
	INNER JOIN orders ON orders.id = order_details.order_id
	INNER JOIN customers ON customers.id = orders.customer_id
    INNER JOIN products ON products.id = order_details.product_id
    INNER JOIN categories ON categories.id = products.category_id
    INNER JOIN employees ON employees.employee_id = orders.employee_id
    INNER JOIN shippers ON shippers.id = orders.shipper_id
    INNER JOIN suppliers ON suppliers.id = products.supplier_id
WHERE employees.employee_id > 3 AND employees.employee_id <= 10
GROUP BY categories.name
HAVING avg_quantity > 21
ORDER BY count DESC
LIMIT 4 OFFSET 1;