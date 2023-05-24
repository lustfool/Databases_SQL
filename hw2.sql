-- 1. Используя операторы языка SQL, создайте табличку “sales”. Заполните ее данными

CREATE TABLE sales
(
	id SERIAL PRIMARY KEY,
    order_date DATE NOT NULL,
    count_product INT NOT NULL
);
INSERT INTO sales (order_date, count_product)
VALUES
('2022-01-01', 156),
('2022-01-02', 180),
('2022-01-03', 21),
('2022-01-04', 124),
('2022-01-05', 341);

/*2. Для данных таблицы “sales” укажите тип заказа в зависимости от кол-ва :
меньше 100 - Маленький заказ
от 100 до 300 - Средний заказ
больше 300 - Большой заказ
*/

SELECT id AS 'id заказа',
CASE 
	 WHEN count_product < 100 THEN 'Маленький заказ' 
	 WHEN count_product BETWEEN 100 AND 300 THEN 'Средний заказ' 
	 ELSE 'Большой заказ' 
END AS 'Тип заказа'
FROM sales;

-- 3. Создайте таблицу “orders”, заполните ее значениями

CREATE TABLE orders
(
	id SERIAL PRIMARY KEY,
    employee_id VARCHAR(5) NOT NULL,
    amount DECIMAL(6,2) NOT NULL,
    order_status VARCHAR(10) NOT NULL
);
INSERT INTO orders (employee_id, amount, order_status)
VALUES
('e03', 15.00, 'OPEN'),
('e01', 25.50, 'OPEN'),
('e05', 100.70, 'CLOSED'),
('e02', 22.18, 'OPEN'),
('e04', 9.50, 'CANCELLED');

/* Выберите все заказы. В зависимости от поля order_status выведите столбец full_order_status:
OPEN – «Order is in open state» ; CLOSED - «Order is closed»; CANCELLED - «Order is cancelled»
*/

SELECT id AS 'id заказа', employee_id AS 'id сотрудника', amount AS 'Количество',
CASE 
	 WHEN order_status = 'OPEN'  THEN 'Order is in open state' 
	 WHEN order_status = 'CLOSED'  THEN 'Order is closed' 
         WHEN order_status = 'CANCELLED'  THEN 'Order is cancelled' 
	 ELSE 'Status unknown' 
END AS 'full_order_status'
FROM orders;
