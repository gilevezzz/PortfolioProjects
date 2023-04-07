--PUTTING DATA IN LOWER CASE

SELECT 
	applicant_id,
	LOWER(sex) AS sex,
    LOWER(maritalstatus_children) AS maritalstatus_children,
    LOWER(housing) AS housing
FROM credapp_data1;
--------------------------------------------------------------------

--CLEANING MISSPELLED DATA

SELECT DISTINCT sex FROM credapp_data1;

SELECT DISTINCT housing FROM credapp_data1;

SELECT 
    applicant_id,
    CASE 
        WHEN LOWER(sex) IN ('maale','males','maleee') THEN 'male'
        WHEN LOWER(sex) IN ('females','femaleee') THEN 'female'
    ELSE LOWER(sex) END AS sex,
    LOWER(maritalstatus_children) AS maritalstatus_children,
    LOWER(housing)::TEXT AS housing
FROM credapp_data1;
-----------------------------------------------------------------
--CHANGING DATA TYPE
SELECT applicant_id,
       CASE WHEN LOWER(sex) IN ('maale','males','maleee') THEN 'male'
            WHEN LOWER(sex) IN ('females','femaleee') THEN 'female'
            ELSE LOWER(sex) END AS sex,
       SPLIT_PART(LOWER(maritalstatus_children), '-', 1) AS marital_status,
       SPLIT_PART(LOWER(maritalstatus_children), '-', 2)::INTEGER AS children,
       LOWER(housing)::TEXT AS housing
FROM credapp_data1;
--------------------------------------------------------------------------------


--CREATING A COPY THAT WE WILL ALTER TO ENSURE THAT WE PRESERVE A VERSION OF THE ORIGINAL TABLE


CREATE TABLE credapp_data1_copy AS
SELECT * FROM credapp_data1;

SELECT * FROM credapp_data1_copy;

---------------------------------------------------------------

--PUTTING THE DATA IN LOWER CASE


UPDATE credapp_data1_copy
SET sex = LOWER(sex),
    maritalstatus_children = LOWER(maritalstatus_children),
    housing = LOWER(housing);

----------------------------------------------------------------

--CHECKING DATA FOR ERROR AND CLEANING ACCORDINGLY

SELECT * FROM credapp_data1_copy;

SELECT DISTINCT sex FROM credapp_data1_copy ORDER BY sex;

UPDATE credapp_data1_copy
SET sex = 'male'
WHERE sex IN ('maale','males','maleee');

UPDATE credapp_data1_copy
SET sex = 'female'
WHERE sex IN ('females','femaleee');

----------------------------------------------------------------

--SPLITTING COLUMNS FOR DATA CLEANING

SELECT * FROM credapp_data1_copy;

ALTER TABLE credapp_data1_copy
ADD COLUMN marital_status TEXT;

ALTER TABLE credapp_data1_copy
ADD COLUMN children TEXT;

UPDATE credapp_data1_copy
SET marital_status = SPLIT_PART(LOWER(maritalstatus_children), '-', 1),
    children = SPLIT_PART(LOWER(maritalstatus_children), '-', 2);
    
ALTER TABLE credapp_data1_copy
DROP COLUMN maritalstatus_children;

ALTER TABLE credapp_data1_copy
ALTER COLUMN children TYPE INTEGER
USING children::INTEGER;

