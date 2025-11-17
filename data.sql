create table employee (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    contract_type VARCHAR(50),
    salary INT,
    team_id INT NOT NULL,
    CONSTRAINT fk_employee_team
        FOREIGN KEY (team_id)
        REFERENCES team(id),
)

create table team (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50)
)

create table leave (
    id SERIAL PRIMARY KEY,
    start_date DATE,
    end_date DATE,
    employee_id INT NULL,
    CONSTRAINT fk_leave_employee 
        FOREIGN KEY (employee_id)
        REFERENCES employee(id)
)

1. SELECT e.id, e.first_name, e.last_name
   FROM employee e
   LEFT JOIN team t ON e.team_id = t.id
   WHERE t.id IS NULL;

2. SELECT e.id, e.first_name, e.last_name
   FROM employee e
   LEFT JOIN leave l ON e.id = l.employee_id
   WHERE l.employee_id IS NULL;

3. SELECT 
    l.id AS leave_id,
    l.start_date,
    l.end_date,
    e.first_name,
    e.last_name,
    t.name AS team_name
    FROM leave l
    JOIN employee e ON l.employee_id = e.id
    JOIN team t ON e.team_id = t.id;

4. SELECT 
    contract_type,
    COUNT(*) AS nb_employes
    FROM employee
    GROUP BY contract_type;

5. SELECT COUNT(*) AS nb_employes_en_conge
    FROM leave
    WHERE CURRENT_DATE BETWEEN start_date AND end_date;

6. SELECT 
    e.id,
    e.first_name,
    e.last_name,
    t.name AS team_name
    FROM employee e
    JOIN team t ON e.team_id = t.id
    JOIN leave l ON e.id = l.employee_id
    WHERE CURRENT_DATE BETWEEN l.start_date AND l.end_date;

