SELECT A.name as a, B.name as b FROM good as A, good as B, check, check_good ;
	WHERE check.check_id = check_good.check_id AND ;
	check_good.good_id = A.good_id AND ;
	check_good.good_id = A.good_id AND ;
	A.name > B.name AND ;
	DTOS(check.date_time) = "20101217"
    -- #--------------------------------------------------

    SELECT check.check_id, SUM(check_good.amount * good.price) as sum FROM check, check_good, good INTO CURSOR tmp;
	WHERE check.check_id = check_good.check_id AND ;
	check_good.good_id = good.good_id ;
	GROUP BY check.check_id

    SELECT tmp.check_id, tmp.sum FROM tmp ;
	WHERE tmp.sum in (SELECT MAX(tmp.sum) from tmp)
    --
    SELECT cashier.name, SUM(good.price * check_good.amount) into cursor tmp; 
    FROM cashier, check, check_good, good ;
	WHERE cashier.cashier_id = check.cashier_id AND ;
    check.check_id = check_good.check_id AND ;
    check_good.good_id = good.good_id AND ;
    DTOS(check.date_time) > "20100101" AND ;
    DTOS(check.date_time) < "20101201" ;
    GROUP BY cashier.name
   --
   SELECT cashier.name, SUM(good.price * check_good.amount) as sum ; 
    FROM cashier, check, check_good, good ;
	WHERE cashier.cashier_id = check.cashier_id AND ;
    check.check_id = check_good.check_id AND ;
    check_good.good_id = good.good_id AND ;
    DTOS(check.date_time) > "20100601" AND ;
    DTOS(check.date_time) < "20101201" ;
    GROUP BY cashier.name
--
SELECT cashier.name, SUM(good.price * check_good.amount) as sum ; 
    from cashier left join check on cashier.cashier_id = check.cashier_id ;
    left join check_good on check.check_id = check_good.check_id ;
    left join good on check_good.good_id = good.good_id and ;
    DTOS(check.date_time) > "20100601" AND ;
    DTOS(check.date_time) < "20101201" ;
    GROUP BY cashier.name -- with null in cashier's sum