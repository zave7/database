--순위구하는 함수
--사원의 급여순위
SELECT first_name, rank() over (ORDER BY salary) 
FROM employees;
--숫자밀림방지
SELECT first_name, salary, dense_rank() over (ORDER BY salary DESC)
FROM employees;
--그룹지어 순위를 구할때
--사원의 부서별 급여 순위
SELECT first_name, rank() over (partition BY department_id ORDER BY salary)
FROM employees;

--주석입니다
SELECT * FROM employees;
--사번, 이름, 부서이름, 급여, 부서원들의 평균급여, 부서내 급여 순위, 전체급여순위로 내림차순정렬

SELECT e.employee_id, e.first_name, e.salary, d.department_id
FROM employees e, departments d
WHERE e.department_id = d.department_id(+);

SELECT avg(salary), e.department_id
FROM employees e, departments d
WHERE e.department_id = d.department_id
GROUP BY e.department_id;

SELECT avg(salary)
FROM employees
WHERE department_id = e.department_id;

SELECT  e.employee_id, e.first_name, d.department_name, e.salary, ROUND((SELECT avg(salary)
                                                        FROM employees
                                                        WHERE department_id = e.department_id)) "부서원 평균 급여",
        rank() over (partition by e.department_id order by salary DESC) "부서내 급여 순위"
FROM employees e, departments d
WHERE e.department_id = d.department_id
ORDER BY salary DESC;