-- 모든 사원의 사번, 이름, 급여, 급여등급

SELECT employee_id, first_name, salary, 
    case 
        when salary between 1000 and 2999
        then 'A'
        when salary between 3000 and 5999
        then 'B'
        when salary between 6000 and 9999
        then 'C'
        when salary between 10000 and 14999
        then 'D'
        when salary between 15000 and 24999
        then 'E'
        when salary between 25000 and 40000
        then 'F'
    end 급여등급
FROM employees e
ORDER BY 급여등급;
SELECT *
FROM job_grades;
-- non-equi join

SELECT e.employee_id, e.first_name, e.salary, jg.grade_level
FROM employees e, job_grades jg
WHERE salary >= jg.lowest_sal 
and salary <= jg.highest_sal;

SELECT *
FROM employees e, job_grades jg
WHERE salary between jg.lowest_sal and jg.highest_sal;

--outer join
--모든 사원의 사번, 이름, 부서번호, 부서이름
--단,부서가 미지정일 경우 부서이름을 '대기발령중'
SELECT e.employee_id, e.first_name, d.department_id, nvl(d.department_name, '대기발령중')
FROM employees e, departments d
WHERE e.department_id = d.department_id(+);

SELECT *
FROM employees
WHERE department_id is null;

-- 모든 사원의 사번, 이름, 상관사번, 상관이름
-- 단, 상관이 없을 경우 상관이름에 '사장'으로 출력

SELECT e.employee_id, e.first_name, e.manager_id, nvl(m.first_name,'사장')
FROM employees e, employees m
WHERE e.manager_id = m.employee_id(+);

-- 모든 사원의 사번, 이름, 상관사번, 상관이름, 부서이름
-- 단, 상관이 없을 경우 상관이름에 '사장'으로 출력
-- 단, 부서가 미지정일 경우 부서이름을 '대기발령중'으로 출력
SELECT  e.employee_id, 
        e.first_name, 
        e.manager_id, 
        nvl(m.first_name, '사장'), 
        nvl(d.department_name, '대기발령중')
FROM employees e, employees m, departments d
WHERE e.manager_id = m.employee_id(+)
and e.department_id = d.department_id(+);

--ANSI JOIN 표준

SELECT * 
FROM employees, departments;

SELECT * 
FROM employees CROSS JOIN departments;

--사번, 이름, 부서이름
SELECT e.employee_id, e.first_name, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;

--INNER JOIN

--INNER JOIN 이너 조인은 INNER를 빼도 된다(default)
--on은 조인조건만 기술하는 키워드
--조건은 WHERE 절에
SELECT e.employee_id, e.first_name, d.department_name
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id
WHERE e.department_id = 50;

SELECT e.employee_id, e.first_name, d.department_name
FROM employees e JOIN departments d
ON e.department_id = d.department_id
WHERE e.department_id = 50;

--USING을 쓸 때는 테이블의 조인조건을 걸 컬럼명이 동일해야한다.
--WHERE 에는 별칭을 붙여 식별할 필요가 없다
SELECT e.employee_id, e.first_name, d.department_name
FROM employees e JOIN departments d
USING (department_id)
WHERE department_id = 50;

--NUTURAL JOIN 모든 동일 컬럼을 이용해 조인을 한다
--그렇기 때문에 동일컬럼이 1개인경우에만 사용하는게 좋다
SELECT e.employee_id, e.first_name, d.department_name
FROM employees e NATURAL JOIN departments d
WHERE department_id = 50;

-- 'Seattle'에 근무하는 사번, 이름, 부서이름, 도시
SELECT e.employee_id, e.first_name, d.department_name, l.city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id
and d.location_id = l.location_id
and l.city = 'Seattle';

--조인 테이블이 3개 이상일 경우
SELECT e.employee_id, e.first_name, d.department_name, l.city
FROM employees e 
    JOIN departments d
        ON e.department_id = d.department_id
    JOIN locations l
        ON d.location_id = l.location_id
WHERE l.city = 'Seattle';

--outer join
--모든 사원의 사번, 이름, 부서번호, 부서이름

SELECT e.employee_id, e.first_name, d.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id(+);

SELECT e.employee_id, e.first_name, d.department_id, nvl(d.department_name, '대기발령중')
FROM employees e LEFT OUTER JOIN departments d
ON e.department_id = d.department_id;

--모든 부서의 근무하는 사원의 사번, 이름(사원없음), 부서번호, 부서이름
SELECT e.employee_id, nvl(e.first_name, '사원없음'), d.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id(+) = d.department_id;

SELECT e.employee_id, nvl(e.first_name, '사원없음'), d.department_id, d.department_name
FROM employees e RIGHT OUTER JOIN departments d
ON e.department_id = d.department_id;


--모든 부서에 모든 사원의 근무하는 사원의 사번, 이름(사원없음), 부서번호, 부서이름

SELECT  e.employee_id, 
        nvl(e.first_name, '사원없음'), 
        d.department_id, 
        nvl(d.department_name, '대기발령중')
        
FROM employees e, departments d
WHERE e.department_id(+) = d.department_id
AND e.department_id = d.department_id(+); --안댐

SELECT  e.employee_id, 
        nvl(e.first_name, '사원없음'), 
        d.department_id, 
        nvl(d.department_name, '대기발령중')
        
FROM employees e FULL OUTER JOIN departments d

ON e.department_id = d.department_id;

--모든 부서에 모든 사원의 근무하는 사원의 사번, 이름(사원없음), 부서번호, 부서이름
SELECT  e.employee_id, 
        nvl(e.first_name, '사원없음'), 
        d.department_id, 
        nvl(d.department_name, '대기발령중')
        
FROM employees e FULL OUTER JOIN departments d

ON e.department_id = d.department_id;

--권영찬 0227
--테이블에 존재하는 모든 나라와 대륙을 출력(대륙은 중복해서 나와도 됨)
--나라, 대륙
SELECT c.country_name, r.region_name
FROM countries c FULL OUTER JOIN regions r
ON c.region_id = r.region_id;
select *
from regions;

--부서장이 일하고 있는 지역이름  
--부서장 이름, 부서이름, 지역이름(없을 경우 '부서장없음')
SELECT nvl(e.first_name, '부서장 없음'), d.department_name, l.city
FROM departments d, employees e, locations l
WHERE d.manager_id = e.employee_id(+)
AND d.location_id = l.location_id;