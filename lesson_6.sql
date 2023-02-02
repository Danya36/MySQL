/* Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение. Агрегация данных”


1. Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.*/

USE vk;


SELECT 
	from_user_id,
	concat(u.firstname, ' ', u.lastname) as name,
	count(*) AS 'messages count'
FROM messages m
JOIN users u ON u.id = m.from_user_id
WHERE to_user_id = 1
GROUP BY from_user_id
ORDER BY count(*) DESC
LIMIT 1;



/*2. Подсчитать общее количество лайков, которые получили пользователи младше 12 лет. */

SELECT COUNT(*) AS likes_quantity
FROM likes
WHERE media_id in (SELECT id
                   FROM media
                   WHERE user_id in (SELECT user_id FROM profiles WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) < 12));
                  
                  

/* 3.Определить кто больше поставил лайков (всего): мужчины или женщины. */
                 
                  
SELECT gender,
	count(*)
FROM (SELECT user_id AS USER,
		(SELECT gender 
			FROM vk.profiles
			WHERE user_id = user ) AS gender
	FROM likes ) AS dummy
GROUP BY gender;                  
 