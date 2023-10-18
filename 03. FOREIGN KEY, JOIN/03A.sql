CREATE TABLE IF NOT EXISTS contacts(
    id integer PRIMARY KEY,
    name text
);

CREATE TABLE IF NOT EXISTS email(
    address text,
    contact_id integer,
    FOREIGN KEY (contact_id) REFERENCES contacts(id) 
);

CREATE TABLE IF NOT EXISTS phones(
    number text,
    contact_id integer,
    FOREIGN KEY (contact_id) REFERENCES contacts(id)
);
