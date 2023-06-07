/* 1. Создайте таблицу users_old, аналогичную таблице users. Создайте процедуру, с
помощью которой можно переместить любого (одного) пользователя из таблицы
users в таблицу users_old. (использование транзакции с выбором commit или rollback
– обязательно). */

DROP TABLE IF EXISTS users_old;
CREATE TABLE users_old (
	id SERIAL PRIMARY KEY, 
    	firstname varchar(50), 
   	lastname varchar(50), 
    	email varchar(120)
);
DELIMITER //
DROP PROCEDURE IF EXISTS to_users_old;
CREATE PROCEDURE  to_users_old (u_id INT) 
BEGIN
INSERT INTO users_old (firstname, lastname, email) 
	SELECT firstname, lastname, email 
	FROM users 
	WHERE users.id = u_id;
COMMIT;
END//

DELIMITER ;

CALL to_users_old(3);
SELECT * FROM users_old;

/* 2. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в
зависимости от текущего времени суток. С 6:00 до 12:00 функция должна
возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать
фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй
ночи". */

DROP FUNCTION IF EXISTS hello;
DELIMITER //
CREATE FUNCTION hello() 
	RETURNS VARCHAR(20) READS SQL DATA
BEGIN
DECLARE privet VARCHAR(20);
SET privet = CASE
	WHEN CURRENT_TIME() BETWEEN '06:00:00' AND '11:59:59' THEN 'Доброе утро'
	WHEN CURRENT_TIME() BETWEEN '12:00:00' AND '17:59:59' THEN 'Добрый день'
	WHEN CURRENT_TIME() BETWEEN '18:00:00' AND '23:59:59' THEN 'Добрый вечер'
	WHEN CURRENT_TIME() BETWEEN '00:00:00' AND '05:59:59' THEN 'Доброй ночи'
END;
RETURN privet;
END//

DELIMITER ;

SELECT hello();
