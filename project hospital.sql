select * from hospital


-- 1. Which age cohort exhibits the highest hospitalization rates?
select age, count(age) Hospitalization_rate
from hospital
group by age
order by (count(age)) desc
limit 1

select count(id) as patients_counts, age
from hospital
group by age
order by (count(id)) desc
limit 1

-- 2. What age group experiences the highest mortality within the hospital?

select count(outcome) mortality_rate, age,
case
when age between 71 and 99 then '71-99'
when age between 40 and 70 then '40-70'

end as age_group
from hospital
where outcome = 1
group by age
order by mortality_rate desc


-- 3. Which gender is the most prevalent in the hospital?
select gendera , count(gendera),
case 
when gendera = 1 then 'Male'
when gendera = 2 then 'Female'
end as Gender
from hospital 
group by gendera 

-- 4. How many patients died in the hospital with atrial fibrillation?

select count(atrialfibrillation) as death_of_atrialfibrillation
from hospital
where outcome = 1 and atrialfibrillation = 1


-- 5. How many patients in the hospital have depression?

select count(depression)as depression_count
from hospital
where depression = 1

-- 6. What is the rate of non-survived patients with hypertension?

with cte1 as 
            (select sum(outcome) as outcome from hospital where outcome = 1),
cte2 as 
        (select sum(hypertensive)as hypertension from hospital where hypertensive = 1)

select round(cast(cte1.outcome as decimal)/(cte2.hypertension) * 100) as rate from cte1
cross join cte2

-- 7. How many patients are alive in the hospital with renal failure?

select count(renal_failure) as renal_failure
from hospital
where outcome = 0 and renal_failure = 1

-- 8. How many patients are dead in the hospital with Hyperlipemia ?

select count(hyperlipemia) hyperlipemia_death
from hospital
where outcome = 1 and hyperlipemia = 1

-- 9. How many patients are dead in the hospital with Anemia?

select count(deficiencyanemias) as death_anemia 
from hospital
where outcome = 1 and deficiencyanemias = 1


--  mortality rate in hospital
with cte1 as 
            (select sum(outcome) as outcome from hospital where outcome = 1),
cte2 as 
        (select count(id) as patients from hospital )

select round(cast(cte1.outcome as decimal)/(cte2.patients) * 100) as mortality_rate 
from cte1
cross join cte2

-- Average Heart rate by age groups

select round(avg(heart_rate)) Average_heart_rate,
case
when age <= 45 then 'Young age'
when age <= 65 then 'Middle age'
else 'Old age'
end age_group

from hospital
group by age_group
order by Average_heart_rate desc























		











