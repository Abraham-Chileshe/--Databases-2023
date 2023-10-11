/*
В пустой БД требуется создать таблицу Notes со структурой:

ID: INTEGER;
Note: TEXT;
TimeOfCreation: DATETIME;
ProgressMade: REAL;
Status: TEXT.
Дополнительно, нужно прописать параметры полей:

ID - первичный ключ с автоинкрементном;
Note - гарантирует уникальность, не NULL;
TimeOfCreation - не NULL;
ProgressMade - от 0 до 1, по умолчанию ноль;
Status - одно из значений: "started", "accepted", "canceled", по умолчанию "started".
Решение следует представить в виде текстового файла, содержащего единственный SQL-запрос.
*/

CREATE TABLE Notes (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Note TEXT UNIQUE NOT NULL,
    TimeOfCreation DATETIME NOT NULL,
    ProgressMade REAL DEFAULT 0 CHECK (ProgressMade >= 0 AND ProgressMade <= 1),
    Status TEXT DEFAULT 'started' CHECK (Status IN ('started', 'accepted', 'canceled'))
);
