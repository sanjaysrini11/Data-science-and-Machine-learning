use hr;
select * from employees;
select employee_id, first_name, last_name from employees;

select first_name, last_name,department_id,salary from employees WHERE salary >= 20000;


select first_name, last_name, email, salary, manager_id from employees WHERE manager_id = 120 or manager_id = 103 or manager_id = 145;

#Write  a  query  in  SQL  to  display  the  first_name  and  last_name,department_id  and salary from employees Table who earn more than 8000 And whose managers_ID  is 120, 103 or 145.(3rows)

select first_name, last_name, department_id, salary from employees WHERE salary > 8000 and manager_id in (120,103,145);

select * from departments;

select department_id, department_name, manager_id from departments where manager_id >= 200 and location_id=2400;


select job_title from jobs where min_salary > 8000 and max_salary < 20000;

#Write a query to retrieve all the records of departments with managers for the location id 1700
 select * from departments where manager_id is not null and location_id=1700;
 
 select * from departments where department_name like 'P%' and manager_id is not null;