-- Homework 5_1

DROP DATABASE IF EXISTS shop;
CREATE DATABASE IF NOT EXISTS shop;

USE shop;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL,
  name VARCHAR(255),
  birthday_at DATE,
  created_at VARCHAR (255),
  updated_at VARCHAR (255)
);

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');
  


-- 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

UPDATE users 
	SET 
		created_at = NOW(), 	
		updated_at = NOW();
	

/* Задача №2. Таблица users была неудачно спроектирована.
   Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10".
   Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
*/

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL,
  name VARCHAR(255),
  birthday_at DATE,
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
);

INSERT INTO users (name, birthday_at, created_at, updated_at) VALUES
  ('Геннадий', '1990-10-05', '07.01.2019 13:10', '07.01.2019 13:10'),
  ('Наталья', '1984-11-12', '20.05.2018 17:35', '20.05.2018 17:35'),
  ('Александр', '1985-05-20', '14.08.2019 20:05', '14.08.2019 20:05'),
  ('Сергей', '1988-02-14', '21.10.2017 10:20', '21.10.2017 10:20'),
  ('Иван', '1998-01-12', '15.12.2016 13:45', '15.12.2016 13:45'),
  ('Мария', '1992-08-29', '12.01.2017 8:35', '12.01.2017 8:35');

UPDATE users
	SET
		created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'),
		updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i');

ALTER TABLE users
	CHANGE
		created_at created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	CHANGE
		updated_at updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

	
/* Задача №3. В таблице складских запасов 0 в поле value могут встречаться самые разные цифры: 
 * 0, если товар закончился и выше нуля, если на складе имеются запасы. 
 * Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value.
 * Однако нулевые запасы должны выводиться в конце, после всех записей.
*/

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO storehouses_products (storehouse_id, product_id, value) VALUES
  (1, 540, 0),
  (1, 790, 2500),
  (1, 3430, 0),
  (1, 820, 30),
  (1, 720, 500),
  (1, 640, 1);
 
SELECT value FROM storehouses_products
	ORDER BY value = 0, value;


/* Задание №4
Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
Месяцы заданы в виде списка английских названий (may, august) */

SELECT name, birthday_at FROM users 
WHERE DATE_FORMAT(birthday_at, '%M') IN ('may', 'august');


/* Задание 5
  (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. 
  SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
  Отсортируйте записи в порядке, заданном в списке IN. */

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL,
  name VARCHAR(255),
  UNIQUE unique_name(name(10))
);

INSERT INTO catalogs (id, name) VALUES
  (1, 'Процессоры'),
  (2, 'Материнские платы'),
  (5, 'Видеокарты');


 SELECT id, name FROM catalogs WHERE id IN (5, 1, 2)

 ORDER BY FIELD(id, 5, 1, 2);

