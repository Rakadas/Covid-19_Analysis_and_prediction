use covid_prediction;

#Q1. Find the number of corona patients who faced shortness of breath.

select count(*) as Patients_faced_shortness_of_breath from new_covid
where Shortness_of_breath = 'true';

#2. Find the number of negative corona patients who have fever and sore_throat. 

SELECT Fever,Sore_throat,Corona,count(*) as Total_no_of_patients FROM new_covid
WHERE Corona = 'negative' and Fever = 'true' and Sore_throat = 'true';


#Q3. Group the data by month and rank the number of positive cases.

SELECT Test_date,Corona,
row_number() over(partition by Test_date) as No_of_Positive_cases FROM new_covid
where Corona = 'positive';


#Q4. Find the female negative corona patients who faced cough and headache.

SELECT Sex,Cough_symptoms,Headache,Corona FROM new_covid
WHERE Sex = 'female' AND Cough_symptoms = 'true' AND Headache = 'true' AND Corona = 'negative' ;


#Q5. How many elderly corona patients have faced breathing problems?

SELECT Age_60_above,Shortness_of_breath,count(*) as No_of_Elderly_patients FROM new_covid
where Age_60_above = 'Yes' AND Shortness_of_breath = 'true' AND Corona = 'positive';

#Q6. Which three symptoms were more common among COVID positive patients?

WITH cte1 as(
SELECT count(*) as Cough_symptoms FROM new_covid
WHERE Corona = 'positive' AND Cough_symptoms = 'true'),
cte2 as(
SELECT count(*) as Fever FROM new_covid
WHERE Corona = 'positive' AND Fever = 'true'),
cte3 as(
SELECT count(*) as Sore_throat FROM new_covid
WHERE Corona = 'positive' AND Sore_throat = 'true'),
cte4 as(
SELECT count(*) as Shortness_of_breath FROM new_covid
WHERE Corona = 'positive' AND Shortness_of_breath = 'true'),
cte5 as(
SELECT count(*) as Headache FROM new_covid
WHERE Corona = 'positive' AND Headache = 'true')
SELECT * FROM cte1,cte2,cte3,cte4,cte5;

-- ANS: From the above query, We found that Cough, Fever and Headache are most common Symptoms for covid positive.

#Q7. Which symptom was less common among COVID negative people?

WITH cte1 as(
SELECT count(*) as Cough_symptoms FROM new_covid
WHERE Corona = 'negative' AND Cough_symptoms = 'true'),
cte2 as(
SELECT count(*) as Fever FROM new_covid
WHERE Corona = 'negative' AND Fever = 'true'),
cte3 as(
SELECT count(*) as Sore_throat FROM new_covid
WHERE Corona = 'negetive' AND Sore_throat = 'true'),
cte4 as(
SELECT count(*) as Shortness_of_breath FROM new_covid
WHERE Corona = 'negative' AND Shortness_of_breath = 'true'),
cte5 as(
SELECT count(*) as Headache FROM new_covid
WHERE Corona = 'negative' AND Headache = 'true')
SELECT * FROM cte1,cte2,cte3,cte4,cte5;

-- ANS: Sore_throat was less common in corona negative people.


#Q8. What are the most common symptoms among COVID positive males whose known contact was abroad? 

WITH cte1 as(
SELECT count(*) as Cough FROM new_covid
WHERE Corona = 'positive' AND Sex = 'male' AND Known_contact = 'Abroad' AND Cough_symptoms = 'true'),
cte2 as(
SELECT count(*) as Fever FROM new_covid
WHERE Corona = 'positive' AND Sex = 'male' AND Known_contact = 'Abroad' AND Fever = 'true'),
cte3 as(
SELECT count(*) as Sore_throat FROM new_covid
WHERE Corona = 'positive' AND Sex = 'male' AND Known_contact = 'Abroad' AND Sore_throat = 'true'),
cte4 as(
SELECT count(*) as Shortness_of_breath FROM new_covid
WHERE Corona = 'positive' AND Sex = 'male' AND Known_contact = 'Abroad' AND Shortness_of_breath = 'true'),
cte5 as(
SELECT count(*) as Headache FROM new_covid
WHERE Corona = 'positive' AND Sex = 'male' AND Known_contact = 'Abroad' AND Headache = 'true')
SELECT
CASE
	WHEN Cough >= Fever AND Cough >= Sore_throat AND Cough >= Shortness_of_breath AND Cough >= Headache THEN 'COUGH_SYMPTOMS'
    WHEN Fever >= Cough AND Fever >= Sore_throat AND Fever >= Shortness_of_breath AND Fever >= Headache THEN 'FEVER'
    WHEN Sore_throat >= Cough AND Sore_throat >= Fever AND Sore_throat >= Shortness_of_breath AND Sore_throat >= Headache THEN 'SORE_THROAT'
    WHEN Shortness_of_breath >= Cough AND Shortness_of_breath >= Sore_throat AND Shortness_of_breath >= Fever AND Shortness_of_breath >= Headache THEN 'SHORTNESS_BREATH'
    ELSE 'Headache'
END AS Most_Common_Symptoms,
greatest(Cough,Fever,Sore_throat,Shortness_of_breath,Headache) as Total_Male_Abroad_Patients from cte1,cte2,cte3,cte4,cte5;

-- ANS: Cough_Symptoms are the most common symptoms among COVID positive males whose known contact was abroad.