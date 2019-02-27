-- 사번, 이름, 부서번호, 직원유형
-- 부서번호 60이면 개발자, 
-- 90이면 임원진
-- 나머지 비개발자

SELECT  employee_id, first_name, department_id, 
    case
        when department_id = 60
        then '개발자'
        when department_id = 90
        then '임원진'
        else '비개발자'
    end 직원유형
FROM    employees;

SELECT  employee_id, 
        first_name, 
        department_id,
        decode(department_id, 60, '개발자', 90, '임원진', '비개발자') -- equal 비교만 가능
FROM    employees;

--그룹함수
--회사의 총사원수, 급여 총합, 급여 평균, 최고급여, 최저급여
SELECT count(employee_id), sum(salary), avg(salary), max(salary), min(salary)
FROM employees;

--평균급여보다 많이 받는 사원의 사번, 이름, 급여
SELECT employee_id, first_name, salary
FROM employees
WHERE salary > (SELECT avg(salary) FROM employees);

SELECT 
    case 
        when salary > avg(salary)
        then employee_id
    end 사번,
    case 
        when salary > avg(salary)
        then first_name
    end 이름,
    case 
        when salary > avg(salary)
        then salary
    end 급여
FROM employees; --요거 안되네

--사번, 이름, 부서번호, 부서이름
SELECT employee_id, first_name, department_id, department_name
FROM employees;

--JOIN
--n-1개의 조인조건을 걸어야한다 (n은 조인할 테이블의 갯수)

SELECT * 
FROM employees, departments
WHERE employees.department_id = departments.department_id;
--관계를 맺고 있는 컬럼으로 join 해야한다
--기본키는 유일성과 not null 특성을 가지고있다
--외래키

--테이블에도 별칭을 줄수 있다
SELECT e.employee_id, e.first_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;

--'seattle'에 근무하는 사원의 사번, 이름, 부서이름, 도시이름

SELECT e.employee_id, e.first_name, d.department_name, l.city
FROM employees e, departments d, locations l
WHERE lower(l.city) = lower('seattle') 
and e.department_id = d.department_id
and d.location_id = l.location_id;

--'asia'에 근무하는 사원 이름 부서이름 도시이름
SELECT  e.employee_id, e.first_name, d.department_id, d.department_name, l.city

FROM    employees e, departments d, locations l, countries c, regions r

WHERE   lower(r.region_name) = lower('asia')
and     e.department_id = d.department_id 
and     d.location_id = l.location_id
and     l.country_id = c.country_id
and     c.region_id = r.region_id;

--catesian product
--cross join

--equi join(natural join)ansi

--10,80,90번 부서에 근무중인 사원의
--사번, 이름, 직책이름, 부서이름

SELECT e.employee_id, e.first_name, e.job_id, d.department_name
FROM employees e, departments d
WHERE e.department_id in(10, 80, 90)
and e.department_id = d.department_id;


--직책아이디가 'SA_REP'인 사원의
--사번, 이름, 직책이름, 부서이름
--단, 부서가 없는 경우 '대기발령'으로 출력

SELECT e.employee_id, first_name, e.job_id, nvl(d.department_name, '대기발령')
FROM employees e, departments d
WHERE lower(e.job_id) = lower('SA_REP')
and e.department_id = d.department_id(+);

--사번이 200인 사원의 근무 이력, 

--사번, 이름, 직책이름, 부서이름, 근무개월수 소수둘째
SELECT *
FROM job_history;
--문제를 해결할땐 잘 생각해보고 하자
SELECT  e.employee_id, e.first_name, j.job_title, d.department_name, 
        to_char(round(months_between(jh.end_date, jh.start_date), 2),'999.99')
FROM employees e, job_history jh, departments d, jobs j
WHERE jh.employee_id = 200
and e.employee_id = jh.employee_id
and jh.department_id = d.department_id
and jh.job_id = j.job_id;

SELECT to_date('2000/02/02') - to_date('2000/01/01')
FROM dual;

--모든 사원의 부서이름, 사번, 이름, 매니저사번, 매니저이름
SELECT d.department_name, e.first_name, e.manager_id, m.first_name
FROM employees e, departments d, employees m
WHERE e.department_id = d.department_id
and e.manager_id = m.employee_id;


SELECT e.first_name, m.first_name FROM employees e ,employees m
WHERE e.manager_id = m.employee_id;

SELECT * FROM employees;
-- 'canada'에서 근무하는 사원들의 매니져들의 급여평균을 구하시오
-- 예시 -> 급여평균
            145,000
SELECT avg(m.salary) "급여평균"
FROM countries c, locations l, departments d, employees e, employees m
WHERE lower(c.country_name) = lower('canada')
and c.country_id = l.country_id
and l.location_id = d.location_id
and d.department_id = e.department_id
and e.manager_id = m.employee_id;

-- first_name에 e가 들어가는 사원들의 매니져들 중에서 급여가 10000이상인 사람들의 급여 합계를 구하시오

SELECT sum(m.salary)
FROM employees e, employees m
WHERE e.first_name like '%e%'
and e.manager_id = m.employee_id
and m.salary >= 10000;