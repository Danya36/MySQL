

/*
*Описание проекта
Youtube - модель базы данных, в которой пользователи могут регистрироваться, загружать и просматривать видео других пользователей.

Главная движущая сила – пользователи и их регистрационные данные (таблица users):
USERS
- Ник аккаунта, 
- Email, 
- Номер телефона, 
- Пароль.
А также в профиле user можно указывать дополнительную информацию (user profile):
- Аватар, 
- Имя, Фамилия, 
- Дата рождения, 
- Страна, 
- Несколько слов о себе, 
- Приватность аккаунта.
Также у пользователей есть видео, которые: 
- Располагаются в видеоальбоме, 
- Имеют тип, 
- Название,
- Хештэг,
- Описание,
- Дату выхода,
- Ограничения по возрасту.

ПОЛЬЗОВАТЕЛИ МОГУТ:
 - Действия с другими пользователями:
   1.Подписываться друг на друга
   2.Переписываться друг с другом

- Действия со списками:
   1. Добавлять фильмы в список «Буду смотреть»
   2. Отправлять фильмы в список «Просмотрено»

- Выражать свое мнение:
  1. Лайкать/дизлайкать видео,
  2. Оставлять комментарии под видео
**/


DROP DATABASE IF EXISTS `youtube`;
CREATE DATABASE `youtube`;
USE `youtube`;


--  1. Oписать модель хранения данных популярного веб-сайта YOUTUBE

-- пользователь

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	username VARCHAR(100) UNIQUE COMMENT 'Никнейм', 
	email VARCHAR(120) UNIQUE COMMENT 'Электронная почта',
	password_hash VARCHAR(255),
	phone BIGINT UNSIGNED COMMENT 'Номер телефона',
	registed_at TIMESTAMP DEFAULT now() COMMENT 'Дата регистрации',
	is_deleted BIT DEFAULT b'0',
	INDEX username_idx (username)
);


DROP TABLE IF EXISTS images;  -- Даны на выбор картинки, из них пользователи выбирают аватары.
CREATE TABLE images (
	id SERIAL PRIMARY KEY,
	filename VARCHAR(200) NOT NULL COMMENT 'Название картинки '
);


-- профиль пользователя

DROP TABLE IF EXISTS user_profiles;
CREATE TABLE user_profiles (
	user_id SERIAL PRIMARY KEY,
	avatar BIGINT UNSIGNED DEFAULT 1,
	first_name VARCHAR(100) COMMENT 'Имя',
	last_name VARCHAR(100) COMMENT 'Фамилия',
	gender ENUM ('m', 'f') COMMENT 'Пол',
	date_of_birth DATE COMMENT 'Дата рождения',
	country VARCHAR(100) COMMENT 'Страна',
	about VARCHAR(150) COMMENT 'О себе',

	is_private BIT DEFAULT 0,
	created_at DATETIME DEFAULT NOW(),

	INDEX user_name_idx (first_name, last_name),

	FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (avatar) REFERENCES images (id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- видеоальбомы пользователя

DROP TABLE IF EXISTS video_types;
CREATE TABLE video_types (
	id SERIAL PRIMARY KEY,
	`type` ENUM ('Shorts', 'Video', 'Broadcast', 'Unknown') DEFAULT NULL,
    created_at DATETIME DEFAULT NOW()
    
 );

-- видео пользователя 

DROP TABLE IF EXISTS  `video_albums`;
CREATE TABLE `video_albums` (
  id bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id bigint(20) UNSIGNED DEFAULT NULL,
  name VARCHAR (100), 
  
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE

 );



DROP TABLE IF EXISTS `videos`;
CREATE TABLE `videos` (
	id SERIAL PRIMARY KEY,
	user_id BIGINT unsigned NOT NULL,
	`video_type_id` BIGINT unsigned NOT NULL,
	`album_id` BIGINT unsigned NOT NULL,
	filename VARCHAR(100) COMMENT 'Названиие файла',
	tagline VARCHAR(100) COMMENT 'Тэг',
	description VARCHAR(100) COMMENT 'Описание',
	release_date DATE COMMENT 'Дата выхода',
	rars ENUM ('0+', '6+', '12+', '16+', '18+', 'NR') DEFAULT 'NR',

	INDEX (release_date),

	FOREIGN KEY (user_id) REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (album_id) REFERENCES video_albums(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (video_type_id) REFERENCES video_types (id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- подписки

DROP TABLE IF EXISTS subscriptions;
CREATE TABLE subscriptions (
	initiator_user_id BIGINT UNSIGNED NOT NULL,
	target_user_id BIGINT UNSIGNED NOT NULL,
	`status` ENUM ('signed', 'no signed'),
	requested_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE NOW(),

	INDEX (initiator_user_id),
	INDEX (target_user_id),
	
	PRIMARY KEY (initiator_user_id, target_user_id),
	FOREIGN KEY (initiator_user_id) REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (target_user_id) REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- сообщения

DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
	id SERIAL PRIMARY KEY,
	from_user_id BIGINT UNSIGNED,
	to_user_id BIGINT UNSIGNED,
	created_at TIMESTAMP DEFAULT now(),

	body_text TEXT NOT NULL,

	FOREIGN KEY (from_user_id) REFERENCES users (id) ON DELETE SET NULL ON UPDATE CASCADE,
	FOREIGN KEY (to_user_id) REFERENCES users (id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- мнения (likes, dislikes)

DROP TABLE IF EXISTS opinions;
CREATE TABLE opinions(
	user_id SERIAL PRIMARY KEY,
	videos_id BIGINT UNSIGNED NOT NULL,
    from_user_id BIGINT UNSIGNED,
    created_at DATETIME DEFAULT NOW(),
    `grade` ENUM ('Like', 'Dislike'),

    FOREIGN KEY (videos_id) REFERENCES videos (id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (from_user_id) REFERENCES users(id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- комментарии к видео

DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
	id SERIAL PRIMARY KEY,
	author_user_id BIGINT UNSIGNED,
	videos_id BIGINT UNSIGNED NOT NULL,
	body VARCHAR(500) NOT NULL,
	is_positive BIT DEFAULT 1,
	created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

	INDEX (is_positive),

	FOREIGN KEY (videos_id) REFERENCES videos(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (author_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- буду смотреть

DROP TABLE IF EXISTS watchlist;
CREATE TABLE watchlist (
	id SERIAL PRIMARY KEY,
	videos_id BIGINT UNSIGNED,
	user_id BIGINT UNSIGNED,
	is_seen BIT DEFAULT 0,
	created_at TIMESTAMP DEFAULT now(),
	updated_at TIMESTAMP DEFAULT now(),

	FOREIGN KEY (videos_id) REFERENCES videos (id) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- просмотрено

DROP TABLE IF EXISTS user_lists;
CREATE TABLE user_lists (
	user_id BIGINT UNSIGNED NOT NULL,
	videos_id BIGINT UNSIGNED NOT NULL,
	list_name VARCHAR(50) DEFAULT ' ',
	description VARCHAR(100) DEFAULT ' ',
	is_private BIT DEFAULT 0,
	created_at TIMESTAMP DEFAULT now(),

	INDEX (list_name),
	INDEX (is_private),
 
	PRIMARY KEY (user_id, videos_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (videos_id) REFERENCES videos(id) ON UPDATE CASCADE ON DELETE CASCADE
);
