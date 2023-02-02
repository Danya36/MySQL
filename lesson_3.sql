-- CREATE, ALTER, DROP 

DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;
USE vk;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
	firstname VARCHAR(100),
	lastname VARCHAR(100) COMMENT 'Фамилия', -- COMMENT, если имя неочевидное
	email VARCHAR(120) UNIQUE,
	password_hash VARCHAR(100),
	phone BIGINT UNSIGNED,
	is_deleted BIT DEFAULT b'0',
	INDEX users_lastname_firstname_idx (lastname, firstname)
);


-- 1-1
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
	user_id SERIAL PRIMARY KEY,
	gender CHAR(1),
	birthday DATE,
	photo_id BIGINT UNSIGNED,
	video_id BIGINT UNSIGNED,
	created_at DATETIME DEFAULT NOW()
);

ALTER TABLE profiles ADD CONSTRAINT fk_user_id
FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE;



-- 1-M 
DROP TABLE IF EXISTS messages;
CREATE TABLE messages(
	id SERIAL PRIMARY KEY,
	from_user_id BIGINT UNSIGNED NOT NULL, -- отправитель
	to_user_id BIGINT UNSIGNED NOT NULL, -- получатель
	body TEXT,
	created_at DATETIME DEFAULT NOW(),
	FOREIGN KEY (from_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (to_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);


DROP TABLE IF EXISTS friends_requests;
CREATE TABLE friends_requests (
	-- id SERIAL,
	initiator_user_id BIGINT UNSIGNED NOT NULL,
	target_user_id BIGINT UNSIGNED NOT NULL,
	`status` ENUM ('requested', 'approved', 'declined', 'unfriended'),
	requested_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE NOW(),
	PRIMARY KEY (initiator_user_id, target_user_id),
	FOREIGN KEY(initiator_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(target_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- M-M

DROP TABLE IF EXISTS communities;
CREATE TABLE communities(
	id SERIAL PRIMARY KEY,
	name VARCHAR(150),
	INDEX communities_name_idx(name)
);


DROP TABLE IF EXISTS users_communities;
CREATE TABLE users_communities(
	user_id BIGINT UNSIGNED NOT NULL,
	community_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (user_id, community_id),  
	FOREIGN KEY(user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(community_id) REFERENCES communities(id) ON UPDATE CASCADE ON DELETE CASCADE
);


DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


DROP TABLE IF EXISTS media;
CREATE TABLE media(
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	body TEXT,
	media_type_id BIGINT UNSIGNED NOT NULL, 
	-- filename BLOB,
	filename VARCHAR(255),
	`size` INT,
	-- metadata JSON,
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	
	FOREIGN KEY(user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(media_type_id) REFERENCES media_types(id) ON UPDATE CASCADE ON DELETE CASCADE
);


DROP TABLE IF EXISTS likes;
CREATE TABLE likes(
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	media_id BIGINT UNSIGNED NOT NULL, 
	created_at DATETIME DEFAULT NOW(),
	FOREIGN KEY(user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(media_id) REFERENCES media(id) ON UPDATE CASCADE ON DELETE CASCADE
);



DROP TABLE IF EXISTS photo_albums ;
CREATE TABLE photo_albums (
	`id` SERIAL,
	`name` VARCHAR(255) DEFAULT NULL,
	`user_id` BIGINT UNSIGNED NOT NULL,
	
	FOREIGN KEY(user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY (`id`)
);



DROP TABLE IF EXISTS `photos`;
CREATE TABLE `photos`(
	id SERIAL PRIMARY KEY,
	`album_id` BIGINT UNSIGNED NOT NULL,
	`media_id` BIGINT UNSIGNED NOT NULL,
	
	FOREIGN KEY(album_id) REFERENCES photo_albums(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(media_id) REFERENCES media(id) ON UPDATE CASCADE ON DELETE CASCADE
);



ALTER TABLE `profiles` ADD CONSTRAINT fk_photo_id
FOREIGN KEY (photo_id) REFERENCES photos(id) ON UPDATE CASCADE ON DELETE CASCADE;




-- HOMEWORK LESSON № 3

-- Таблица 1 (вероятно тип 1-1)

DROP TABLE IF EXISTS activity_status ; -- COMMENT = 'Статус активности пользователей';
CREATE TABLE activity_status ( 
	user_id SERIAL PRIMARY KEY,
	`activity status` ENUM('Online', 'Offline'),
	created_at DATETIME DEFAULT NOW(), -- Дата создания, для отслеживания времени последней активности
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
     
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Таблица 2 (вероятно тип M-M)

DROP TABLE IF EXISTS video_albums ;  -- COMMENT = 'Видеоальбом';
CREATE TABLE video_albums (
	`id` SERIAL,
	`name` VARCHAR(255) DEFAULT NULL,
	`user_id` BIGINT UNSIGNED NOT NULL,
	
	FOREIGN KEY(user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `videos`;
CREATE TABLE `videos` (
	id SERIAL PRIMARY KEY,
	`album_id` BIGINT unsigned NOT NULL,
	`media_id` BIGINT unsigned NOT NULL,
	FOREIGN KEY (album_id) REFERENCES video_albums(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (media_id) REFERENCES media(id) ON UPDATE CASCADE ON DELETE CASCADE
);


ALTER TABLE `profiles` ADD CONSTRAINT fk_video_id
    FOREIGN KEY (video_id) REFERENCES videos(id) ON UPDATE CASCADE ON DELETE set NULL;

-- Таблица 3 (вероятно тип 1-M)
   
DROP TABLE IF EXISTS apps;  -- COMMENT = 'Приложения';
CREATE TABLE apps(
	id SERIAL PRIMARY KEY,
	name VARCHAR(150) DEFAULT NULL,
	is_free ENUM('free', 'paid'),
	apps_user_id BIGINT unsigned NOT NULL,
	INDEX apps_name_idx(name),
	FOREIGN KEY (apps_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS users_apps;
CREATE TABLE users_apps(
	user_id BIGINT UNSIGNED NOT NULL,
	apps_id BIGINT UNSIGNED NOT NULL,

	PRIMARY KEY (user_id, apps_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (apps_id) REFERENCES apps(id) ON UPDATE CASCADE ON DELETE CASCADE
);



