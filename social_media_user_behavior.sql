-- Create Database
create database social_media;

select * from platform_statistics_2026;
select * from social_media_user_behavior;

desc social_media_user_behavior;

-- Add a new column
alter table social_media_user_behavior
add column new_account_created_date date;

-- Update created column
SET SQL_SAFE_UPDATES = 0;

update social_media_user_behavior
set new_account_created_date = str_to_date(account_created_date, "%d-%m-%Y");

-- Drop the column
alter table social_media_user_behavior
drop column account_created_date;

-- Rename the column
alter table social_media_user_behavior
rename column new_account_created_date to account_created_date;

-- ******** Problem Statement ***********

/*
Phase 1: The Engagement Reality Check
The Business Problem: We know how our users behave, but we don't know if that behavior is
normal. Are our users actually engaged, or are they just passively scrolling compared to the rest of
the world? 
*/

--Phase-1 Query
select
sm.user_id,
sm.primary_platform,
ps.headquarters_country,
sm.engagement_rate_pct as user_engagement_rate,
ps.avg_engagement_rate_pct as platform_engagement_rate,
round((sm.engagement_rate_pct - ps.avg_engagement_rate_pct),2) as engagement_gap,
case
	when sm.engagement_rate_pct < ps.avg_engagement_rate_pct then 'Underperforming'
    when sm.engagement_rate_pct > ps.avg_engagement_rate_pct then 'Overperforming'
    else 'Average'
end as performance_status
from platform_statistics_2026 ps
join social_media_user_behavior sm on ps.platform = sm.primary_platform;


/*
Phase 2: The Addiction-Commerce Nexus (Monetization)
The Business Problem: Companies care about money. Which platforms have the highest global
"Social Commerce Adoption," and are those same platforms causing the highest "Addiction
Levels" in our specific users?
*/

-- Phase-2 Query
select
sm.primary_platform,
ps.social_commerce_adoption_pct,
round(avg(sm.addiction_level_1_to_10),2) as avg_user_addiction_level,
round(avg(sm.monthly_social_spending_usd),2) as avg_monthly_spending
from platform_statistics_2026 ps
join social_media_user_behavior sm on ps.platform = sm.primary_platform
group by sm.primary_platform, ps.social_commerce_adoption_pct
order by avg_monthly_spending desc;

/*
Phase 3: The Productivity Drain (Human Cost)
The Business Problem: High screen time equals high ad revenue, but what is the cost? Do
platforms with higher global daily time averages cause worse productivity and sleep loss in our
users?
*/

-- Phase-3 Query
select
sm.primary_platform,
sm.productivity_impact,
ps.avg_daily_time_minutes as global_avg_screen_time,
count(sm.user_id) as user_count,
round(avg(sm.sleep_hours_per_night),2) as avg_sleep_hours,
round(avg(sm.daily_screen_time_minutes),2) as avg_screen_time
from platform_statistics_2026 ps
join social_media_user_behavior sm on ps.platform = sm.primary_platform
group by sm.primary_platform, sm.productivity_impact,global_avg_screen_time
order by sm.primary_platform asc, user_count desc;


/*
Phase 4: The "Burnout" Churn Risk (Predictive Value)
The Business Problem: Users who spend a lot of money but report "Negative" mental health are a
massive churn risk. They will eventually delete the app. Who are they, and what platforms do they use?
*/

-- Phase-4 Query
select
user_id,
primary_platform,
monthly_social_spending_usd,
self_reported_mental_health_effect,
case
when monthly_social_spending_usd>15 and self_reported_mental_health_effect in('Negative','Mostly Negative') then 'High Value - High Flight Risk'
when monthly_social_spending_usd>15 and self_reported_mental_health_effect in('Positive','Mostly Positive') then 'High Value - Loyal'
when monthly_social_spending_usd<=15 and self_reported_mental_health_effect in('Negative','Mostly Negative') then 'Low Value - High Flight Risk'
else 'Neutral'
end as user_risk_category
from social_media_user_behavior;


-- Create a Master View table using Phase-1 and Phase-4
CREATE VIEW view_social_media_fact AS
select
sm.*,
round((sm.engagement_rate_pct - ps.avg_engagement_rate_pct),2) as engagement_gap,
case
	when sm.engagement_rate_pct < ps.avg_engagement_rate_pct then 'Underperforming'
    when sm.engagement_rate_pct > ps.avg_engagement_rate_pct then 'Overperforming'
    else 'Average'
end as performance_status,
case
	when sm.monthly_social_spending_usd>15 and sm.self_reported_mental_health_effect in('Negative','Mostly Negative') then 'High Value - High Flight Risk'
	when sm.monthly_social_spending_usd>15 and sm.self_reported_mental_health_effect in('Positive','Mostly Positive') then 'High Value - Loyal'
	when sm.monthly_social_spending_usd<=15 and sm.self_reported_mental_health_effect in('Negative','Mostly Negative') then 'Low Value - High Flight Risk'
	else 'Neutral'
	end as user_risk_category
from platform_statistics_2026 ps
join social_media_user_behavior sm on ps.platform = sm.primary_platform;


