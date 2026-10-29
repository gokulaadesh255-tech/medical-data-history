show databases;
USE project_medical_data_history;
show tables;

SELECT first_name, last_name, gender
FROM patients
WHERE gender = 'M';

SELECT first_name, last_name
FROM patients
WHERE allergies IS NULL;

SELECT first_name
FROM patients
WHERE first_name LIKE 'C%';

SELECT first_name, last_name
FROM patients
WHERE weight BETWEEN 100 AND 120;

SELECT
    patient_id,
    first_name,
    last_name,
    COALESCE(allergies, 'NKA') AS allergies
FROM patients;

SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM patients;

SELECT
    p.first_name,
    p.last_name,
    pn.province_name
FROM patients AS p
JOIN province_names AS pn
    ON p.province_id = pn.province_id;

SELECT COUNT(*) AS total_patients
FROM patients
WHERE YEAR(birth_date) = 2010;

SELECT first_name, last_name, height
FROM patients
WHERE height = (
    SELECT MAX(height)
    FROM patients
);

SELECT *
FROM patients
WHERE patient_id IN (1, 45, 534, 879, 1000);

SELECT COUNT(*) AS total_admissions
FROM admissions;

SELECT *
FROM admissions
WHERE admission_date = discharge_date;

SELECT COUNT(*) AS total_admissions
FROM admissions
WHERE patient_id = 579;

SELECT DISTINCT city
FROM patients
WHERE province_id = 'NS';

SELECT first_name, last_name, birth_date
FROM patients
WHERE height > 160
  AND weight > 70;
  
  SELECT DISTINCT YEAR(birth_date) AS birth_year
FROM patients
ORDER BY birth_year ASC;

SELECT first_name
FROM patients
GROUP BY first_name
HAVING COUNT(*) = 1;

SELECT patient_id, first_name
FROM patients
WHERE first_name LIKE 's%s'
  AND LENGTH(first_name) >= 6;
  
  SELECT
    p.patient_id,
    p.first_name,
    p.last_name
FROM patients AS p
JOIN admissions AS a
    ON p.patient_id = a.patient_id
WHERE a.diagnosis = 'Dementia';

SELECT first_name
FROM patients
ORDER BY LENGTH(first_name) ASC, first_name ASC;

SELECT
    SUM(gender = 'M') AS male_patients,
    SUM(gender = 'F') AS female_patients
FROM patients;

SELECT
    patient_id,
    diagnosis,
    COUNT(*) AS total_admissions
FROM admissions
GROUP BY patient_id, diagnosis
HAVING COUNT(*) > 1;

SELECT
    city,
    COUNT(*) AS total_patients
FROM patients
GROUP BY city
ORDER BY total_patients DESC, city ASC;

SELECT
    first_name,
    last_name,
    'Patient' AS role
FROM patients

UNION ALL

SELECT
    first_name,
    last_name,
    'Doctor' AS role
FROM doctors;

SELECT
    allergies,
    COUNT(*) AS total_patients
FROM patients
WHERE allergies IS NOT NULL
GROUP BY allergies
ORDER BY total_patients DESC;

SELECT
    first_name,
    last_name,
    birth_date
FROM patients
WHERE birth_date >= '1970-01-01'
  AND birth_date < '1980-01-01'
ORDER BY birth_date ASC;

SELECT
    CONCAT(UPPER(last_name), ',', LOWER(first_name)) AS full_name
FROM patients
ORDER BY first_name DESC;

SELECT
    province_id,
    SUM(height) AS total_height
FROM patients
GROUP BY province_id
HAVING SUM(height) >= 7000;

SELECT
    MAX(weight) - MIN(weight) AS weight_difference
FROM patients
WHERE last_name = 'Maroni';

SELECT
    DAY(admission_date) AS day_of_month,
    COUNT(*) AS total_admissions
FROM admissions
GROUP BY DAY(admission_date)
ORDER BY total_admissions DESC;

SELECT
    FLOOR(weight / 10) * 10 AS weight_group,
    COUNT(*) AS total_patients
FROM patients
GROUP BY FLOOR(weight / 10) * 10
ORDER BY weight_group DESC;

SELECT
    patient_id,
    weight,
    height,
    (weight / POWER(height / 100.0, 2) >= 30) AS isObese
FROM patients;

SELECT
    p.patient_id,
    p.first_name,
    p.last_name,
    d.specialty
FROM patients AS p
JOIN admissions AS a
    ON p.patient_id = a.patient_id
JOIN doctors AS d
    ON a.attending_doctor_id = d.doctor_id
WHERE a.diagnosis = 'Epilepsy'
  AND d.first_name = 'Lisa';