
-- Homework 5_2

USE shop;

/* Задача №1. Подсчитайте средний возраст пользователей в таблице users. */

SELECT AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) AS age FROM users;

/* Задача №2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
   Следует учесть, что необходимы дни недели текущего года, а не года рождения. */

SELECT DAYNAME(DATE_FORMAT(birthday_at, '2022-%m-%d')) as `day`,
       count(*)
from users
GROUP BY day;

/* Задача №3. Подсчитайте произведение чисел в столбце таблицы. */

SELECT ROUND(EXP(SUM(LN(id)))) FROM users WHERE id < 6;