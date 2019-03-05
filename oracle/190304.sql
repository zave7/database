-- 부서번호가 50이거나, 90인 사원과
-- 급여가 10000이상인 사원
-- 사번, 이름, 급여, 부서번호
-- db에 연결했다 끊는 작업이 크다
SELECT *
FROM employees;

-- union 중복 제거
SELECT employee_id, first_name, salary, department_id
FROM employees
WHERE department_id in (50, 90)
union 
SELECT employee_id, first_name, salary, department_id
FROM employees
WHERE salary > 10000;

-- union 중복 제거 x
SELECT employee_id, first_name, salary, department_id
FROM employees
WHERE department_id in (50, 90)
union all
SELECT employee_id, first_name, salary, department_id
FROM employees
WHERE salary > 10000;

-- INTERSECT 교집합을 구함
SELECT employee_id, first_name, salary, department_id
FROM employees
WHERE department_id in (50, 90)
intersect
SELECT employee_id, first_name, salary, department_id
FROM employees
WHERE salary > 10000;

-- MINUS
SELECT employee_id, first_name, salary, department_id
FROM employees
WHERE department_id in (50, 90)
MINUS
SELECT employee_id, first_name, salary, department_id
FROM employees
WHERE salary > 10000;

-- 부서별 급여총합, 평균급여, 사원수, 최대급여, 최소급여
-- 그룹핑을 한 컬럼과, 그룹함수는 쓸수 있다
SELECT  nvl(d.department_name, '부서없음') "부서이름", 
        sum(e.salary) 총합, 
        round(avg(e.salary), 2) 평균급여, 
        count(e.employee_id) 사원수, 
        max(e.salary) 최대급여, 
        min(e.salary) 최소급여
FROM employees e, departments d
WHERE e.department_id = d.department_id (+)
GROUP BY nvl(d.department_name, '부서없음');

-- 부서별 급여총합, 평균급여, 사원수, 최대급여, 최소급여
-- 평균급여가 5000이하인 부서
SELECT  nvl(d.department_name, '부서없음') "부서이름", 
        sum(e.salary) 총합, 
        round(avg(e.salary), 2) 평균급여, 
        count(e.employee_id) 사원수, 
        max(e.salary) 최대급여, 
        min(e.salary) 최소급여
FROM employees e, departments d
WHERE e.department_id = d.department_id (+)
GROUP BY nvl(d.department_name, '부서없음')
having round(avg(e.salary), 2) <= 5000;

-- 각 부서별 평균 급여보다 많이 받는
-- 사번, 이름, 급여

SELECT employee_id, first_name, salary
FROM employees
WHERE salary >  all(SELECT avg(salary) 
                    FROM employees 
                    GROUP BY department_id);
                    
-- 자신의 부서 평균 급여보다 많이 받는
-- 사번, 이름, 급여
SELECT e.employee_id, e.first_name, e.salary
FROM employees e,   (SELECT department_id, avg(salary) asal 
                    FROM employees 
                    GROUP BY department_id) d
WHERE e.department_id = d.department_id
AND d.asal > e.salary;

-- 부서별 최고 급여를 받는 사원의
-- 부서이름, 사번, 이름, 급여

SELECT d.department_name, e.employee_id, e.first_name, e.salary
FROM employees e, departments d,    (SELECT department_id, max(salary) msal 
                                    FROM employees 
                                    GROUP BY department_id) ms
WHERE e.department_id = d.department_id
AND e.department_id = ms.department_id
AND e.salary = ms.msal;

-- 이거랑 위는 다르다
SELECT d.department_name, e.employee_id, e.first_name, e.salary
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.salary in (SELECT max(salary) msal 
                FROM employees 
                GROUP BY department_id);
-- 부서별 최고 급여를 받는 사원의
-- 부서이름, 사번, 이름, 급여

SELECT d.department_name, e.employee_id, e.first_name, e.salary
FROM employees e,   (SELECT department_id, max(salary) msal
                    FROM employees
                    GROUP BY department_id) m, departments d
WHERE e.department_id = m.department_id
AND e.department_id = d.department_id
AND e.salary = m.msal;

-- rownum 행번호!!
-- 크다 비교는 불가
-- rownum 이 SELECT 절에 꼭 와야하는건 아니다
SELECT rownum, employee_id, salary
FROM employees
ORDER BY salary desc;

SELECT rownum, employee_id, salary
FROM employees
WHERE rownum < 12
ORDER BY salary desc;

SELECT rownum, employee_id, salary
FROM employees
WHERE rownum between 5 and 10;

--TOP N query
-- 순위, 사번, 이름, 급여, 입사년대, 부서이름, 
-- 급여순 순위, 
-- 한 페이지당 5명씩 출력
-- 2page 출력
-- 1980년대, 1990년대, 2000년대

SELECT  base2.*

FROM    (SELECT rownum rnum, base1.*

        FROM    (SELECT e.employee_id employee_id,
                        e.first_name first_name, 
                        e.salary salary, 
                        concat(trunc(to_char(e.hire_date, 'yyyy'),-1), '년대') "입사년대", 
                        d.department_name department_name
                FROM employees e, departments d 
                WHERE e.department_id = d.department_id(+)
                ORDER BY salary DESC) base1
                
        WHERE rownum <= (&a * 5)) base2
        
WHERE rnum >= (&a * 5) - 4; -- rnum >= (&a * 5) - 5 이게 더 낫다

--튜닝
SELECT  rnum, employee_id, first_name, salary, concat(trunc(to_char(hire_date, 'yyyy'),-1), '년대') "입사년대", department_name

FROM    (SELECT rownum rnum, base1.*

        FROM    (SELECT employee_id,
                        first_name, 
                        salary,  
                        hire_date,
                        department_id
                FROM employees
                ORDER BY salary DESC) base1
                
        WHERE rownum <= (&a * 5)) base2, departments d
        
WHERE rnum >= (&a * 5) - 4
AND base2.department_id = d.department_id(+)
ORDER BY rnum;

-- 1 1-5  2 6-10  3   11-15
--  1페이지당 5명 뿌려라
-- (&a * 5) - 4  -> 제일 작은 랭크
-- &a * 5 -> 제일 큰 랭크

-- rank() over()
SELECT t.rnum, t.employee_id, t.first_name, t.salary, concat(trunc(to_char(t.hire_date, 'yyyy'), -1), '년대')
FROM    (SELECT rank() over(ORDER BY salary DESC) rnum, employee_id, first_name, salary, hire_date
        FROM employees) t
WHERE t.rnum <= (&a * 5) and t.rnum > (&a * 5) - 5;
