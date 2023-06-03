/* 1. Создайте представление, в которое попадет информация о пользователях (имя, фамилия,
город и пол), которые не старше 20 лет. */

CREATE OR REPLACE VIEW info AS
SELECT
	firstname,
    	lastname,
    	hometown,
    	gender
FROM users
JOIN profiles ON users.id = profiles.user_id
WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) < 20;

SELECT * FROM info;

/* 2. Найдите кол-во, отправленных сообщений каждым пользователем и выведите
ранжированный список пользователей, указав имя и фамилию пользователя, количество
отправленных сообщений и место в рейтинге (первое место у пользователя с максимальным
количеством сообщений) . (используйте DENSE_RANK) */

SELECT 
	DENSE_RANK() OVER (ORDER BY COUNT(from_user_id) DESC) rating,
	COUNT(from_user_id) ammount,
	CONCAT(firstname, ' ', lastname) user
FROM users u
JOIN messages m ON u.id = m.from_user_id
GROUP BY u.id;

/* 3. Выберите все сообщения, отсортируйте сообщения по возрастанию даты отправления
(created_at) и найдите разницу дат отправления между соседними сообщениями,
получившегося списка. (используйте LEAD или LAG) */

SELECT 
	*, 
	TIMESTAMPDIFF(MINUTE, LAG(created_at, 1) OVER (ORDER BY created_at ASC), created_at) difference_in_minutes
FROM messages 
ORDER BY created_at ASC;
