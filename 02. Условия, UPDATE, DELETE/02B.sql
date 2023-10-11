/*
В таблицу Customers реляционной БД требуется добавить новое поле Email типа "TEXT", со значение по умолчанию "@mail.ru".
Решение следует представить в виде текстового файла, содержащего единственный SQL-запрос.
*/

ALTER TABLE Customers
ADD COLUMN Email TEXT DEFAULT '@mail.ru';
