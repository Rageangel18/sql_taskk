SELECT * FROM pg_stat_statements;

CREATE EXTENSION pg_stat_statements;
CREATE EXTENSION pgcrypto;

CREATE TABLE employees (
   id serial PRIMARY KEY,
   first_name VARCHAR(255),
   last_name VARCHAR(255),
   email VARCHAR(255),
   encrypted_password TEXT
);
INSERT INTO employees (first_name, last_name, email, encrypted_password) VALUES
   ('John', 'Doe', 'john.doe@example.com', crypt('password123', gen_salt('bf')));

INSERT INTO employees (first_name, last_name, email, encrypted_password) VALUES
   ('Swag', 'Check', 'hellyeah.doe@example.com', crypt('AXAXAXAXAX', gen_salt('bf')));
   
   SELECT * FROM employees;

UPDATE employees SET last_name = 'Brown' WHERE email = 'jane.smith@example.com';
DELETE FROM employees WHERE email = 'john.doe@example.com';

SELECT * FROM pg_stat_statements; -- all the changes at config file have been made. I have added 2 new lines at the end
--  shared_preload_libraries = 'pg_stat_statements' 
--  pg_stat_statements.track = all

SELECT
    query,
    calls
FROM
    pg_stat_statements
ORDER BY
    calls DESC
LIMIT 10;

SELECT
    query,
    (total_exec_time / calls) AS avg_time
FROM
    pg_stat_statements
ORDER BY
    avg_time DESC
LIMIT 10;

SELECT
    query,
    total_exec_time
FROM
    pg_stat_statements