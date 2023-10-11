/*
База данных представлена одной таблицей Numbers, в которой хранится набор целых чисел Value. Требуется классифицировать числа на положительные "positive", отрицательные "negative" и ноль "zero". Ниже представлено детальное DDL-описание таблицы:


TABLE Numbers ( -- хранит список целых чисел
    Value INTEGER NOT NULL -- целое число
                DEFAULT (0) 
);
Результатом выполнения запроса должен быть список кортежей (Value, Classification). Описание полей запроса:

Value - значение;
Classification - классификация на положительные, отрицательные и ноль.
Решение следует представить в виде текстового файла, содержащего единственный SQL-запрос.

*/

SELECT
    Value,
    CASE
        WHEN Value > 0 THEN 'positive'
        WHEN Value < 0 THEN 'negative'
        ELSE 'zero'
    END AS Classification
FROM Numbers;
