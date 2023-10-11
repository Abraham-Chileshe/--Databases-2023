/*
Требуется из таблицы TelephoneCodesOfCities со структурой:

ID - уникальный идентификатор записи;
City - название города;
PhoneCode - телефонный код;
выбрать телефонный код города "krasnoyarsk". Города хранятся в БД в нижнем регистре.
Решение следует представить в виде текстового файла, содержащего единственный SQL-запрос.
*/

SELECT PhoneCode FROM TelephoneCodesOfCities WHERE LOWER(City) = 'krasnoyarsk';
