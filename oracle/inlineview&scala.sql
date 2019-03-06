--부서이름이 'IT'에 근무하는 사원의 사번, 이름, 급여

SELECT  e.employee_id, e.first_name, e.salary
FROM    employees e, departments d
WHERE   e.department_id = d.department_id
AND     lower(d.department_name) = lower('IT');

--조인을 했을때 안좋은점 카테시안 프로덕트를 하고 뽑아오기 때문에
--데이터의 양이 많으면 비효율적

SELECT  employee_id, first_name, salary
FROM    employees
WHERE   lower(d.department_name) = lower('IT');
--
SELECT  department_id 
FROM    departments
WHERE   department_name = 'IT';
--
SELECT  employee_id, first_name, salary
FROM    employees
WHERE   department_id = 60;

--가독성을 높이자
SELECT  employee_id, first_name, salary
FROM    employees
WHERE   department_id =     (SELECT department_id 
                            FROM departments
                            WHERE department_name = 'IT'
                            );

--'Seattle' 에 근무하는 사원의 사번, 이름, 급여
SELECT  employee_id, first_name, salary
FROM    employees
WHERE   department_id in    ((SELECT department_id
                            FROM departments
                            WHERE location_id =     (SELECT l.location_id
                                                    FROM locations l
                                                    WHERE l.city = 'Seattle')));
--
SELECT  location_id
FROM    locations
WHERE   city = 'Seattle';
--
SELECT  department_id
FROM    departments
WHERE   location_id =   (SELECT location_id
                        FROM locations
                        WHERE city = 'Seattle');
--
SELECT  employee_id, first_name, salary
FROM    employees
WHERE   department_id in    ((SELECT department_id
                            FROM departments
                            WHERE location_id =     (SELECT location_id
                                                    FROM locations
                                                    WHERE city = 'Seattle')));

-- join + subquery
SELECT  e.employee_id, 
        e.first_name, 
        e.salary, 
        d.department_name
        
FROM    employees e, 
        departments d
        
WHERE   e.department_id = d.department_id

AND     d.location_id =     (SELECT location_id
                            FROM locations
                            WHERE city = 'Seattle');

--지역번호가 1700인 부서에서 일하는 사원의
-- 사번, 이름, 부서번호 ,부서이름
--160행을 조합한다
SELECT  e.employee_id, 
        e.first_name, 
        e.department_id, 
        d.department_name
        
FROM    employees e, departments d
WHERE   e.department_id = d.department_id
AND     d.location_id = 1700;

--인라인 뷰 라는 명칭으로 불린다.
SELECT e.employee_id, e.first_name, e.department_id, d.department_name
FROM employees e,   (SELECT department_id, department_name
                    FROM departments
                    WHERE location_id = 1700) d
                    
WHERE e.department_id = d.department_id;

SELECT department_id, department_name
FROM departments
WHERE location_id = 1700;

--'Kevin' 보다 급여를 많이 받는 사원의 사번, 이름, 급여
SELECT employee_id, first_name, salary
FROM employees
WHERE salary >  (SELECT salary
                FROM employees 
                WHERE first_name = 'Kevin');
-- 50번 부서에 있는 사원들 보다 급여를 많이 받는 사원의 사번, 이름, 급여
SELECT employee_id, first_name, salary
FROM employees
WHERE salary > all (SELECT salary FROM employees WHERE department_id = 50);

-- 부서에 근무하는 모든 사원들의 평균 급여보다 많이 받는 사원의 사번, 이름, 급여
-- 상호관련서브쿼리
SELECT employee_id, first_name, salary
FROM employees
WHERE salary >  (SELECT avg(salary) 
                FROM employees 
                WHERE department_id is not null);
                
-- 각 사원의 같은 부서에 근무하는 사원들의 평균 급여보다 많이 받는 사원의 사번, 이름, 급여
-- 부서가 없는 사람은 출력하지 않는다
SELECT employee_id, first_name, salary
FROM employees;

SELECT round(avg(salary), 2) "asal", department_id
FROM employees
GROUP BY department_id;

SELECT e.employee_id, e.first_name, e.salary, d.asal, d.department_id
FROM employees e,   (SELECT avg(salary) asal, department_id
                    FROM employees
                    GROUP BY department_id) d
WHERE e.department_id = d.department_id
AND e.salary > d.asal
ORDER BY d.department_id;

--부서번호가 20번의 평균 급여보다 크고, 
--매니저가 있는 사원으로 부서 번호가 20이 아닌 사원의
--사번, 이름, 급여, 부서번호

SELECT employee_id, first_name, salary, department_id
FROM employees
WHERE salary >  (SELECT avg(salary)
                FROM employees
                WHERE department_id = 20)
AND manager_id is not null
AND department_id != 20;

--부서번호가 20번의 평균 급여보다 크고, 
--매니저인 사원으로 부서 번호가 20이 아닌 사원의
--사번, 이름, 급여, 부서번호
SELECT e.employee_id, e.first_name, e.salary, e.department_id
FROM employees e,    (SELECT employee_id
                    FROM employees e
                    WHERE salary >  (SELECT avg(salary)
                                    FROM employees
                                    WHERE department_id = 20)) d
