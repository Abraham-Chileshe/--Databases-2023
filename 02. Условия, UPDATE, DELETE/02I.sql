/*
В таблице Animals нужно изменить все значения поля Sex с длинных вариантов: "male", "female" на короткие: "m", "w". Для прочих значений поля Sex, нужно указать "unknown", если они не "NULL".
Решение следует представить в виде текстового файла, содержащего несколько SQL-запросов.
*/

UPDATE Animals
SET Sex = CASE
    WHEN Sex = 'male' THEN 'm'
    WHEN Sex = 'female' THEN 'w'
    ELSE Sex
END;

UPDATE Animals
SET Sex = 'unknown'
WHERE Sex IS NOT NULL;

/*
Using Only One Script
*/

UPDATE Animals
SET Sex = CASE
    WHEN Sex = 'male' THEN 'm'
    WHEN Sex = 'female' THEN 'w'
    ELSE 'unknown'
END
WHERE Sex IS NOT NULL;
