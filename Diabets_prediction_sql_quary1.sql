
---Project Questions AND SQL Queries--

CREATE TABLE DiabetesPrediction (
	Employee_name VARCHAR(70),
    Patient_id VARCHAR(20)  PRIMARY KEY,
    Gender VARCHAR(20),
    Age INT,
	Hypertension INT,
    Heart_disease INT,
    Smoking_history VARCHAR(20) ,
    BMI FLOAT,
	HbA1c_level  FLOAT,
    Blood_glucose_level INT,
    Diabetes INT
);
	
SELECT * FROM DiabetesPrediction

_--1. Retrieve the Patient_id and ages of all patients.

SELECT patient_id,age FROM diabetesprediction

--2. Select all female patients who are older than 40.

SELECT gender,age FROM  diabetesprediction
WHERE gender= 'Female' and age >40

--3. Calculate the average BMI of patients.

SELECT AVG(BMI) FROM  diabetesprediction

--4. List patients in descending order of blood glucose levels.

SELECT Employee_name, patient_id,Blood_glucose_level   FROM  diabetesprediction
ORDER BY Blood_glucose_level DESC

--5. Find patients who have hypertension and diabetes.

SELECT * FROM  diabetesprediction 
         WHERE Hypertension='1' AND  Diabetes='1'

--6. Determine the number of patients with heart disease.

SELECT * FROM  diabetesprediction 
         WHERE heart_disease='1' 
--7. Group patients by smoking history and count how many smokers and non-smokers there are.

SELECT Smoking_history, COUNT(*)FROM  diabetesprediction
GROUP BY Smoking_history

--8. Retrieve the Patient_ids of patients who have a BMI greater than the average BMI.

SELECT Patient_id
FROM diabetesprediction
WHERE BMI > (SELECT AVG(BMI) FROM diabetesprediction);

--9. Find the patient with the highest HbA1c level and the patient with the lowest HbA1clevel.

SELECT * FROM  diabetesprediction 
ORDER BY HbA1c_level DESC  --patient with the highest HbA1c level
LIMIT 1;

SELECT * FROM  diabetesprediction 
ORDER BY HbA1c_level ASC  --patient with the lowest HbA1clevel.
LIMIT 1;

--10. Calculate the age of patients in years (assuming the current date as of now).

SELECT Patient_id,  Age
FROM diabetesprediction ;

--11. Rank patients by blood glucose level within each gender group.
SELECT
  Patient_id,
  Gender,
  Blood_Glucose_Level,
  RANK() OVER (PARTITION BY Gender ORDER BY Blood_Glucose_Level) AS Glucose_Level_Rank
FROM
  diabetesprediction ;
  
  --12. Update the smoking history of patients who are older than 50 to "Ex-smoker."
  
  
 UPDATE diabetesprediction
SET Smoking_history = 'Ex-smoker'
WHERE Age > 50;

--13. Insert a new patient into the database with sample data.

INSERT INTO diabetesprediction (Employee_name,Patient_id,Gender,Age,Hypertension,Heart_disease	,
Smoking_history,BMI,HbA1c_level, Blood_glucose_level,Diabetes)
VALUES
    ('narendra', '', 'Male', '56','1','0','Current smoker','56', '5.8','139','1');
	
--13. Insert a new patient into the database with sample data.
DELETE FROM  diabetesprediction 
WHERE Heart_disease= '1'

--15. Find patients who have hypertension but not diabetes using the EXCEPT operator.

SELECT Patient_id
FROM diabetesprediction 
WHERE Hypertension = '1'
EXCEPT
SELECT Patient_id
FROM diabetesprediction 
WHERE Diabetes = '0';

--16. Define a unique constraint on the "patient_id" column to ensure its values are unique.

ALTER TABLE diabetesprediction 
ADD CONSTRAINT Unique_Patient_id UNIQUE (Patient_id);

---17. Create a view that displays the Patient_ids, ages, and BMI of patients--

CREATE VIEW PatientView AS
SELECT
    Patient_id, Age, BMI
FROM
    diabetesprediction;
	
--18.displays the Patient_ids, ages, and BMI of patients

SELECT * FROM PatientView

--Q18. Suggest improvements in the database schema to reduce data
 redundancy and improve data integrity.

--1.Break down large tables into smaller, more manageable ones to eliminate redundant data.
•
Consider creating separate tables for basic patient information such as patient_id ,
Employee name, age and gender to avoid duplication of patient details in multiple tables.
•
Consider creating a table specifically for tracking patient health conditions.
•
Use the patient_id as primary key in this table and reference it as a foreign key in other
relevant tables.

--Q19. Explain how you can optimize the performance of SQL queries on
this dataset.
•
Identify columns frequently used in WHERE clauses or join conditions and create
indexes on those columns to speed up data retrieval.
•
Consider breaking down large queries into smaller, more manageable ones.
•
Use the LIMIT clause to restrict the number of rows returned, especially when dealing
with large datasets.

