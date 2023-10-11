/*
В таблицу Cities нужно добавить города Vladivostok, Novosibirsk, Lesozavodsk. Для города Vladivostok нужно указать население: 604901. Структура таблицы:
ID - идентификатор записи с автоинкрементном;
Town - название города;
Population - численность населения.
Решение следует представить в виде текстового файла, содержащего несколько SQL-запросов. Запросы следует завершать символом ';'.
*/

-- Добавляем город Vladivostok
INSERT INTO Cities (Town, Population) VALUES ('Vladivostok', 604901);

-- Добавляем город Novosibirsk
INSERT INTO Cities (Town) VALUES ('Novosibirsk');

-- Добавляем город Lesozavodsk
INSERT INTO Cities (Town) VALUES ('Lesozavodsk');
