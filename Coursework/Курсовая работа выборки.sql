USE youtube;

/* 6. скрипты характерных выборок (включающие группировки, JOIN'ы, вложенные таблицы);*/
 
-- Удаление подписок на самого себя

DELETE 
	FROM subscriptions 
	WHERE initiator_user_id = target_user_id;

/* Пробовала через ADD CHECK, но выходит ошибка, связанная с тем, 
 * что initiator_user_id и target_user_id - внешние ключи */

ALTER TABLE subscriptions
ADD CHECK (initiator_user_id <> target_user_id);

-- Выводим данные о 1 пользователe(никнейм, имя, фамилия, аватарка, email, общее количество видео)

SELECT 
	(SELECT username FROM users WHERE id = user_id) AS username, 
	first_name,
	last_name,
	(SELECT email  FROM users WHERE id = user_id) AS email,
	(SELECT filename FROM images WHERE user_id = id ) AS avatar,
	(SELECT COUNT(*) FROM videos WHERE user_id = 1) AS total_videos
FROM user_profiles 
WHERE user_id = 1;


 -- Вce видеозаписи пользователя с id=5

SELECT 
	v.user_id,
	filename, 
	release_date,
	rars,
	vt.`type` AS video_type,
	va.name AS video_album 
FROM videos v
	JOIN video_types vt ON v.video_type_id = vt.id
	RIGHT JOIN video_albums va ON v.album_id = va.id  
WHERE v.user_id = 1
ORDER BY release_date;

 -- Найти все видео из одной страны (Korea)
 
SELECT 
	v.user_id,
	v.filename
FROM user_profiles up
     JOIN videos v  ON up.user_id = v.user_id 
WHERE country = 'Korea';

-- 5 пользователя с наибольшим количеством сообщений другим пользователям

SELECT 
	username,
	COUNT(*) AS message_count
  FROM users u
    JOIN messages m ON u.id = m.from_user_id
  GROUP BY u.id
  ORDER BY message_count DESC
  LIMIT 5;

-- Количество видео каждого типа
 
SELECT 
  COUNT(*),
  (SELECT `type` FROM video_types WHERE id = videos.video_type_id ) AS 'video type'
FROM videos 
GROUP BY video_type_id;

-- Список видео пользователей с количеством дизлайков.

SELECT 
	v.filename,
	COUNT(*) AS total_dislikes,
	CONCAT (up.first_name, ' ', up.last_name) AS owner
	FROM videos v
	JOIN users u ON u.id = v.user_id
	JOIN user_profiles up ON u.id = up.user_id 
	JOIN opinions o ON o.videos_id = v.id WHERE grade = 'Dislike'
GROUP BY v.id
ORDER BY total_dislikes DESC;


-- Какое количество видео (в среднем) у пользователей:

SELECT AVG(total_videos) AS average_videos
  FROM (
    SELECT u.username, COUNT(*) AS total_videos
	  	FROM users u
	    JOIN videos v  ON u.id = v.user_id 
	  GROUP BY u.id
	  ORDER BY total_videos DESC
  ) AS list;
  
 
 

