#create a table that lists every event attendee since 2019-07-01(July 1). Also bring in the number of service hours.
select 
	t1.date,
	t1.event,
	t1.event_date,
	t1.first_name,
	t1.last_name,
	t2.hours
from sign_in as t1
join event_log as t2 on t1.event_date = t2.event_date
where t1.date >= '2019-07-01';


#How Many Service Hours did we do each month
select 
	date_format(date,'%Y-%M') as mnth,
    sum(hours) as service_hours
from
	(select 
		t1.date,
		t1.event,
		t1.event_date,
		t1.first_name,
		t1.last_name,
		t2.hours
	from sign_in as t1
	join event_log as t2 on t1.event_date = t2.event_date
    where t1.date >= '2019-07-01') as t2
group by 1;

#Community Service Hours Leaderboard
select 
	concat(first_name," ",last_name) as full_name,
    sum(hours) as total_hours
from
	(select 
		t1.date,
		t1.event,
		t1.event_date,
		t1.first_name,
		t1.last_name,
		t2.hours
	from sign_in as t1
	join event_log as t2 on t1.event_date = t2.event_date
    where t1.date >= '2019-07-01') as t2
group by 1
order by total_hours desc;

#Event Attendance Leader Board
select 
	concat(first_name," ",last_name) as full_name,
    count(event_date) as attended_events
from
	(select 
		t1.date,
		t1.event,
		t1.event_date,
		t1.first_name,
		t1.last_name
	from sign_in as t1
    where t1.date >= '2019-07-01') as t2
group by 1
order by attended_events desc;