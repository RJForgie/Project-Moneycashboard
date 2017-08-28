DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS merchants;
DROP TABLE IF EXISTS accountsettings;

CREATE TABLE tags (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE merchants (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE accountsettings (
  id SERIAL PRIMARY KEY,
  budget_limit NUMERIC(8,2) not null
);

CREATE TABLE transactions (
  id SERIAL PRIMARY KEY,
  value DECIMAL(7,2) not null,
  merchant_id INT REFERENCES merchants(id),
  transaction_date DATE not null,
  tag_id INT REFERENCES tags(id)
);
