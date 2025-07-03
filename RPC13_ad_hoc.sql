
### GOODCABS AD_HOC Questions ##############
### Solved by Avirup Mitra
-- ------------------------------------------------------------------------
# 1) City Level Fare and Trip Summary Report

with cte as (select c.city_name, t.trip_id, 
(t.fare_amount/t.distance_travelled_km) fare_per_km, 
t.fare_amount total_fare from dim_city c join fact_trips t 
on c.city_id=t.city_id)

select city_name, count(distinct trip_id) citywise_trips, 
round(avg(fare_per_km),2) average_fare_per_km, round(avg(total_fare),2) average_fare_per_trip,
concat(round(count(distinct trip_id)*100/(select count(distinct trip_id) from fact_trips),2),"%") contribution_to_total
from cte group by 1;

-- -------------------------------------------------------------------------

# 2) Monthly City-Level Trips target performance report

with cte1 as (select date_format(date,"%M") month, c.city_id, c.city_name, 
count(t.trip_id) trips from dim_city c join fact_trips t
on c.city_id=t.city_id group by 1,2,3),

cte2 as (select date_format(month,"%M") month, 
city_id, sum(total_target_trips) target_trips
from targets_db.monthly_target_trips 
group by 1,2),

cte3 as (select cte2.month,cte1.city_name,
cte2.target_trips, cte1.trips actual_trips
from cte2 join cte1 
on cte2.month=cte1.month and cte2.city_id=cte1.city_id)

select *, 
case 
when (actual_trips-target_trips)>0 then "Above Target"
when (actual_trips-target_trips)<0 then "Below Target"
else "Equalized" end performance_status,
concat(round(abs(actual_trips-target_trips)*100/target_trips,2),"%") `%_difference`
from cte3;

-- -------------------------------------------------------------------------

# 3) City-level repeat passenger trip frequency report

with cte1 as (select c.city_name, td.trip_count, 
sum(td.repeat_passenger_count) repeat_passenger_count 
from dim_repeat_trip_distribution td
join dim_city c on c.city_id=td.city_id
group by 1,2),

cte2 as (select *, sum(repeat_passenger_count) 
over(partition by city_name) citywise_total_repeat_passengers 
from cte1)

select city_name, trip_count, repeat_passenger_count,
concat(round((repeat_passenger_count*100/citywise_total_repeat_passengers),2),"%")
`city_wise_%` from cte2;

-- -------------------------------------------------------------------------

# 4) Top 3 and Bottom 3 Cities based on new passengers

with cte as 
(select c.city_name, sum(ps.new_passengers) new_passengers
from dim_city c join fact_passenger_summary ps
on c.city_id=ps.city_id group by 1),

cte2 as
(select *, dense_rank() over(order by new_passengers desc) top_rank,
dense_rank() over(order by new_passengers) bottom_rank
from cte)

select city_name, new_passengers, 
case 
	when top_rank<=3 then "Top 3"
	when bottom_rank<=3 then "Bottom 3"
    else "" 
 end city_category
 from cte2 order by 2 desc;
-- -------------------------------------------------------------------------

# 5) Month with the highest revenue for each city

with cte1 as 
(select c.city_name, date_format(t.date,"%M") month, 
sum(t.fare_amount) total_fare
from fact_trips t join dim_city c 
on c.city_id=t.city_id 
group by 1,2 order by 3 desc),

cte2 as (select *, sum(total_fare) over(partition by city_name) final_total,
dense_rank() over(partition by city_name order by total_fare desc) ranking 
from cte1)

select city_name, month, total_fare highest_revenue, 
concat(round((total_fare*100/final_total),2),"%") `%_contribution` 
from cte2 where ranking=1;

-- -------------------------------------------------------------------------

# 6) Repeat passenger rate analysis

with cte1 as 
(select c.city_name, date_format(ps.month,"%M") month,
ps.total_passengers, ps.repeat_passengers
from dim_city c join fact_passenger_summary ps
on c.city_id=ps.city_id),

cte2 as (select city_name, sum(Total_passengers) total_passengers,
sum(repeat_passengers) repeat_passengers, 
concat(round(sum(repeat_passengers)*100/sum(total_passengers),2),"%") `repetition_rate_%`
from cte1 group by 1),

cte3 as (select month, city_name, sum(Total_passengers) total_passengers,
sum(repeat_passengers) repeat_passengers, 
concat(round(sum(repeat_passengers)*100/sum(total_passengers),2),"%") `monthly_repetition_rate_%`
from cte1 group by 1,2)

select cte3.*, cte2.`repetition_rate_%` `citywise_overall_repetition_rate_%`
from cte3 join cte2 on cte3.city_name=cte2.city_name;

