use rental_db;

INSERT INTO rental_records (veh_reg_no, customer_id, start_date, end_date)
SELECT 'SBA1111A', customer_id, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 10 DAY)
FROM customers
WHERE name = 'Angel';

INSERT INTO rental_records (veh_reg_no, customer_id, start_date, end_date)
SELECT 'GA5555E', customer_id, CURDATE() + 1, DATE_ADD(CURDATE(), INTERVAL 3 MONTH)
FROM customers
WHERE name = 'Kumar';

SELECT start_date, end_date, veh_reg_no, brand, name
FROM rental_records JOIN vehicles USING (veh_reg_no)
	JOIN customers USING (customer_id)
ORDER BY category, start_date;

SELECT *
FROM rental_records
WHERE end_date < CURDATE();

SELECT veh_reg_no, name, start_date, end_date
FROM rental_records JOIN customers USING (customer_id)
WHERE '2012-01-10' BETWEEN start_date AND end_date;

SELECT veh_reg_no, name, start_date, end_date
FROM rental_records JOIN customers USING (customer_id)
WHERE CURDATE() BETWEEN start_date AND end_date;

SELECT veh_reg_no, name, start_date, end_date
FROM rental_records JOIN customers USING (customer_id)
WHERE (start_date BETWEEN '2012-01-03' AND '2012-01-18')
	OR (end_date BETWEEN '2012-01-03' AND '2012-01-18')
    OR (start_date < '2012-01-03' AND end_date > '2012-01-18');

SELECT veh_reg_no, brand, vehicles.desc
FROM vehicles
WHERE veh_reg_no NOT IN (
	SELECT veh_reg_no
    FROM rental_records
    WHERE '2012-01-10' BETWEEN start_date AND end_date
);


SELECT veh_reg_no, brand, vehicles.desc
FROM vehicles
WHERE NOT veh_reg_no IN (
	SELECT veh_reg_no
    FROM rental_records
    WHERE (start_date BETWEEN '2012-01-03' AND '2012-01-18')
		OR (end_date BETWEEN '2012-01-03' AND '2012-01-18')
		OR (start_date < '2012-01-03' AND end_date > '2012-01-18')
);

SELECT veh_reg_no, brand, vehicles.desc
FROM vehicles
WHERE NOT veh_reg_no IN (
	SELECT veh_reg_no
    FROM rental_records
    WHERE (start_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 10 DAY))
	OR (end_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 10 DAY))
);