WHERE d.employee_id = e.manager_id;
--
SELECT e20.employee_id, e20.first_name, e20.salary, e20.department_id
FROM    (SELECT distinct manager_id 
        FROM employees
        WHERE manager_id is not null) m, 
        (SELECT employee_id, 
                first_name, 
                salary, 
                department_id
        FROM employees
        WHERE salary >  (SELECT avg(salary)
                        FROM employees
                        WHERE department_id = 20)) e20
WHERE m.manager_id = e20.employee_id
AND department_id != 20;
--
SELECT e20.employee_id, e20.first_name, e20.salary, e20.department_id
FROM     
        (SELECT employee_id, 
                first_name, 
                salary, 
                department_id
        FROM employees
        WHERE salary >  (SELECT avg(salary)
                        FROM employees
                        WHERE department_id = 20)) e20
WHERE e20.employee_id = (SELECT distinct manager_id 
                        FROM employees
                        WHERE manager_id is not null)
AND department_id != 20;

--부서번호가 20번의 평균 급여보다 크고, 
--부서장 사원으로 부서 번호가 20이 아닌 사원의
--사번, 이름, 급여, 부서번호
SELECT  e.employee_id, 
        e.first_name, 
        e.salary, 
        e.department_id
FROM    employees e, departments d
WHERE   salary >    (SELECT avg(salary)
                    FROM employees
                    WHERE department_id = 20)
AND     e.employee_id = d.manager_id
AND     e.department_id != 20;

SELECT  *
FROM    departments;

--20번 부서의 평균급여
--50번 부서의 급여총합
--80번 부서의 인원수

--scala 서브쿼리에는 단일 행, 단일 컬럼만 올 수 있다.
--스칼라 서브쿼리란 Select-List에서 서브쿼리가 사용될 때 이를 스칼라 서브쿼리라 칭함.
--스칼라 서브쿼리의 특징은 다음과 같음.
--하나의 레코드만 리턴이 가능하며, 두개 이상의 레코드는 리턴할 수 없다.
--일치하는 데이터가 없더라도 NULL값을 리턴할 수 있다.
--이는 원래 그룹함수의 특징중에 하나인데 스칼라 서브쿼리 또한 이 특징을 가지고 있다.

--그룹함수의 특징을 가지고있음
SELECT  (SELECT AVG(salary) FROM employees WHERE department_id = 20) "20번 부서 평균 급여",
        (SELECT SUM(salary) FROM employees WHERE department_id = 50) "50번 부서 급여총합",
        (SELECT COUNT(*) FROM employees WHERE department_id = 80) "80번 부서의 인원수"
FROM    dual;

--모든 사원, 사번, 이름, 급여 등급, 부서이름
--단, A는 1등급, B는 2등급 ... F는 6등급

SELECT  e.employee_id, 
        e.first_name, 
        e.salary, 
        decode(jg.grade_level, 'A','1등급',
                            'B','2등급',
                            'C','3등급',
                            'D','4등급',
                            'E','5등급',
                            'F','6등급') "급여등급",
        d.department_name
FROM    employees e, departments d, job_grades jg 
WHERE   e.department_id = d.department_id(+)
AND     e.salary between jg.lowest_sal and jg.highest_sal
ORDER BY e.salary desc;
--
SELECT  e.employee_id, d.department_name,
        e.first_name, 
        e.salary,
        case
            when (SELECT grade_level FROM job_grades WHERE e.salary between lowest_sal and highest_sal) = 'A'
            then '1등급'
            when (SELECT grade_level FROM job_grades WHERE e.salary between lowest_sal and highest_sal) = 'B'
            then '2등급'
            when (SELECT grade_level FROM job_grades WHERE e.salary between lowest_sal and highest_sal) = 'C'
            then '3등급'
            when (SELECT grade_level FROM job_grades WHERE e.salary between lowest_sal and highest_sal) = 'D'
            then '4등급'
            when (SELECT grade_level FROM job_grades WHERE e.salary between lowest_sal and highest_sal) = 'E'
            then '5등급'
            when (SELECT grade_level FROM job_grades WHERE e.salary between lowest_sal and highest_sal) = 'F'
            then '6등급'
            else '등급에 없음'
        end 급여등급
FROM employees e, departments d
WHERE e.department_id = d.department_id;
--
SELECT  e.employee_id, d.department_name,
        e.first_name, 
        e.salary,
        decode((SELECT grade_level FROM job_grades WHERE e.salary between lowest_sal and highest_sal),
            'A','1등급','B','2등급','C','3등급','D','4등급','E','5등급','F','6등급')
FROM employees e, departments d
WHERE e.department_id = d.department_id;
SELECT *
FROM job_grades;
--ORDER BY 절에도 서브쿼리 가능
--GROUP BY 에도 가능

--사번, 이름, 경력(n년 m개월), 급여등급, 급여순위
SELECT  e.employee_id, e.first_name, concat(to_char(trunc(months_between(sysdate,e.hire_date)/12)), '개월'),
        (SELECT count(employee_id) FROM employees WHERE e.salary > salary)
FROM employees e;
