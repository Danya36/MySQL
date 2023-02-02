 /* 
 Lesson 2 
 
 -- 1.  Создайте в домашней директории файл .my.cnf, задав в нем логин и пароль, который указывался при установке.
  Файл создан, вход в MySQL происходит только по паролю без использования mysql -u root -p. Я так поняла - этого и добивались
 */
 
-- 2. Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name.    
CREATE DATABASE example;
CREATE DATABASE sample;
USE example;
CREATE TABLE users (id SERIAL PRIMARY KEY, name VARCHAR(255) COMMENT 'Имя пользователя');


-- 3. Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа в новую базу данных sample.
/* mysqldump example > sample.sql
mysql sample < sample.sql  */

SHOW DATABASES;
DESCRIBE sample.users;

/* 4. (по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump. Создайте дамп единственной таблицы help_keyword 
    базы данных mysql. Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.
    
mysqldump -u root -p --opt --where="1 limit 100" mysql help_keyword > first_100_rows_help_keyword.sql