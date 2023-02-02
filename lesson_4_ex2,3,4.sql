

USE vk;


-- 2. Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке.


SELECT firstname FROM users GROUP BY firstname ORDER BY firstname;


-- 3. Первые пять пользователей пометить как удаленные.


-- Сделаем сначала все значения как "неудаленные"

UPDATE users
SET is_deleted = FALSE;


-- Теперь пометим как удаленных первых пяти пользователей
 
UPDATE users
SET is_deleted = TRUE
LIMIT 5;



-- 4. Написать скрипт, удаляющий сообщения «из будущего» (дата больше сегодняшней).


--  Поставим сообщению с id 4 дату из будущего

UPDATE messages
	SET created_at='2222-11-24 04:06:29'
	WHERE id = 4;

-- Удалим сообщение из будущего

DELETE FROM messages
WHERE created_at > now();


-- 5. Написать название темы курсового проекта.

-- Oписать модель хранения данных сайта Youtube








