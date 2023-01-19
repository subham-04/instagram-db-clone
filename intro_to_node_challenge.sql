use newduser;


select date_format(min(created_at),"%M %D %Y") as 'earliest_day' from users;


select * from users where created_at = (select min(created_at) from users);


select monthname(created_at), count(email) from users group by monthname(created_at) order by 2 desc;


select count(*) as yahoo_user from users where email like '%@yahoo.com';


select 
	case 
    when email like '%@yahoo.com' then 'yahoo'
    when email like '%@gmail.com' then 'gmail'
    when email like '%@hotmail.com' then 'hotmail'
    else 'other'
    end as provider, count(*) as total
    from users group by provider order by total;