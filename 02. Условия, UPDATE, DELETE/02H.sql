/*
Из таблице Magazines нужно удалить все записи, где поле Edition имеет значение "NULL".
Решение следует представить в виде текстового файла, содержащего единственный SQL-запрос.
*/

DELETE FROM Magazines WHERE Edition IS NULL;
