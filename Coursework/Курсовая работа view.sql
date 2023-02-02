/* 7. представления (минимум 2);*/
 -- Представление: Топ 3 пользователя с наибольшим количеством лайков за видео

USE youtube;

DROP VIEW IF EXISTS top_users;
CREATE OR REPLACE VIEW top_users
AS
SELECT 
	username,
	COUNT(*) as likes_count
  FROM users
    JOIN videos ON users.id = videos.user_id
    JOIN opinions ON opinions.videos_id = videos.id WHERE grade = 'Like'
  GROUP BY users.id
  ORDER BY likes_count DESC
  LIMIT 3;

 
 SELECT username, likes_count FROM top_users;
 



-- Представление: Информация о видео: количество просмотров, сколько раз добавляли в лист "Буду смотеть" или в лист "Просмотрено".

CREATE OR REPLACE VIEW video_info
AS
	SELECT v.id AS video_id,
		   filename,
		   seen.c AS was_seen,
		   to_w.c AS on_watchlist,
		   uli.c AS on_user_lists,
		   v.release_date,
		   v.rars,
		   v.tagline
	FROM videos AS v
			 
			   LEFT JOIN (SELECT COUNT(is_seen) AS c,
								 videos_id
							FROM watchlist
						   WHERE is_seen = 1
						   GROUP BY videos_id
						 ) seen ON seen.videos_id = v.id
			   LEFT JOIN (SELECT COUNT(is_seen) AS c,
								 videos_id
							FROM watchlist
						   WHERE is_seen = 0
						   GROUP BY videos_id
						 ) to_w ON to_w.videos_id = v.id
			   LEFT JOIN (SELECT COUNT(list_name) AS c,
								 videos_id
							FROM user_lists
						   GROUP BY videos_id
						 ) uli ON v.id = uli.videos_id
			   
	 ORDER BY
		 v.id;

SELECT video_id, filename, was_seen, on_watchlist, on_user_lists, release_date, rars, tagline FROM video_info;


-- Представление: Информация о пользователе (имя, фамилия, телефон, email, дата рождения, возраст, пол, приватность, подписки, подписчики, страну, аватар, о пользователе, видео в листе "Буду смотреть", "Просмотренные", сколько списков)

CREATE OR REPLACE VIEW user_info AS
	SELECT u.id AS u_id,
		   CONCAT_WS (' ', up.first_name, up.last_name) AS name,
		   u.username,
		   u.phone,
		   u.email,
		   up.date_of_birth,
		   TIMESTAMPDIFF(YEAR, up.date_of_birth, NOW()) AS age,
		   CASE (up.gender)
			   WHEN 'm' THEN 'male'
			   WHEN 'f' THEN 'female'
			   END AS gender,
		   CASE (up.is_private)
			   WHEN 1 THEN 'private'
			   WHEN 0 THEN 'public'
			   END AS account,
		   sub_i.c AS subscribers,
		   sub_t.c AS followers,
		   up.country,
		   up.avatar,
		   up.about,
		   to_w.c AS to_watch,
		   seen.c AS was_seen,
		   ul.lists
	  FROM users u
			   LEFT JOIN user_profiles up ON u.id = up.user_id
			   LEFT JOIN (SELECT COUNT((initiator_user_id)) AS c,
								 initiator_user_id
							FROM subscriptions sub WHERE status = 'signed'
						   GROUP BY initiator_user_id
						 ) sub_i ON u.id = sub_i.initiator_user_id
			   LEFT JOIN (SELECT COUNT((target_user_id)) AS c, 
								 target_user_id
							FROM subscriptions sub  WHERE status = 'signed'
						   GROUP BY target_user_id
						 ) sub_t ON u.id = sub_t.target_user_id
			   LEFT JOIN (SELECT user_id,
								 COUNT(videos_id) AS c
							FROM watchlist
						   WHERE is_seen = 0
						   GROUP BY user_id
						 ) to_w ON u.id = to_w.user_id
			   LEFT JOIN (SELECT user_id,
								 COUNT(videos_id) AS c
							FROM watchlist
						   WHERE is_seen = 1
						   GROUP BY user_id
						 ) seen ON u.id = seen.user_id
			   LEFT JOIN (SELECT count(list_name) AS lists,
								 user_id
							FROM user_lists
						   GROUP BY user_id
						 ) ul ON u.id = ul.user_id
			  
	 ORDER BY
		 u.id;
		 
SELECT u_id, name, username, phone, email, date_of_birth, age, gender, account, subscribers, followers, country, avatar, about, to_watch, was_seen, lists FROM user_info
WHERE u_id = 10;

