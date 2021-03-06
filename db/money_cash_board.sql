DROP TABLE transactions;
DROP TABLE people;
DROP TABLE tags;

CREATE TABLE people (
  id SERIAL8 primary key,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  budget DECIMAL
);

CREATE TABLE tags (
  id SERIAL8 primary key,
  name VARCHAR(255)
);

CREATE TABLE transactions (
  id SERIAL8 primary key,
  merchant_name VARCHAR(255),
  value DECIMAL,
  person_id INT8 references people(id) ON DELETE CASCADE,
  tag_id INT8 references tags(id),
  timestamp TIMESTAMP
);