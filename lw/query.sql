1.	Определить пары товаров одного чека
SELECT check_good.good_id FROM check, check_good INTO CURSOR tmp ;
	WHERE check.check_id = check_good.check_id AND ;
	check.check_id = 11

SELECT a.good_id as A, b.good_id as B FROM tmp as a, tmp as b ;
	WHERE a.good_id > b.good_id

2.	Определить кассиров, которые не работали на заданном аппарате в данном интервале дат
SELECT distinct cashier.name FROM cashier, check INTO CURSOR tmp;
	WHERE cashier.cashier_id = check.cashier_id AND ;
	DTOS(check.date_time) > "20101107" AND ;
	DTOS(check.date_time) < "20111106" AND ;
	check.cashbox_id = 100
SELECT cashier.name FROM cashier ;
	WHERE cashier.name NOT in (SELECT tmp.name FROM tmp)

3.	Определить чек с максимальной суммой
SELECT check.check_id, SUM(check_good.amount * good.price) as sum FROM check, check_good, good INTO CURSOR tmp;
WHERE check.check_id = check_good.check_id AND ;
check_good.good_id = good.good_id ;
GROUP BY check.check_id

SELECT tmp.check_id, tmp.sum FROM tmp ;
WHERE tmp.sum in (SELECT MAX(tmp.sum) from tmp)

4.	Определить чеки, в которых был заданный товар на заданном интервале времени
SELECT check_good.check_id FROM check, check_good, good ;
	WHERE check.check_id = check_good.check_id AND ;
	check_good.good_id = good.good_id AND ;
	good.name = "INTEL Core i5 8600K" AND ;
	DTOS(check.date_time) > "20101231"

5.	Определить кассира, который выбил максимальную сумму чеков на заданном интервале
SELECT cashier.name, SUM(good.price * check_good.amount) as sum INTO CURSOR tmp; 
    FROM cashier, check, check_good, good ;
	WHERE cashier.cashier_id = check.cashier_id AND ;
    check.check_id = check_good.check_id AND ;
    check_good.good_id = good.good_id AND ;
    DTOS(check.date_time) > "20100101" AND ;
    DTOS(check.date_time) < "20101201" ;
    GROUP BY cashier.name
SELECT tmp.name, tmp.sum FROM tmp ;
	WHERE tmp.sum in (SELECT MAX(tmp.sum) FROM tmp)

6.	Определить товар, который не пользовался спросом на заданном интервале 
SELECT good.name, check_good.amount FROM check, check_good, good INTO CURSOR tmp ; 
	WHERE check.check_id = check_good.check_id AND ;
	check_good.good_id = good.good_id AND ;
	DTOS(check.date_time) > "20110101" AND ;
	DTOS(check.date_time) < "20110501"

SELECT tmp.name FROM tmp ;
	WHERE tmp.amount in (SELECT MIN(tmp.amount) FROM tmp);
union;
SELECT good.name FROM good ;
	WHERE good.name NOT in (SELECT tmp.name FROM tmp)
