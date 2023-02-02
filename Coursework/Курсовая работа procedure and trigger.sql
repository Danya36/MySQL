USE youtube;

/* 8. хранимые процедуры / триггеры; */


-- Процедура выведения всех видео, которые разрешены для детей.
		
DROP PROCEDURE IF EXISTS videos_for_kids;
DELIMITER //
CREATE PROCEDURE videos_for_kids(IN how_many INT)
BEGIN

	SELECT 
		filename ,
		(SELECT `type` FROM video_types WHERE id = videos.video_type_id) AS `video_type` ,
		 rars
	 FROM videos
	 WHERE (rars = '0+' OR rars = '6+' OR rars = '12+' ) AND rars != 'NR'
	 ORDER BY rand ()
	 LIMIT how_many;

END //
DELIMITER ;

CALL videos_for_kids(10);

 
 -- Триггер: 
 
 CREATE TRIGGER `check_email_before_adding` 
 BEFORE INSERT 
 ON `users` FOR EACH ROW 
 BEGIN  
	IF NEW.email IS NULL THEN 
	SIGNAL SQLSTATE '45000'
	  SET MESSAGE_TEXT = 'Добавьте email';
	END IF;	
END


INSERT INTO users (username, email, phone)
VALUES ('Tom', NULL, 7888888888);

-- не добавляется
 