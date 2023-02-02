-- Homework 7

USE shop;

/* Задача №1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет-магазине. */

/* Так как таблица orders и orders_products пусты, добавил несколько записей */

INSERT INTO orders (user_id) SELECT id FROM users WHERE name = 'Геннадий';
INSERT INTO orders_products (order_id, product_id, total)
	SELECT LAST_INSERT_ID(), id, 2 FROM products WHERE name = 'Intel Core i5-7400';

INSERT INTO orders (user_id) SELECT id FROM users WHERE name = 'Наталья';
INSERT INTO orders_products (order_id, product_id, total)
	SELECT LAST_INSERT_ID(), id, 1 FROM products WHERE name IN ('Intel Core i5-7400', 'Gigabyte H310M S2H');

INSERT INTO orders (user_id) SELECT id FROM users WHERE name = 'Иван';
INSERT INTO orders_products (order_id, product_id, total)
	SELECT LAST_INSERT_ID(), id, 1 FROM products WHERE name IN ('AMD FX-8320', 'ASUS ROG MAXIMUS X HERO');
	

/* С использованием JOIN */

 SELECT DISTINCT users.id, users.name
FROM users
         INNER JOIN orders ON users.id = user_id;
         
/* С использованием FROM, WHERE */
        
SELECT id, name
	FROM users
	WHERE id IN (SELECT DISTINCT user_id FROM orders);
    
        
/*2. Выведите список товаров products и разделов catalogs, который соответствует товару.*/
 
/* С использованием JOIN */

SELECT products.name, catalogs.name
FROM products
         INNER JOIN catalogs ON products.catalog_id = catalogs.id; 
         
/* С использованием FROM, WHERE */
        
 SELECT name,
	(SELECT name FROM catalogs WHERE id = products.catalog_id) AS catalogs
FROM products;

/* 3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
 * Поля from, to и label содержат английские названия городов, поле name — русское. 
 * Выведите список рейсов flights с русскими названиями городов.*/

DROP TABLE IF EXISTS flights;
CREATE TABLE IF NOT EXISTS flights (
	id SERIAL PRIMARY KEY,
	`from` VARCHAR(255) COMMENT 'Город отправления',
	`to` VARCHAR(255) COMMENT 'Город прибытия'
) COMMENT = 'Рейсы';

INSERT INTO flights (`from`, `to`) VALUES
	('moscow', 'omsk'),
	('nowgorod', 'kazan'),
	('irkutsk', 'moscow'),
	('omsk', 'irkutsk'),
	('moscow', 'kazan');
	
DROP TABLE IF EXISTS cities;
CREATE TABLE IF NOT EXISTS cities (
	label VARCHAR(255) UNIQUE
		COMMENT 'Код города',
	name VARCHAR(255) UNIQUE
		COMMENT 'Название города'
) COMMENT = 'Словарь городов';

INSERT INTO cities (label, name) VALUES
	('moscow', 'Москва'),
	('irkutsk', 'Иркутск'),
	('nowgorod', 'Новгород'),
	('kazan', 'Казань'),
	('omsk', 'Омск');


/* С использованием JOIN */

SELECT id, `from`.name, `to`.name
FROM flights
         INNER JOIN cities as `from` ON flights.from = `from`.label
         INNER JOIN cities as `to` ON flights.to = `to`.label;
        
 

/* С использованием FROM, WHERE */
        
SELECT id,
	(SELECT name FROM cities WHERE label = flights.from) AS `from`,
	(SELECT name FROM cities WHERE label = flights.to) AS `to`
FROM flights;
