-- Homework 9


USE shop;

/* 1.В базе данных shop и sample присутствуют одни  и те же таблицы, учебной базы данных. 
 *Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.*/


START TRANSACTION;
INSERT INTO sample.users
SELECT * FROM shop.users
LIMIT 1;
DELETE from shop.users
WHERE id = 1
LIMIT 1;
COMMIT;

/* 2. Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.*/

CREATE OR REPLACE VIEW prdcts (name, category) AS
SELECT products.name, c.name
FROM products
         LEFT JOIN catalogs AS c ON c.id = products.catalog_id;

SHOW tables;
SELECT * FROM prdcts;


# Создайте двух пользователей которые имеют доступ к базе данных shop. Первому пользователю shop_read должны быть
# доступны только запросы на чтение данных, второму пользователю shop — любые операции в пределах базы данных shop.

DROP USER IF EXISTS 'shop_read';
CREATE USER 'shop_read' IDENTIFIED WITH sha256_password BY 'pass';
GRANT SELECT ON shop.* TO shop_read;
SHOW GRANTS FOR shop_read;

DROP USER IF EXISTS 'shop';
CREATE USER 'shop' IDENTIFIED WITH sha256_password BY 'pass';
GRANT ALL ON shop.* TO 'shop';
GRANT GRANT OPTION ON shop.* TO 'shop';
SHOW GRANTS FOR shop;