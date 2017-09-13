SELECT e.first_name,e.last_name, e.department_id, d.department_name 
FROM employees e 
LEFT JOIN departments d ON e.department_id=d.department_id;

SELECT e.first_name,e.last_name, d.department_name, l.city, l.state_province
FROM employees e LEFT JOIN departments d ON d.department_id=e.department_id
LEFT JOIN locations l on d.location_id=l.location_id;

SELECT*FROM hr.jobs;

SELECT e.first_name,e.last_name,e.department_id,d.department_name
FROM employees e JOIN departments d ON e.department_id=d.department_id
WHERE e.department_id=40 OR e.department_id=80;

SELECT e.first_name, e.last_name,d.department_name,l.city,l.state_province
FROM employees e LEFT JOIN departments d ON d.department_id=e.department_id
LEFT JOIN locations l ON d.location_id=l.location_id
WHERE e.first_name LIKE '%z%';

#SELECT d.department_name,e.first_name,e.last_name, e.department_id
#FROM departments d LEFT JOIN employees e ON e.department_id=d.department_id

#SELECT first_name, last_name, salary
#FROM employees
#WHERE salary<(SELECT salary FROM employees WHERE employee_id=182);

SELECT e.first_name,e.last_name,e.salary
FROM employees e JOIN employees ee ON e.salary < ee.salary WHERE ee.employee_id=182;

SELECT e.first_name as 'Pracownik Name', m.first_name as 'Szef Name'
FROM employees e left JOIN employees m ON e.manager_id=m.employee_id;

#13
SELECT j.job_title, d.department_name, e.first_name,e.last_name, jh.start_date
FROM job_history jh JOIN jobs j USING (job_id)
JOIN departments d USING (department_id)
JOIN employees e USING (employee_id)
WHERE jh. start_date >= "1993-01-01" AND jh.start_date <= "1997-08-31";

#14
SELECT country_name, city, department_name
FROM countries JOIN locations USING(country_id)
JOIN departments USING(location_id);

#15
SELECT department_name,first_name,last_name
FROM departments d JOIN employees e ON(d.manager_id=e.employee_id);
#16
SELECT country_name, city, COUNT(department_id) AS 'Ilosc departamentow'
FROM countries JOIN locations USING(country_id)
JOIN departments USING(location_id)
WHERE department_id IN (SELECT department_id FROM employees GROUP BY department_id HAVING COUNT(department_id)>=2)GROUP BY country_name,city;

