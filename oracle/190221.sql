--oo번 사원이 oo번 부서에서 oo업무를 시작하게 된 일자는 oo일 입니다. (별칭 "업무기록")
SELECT employee_id || '번 사원이 ' || department_id || '번 부서에서 ' || job_id || '업무를 시작하게 된 일자는 '
    || start_date || '일 입니다.' "업무기록"
    FROM job_history;

-- 사원이름(풀네임), 입사일, 매니저번호 (매니저가 없을 경우 '-1' 으로 표시)
SELECT first_name || ' ' || last_name, hire_date, nvl(manager_id, -1)
FROM employees;
SELECT * 
FROM job_history;

--2조 문제
--1. employees테이블 제일 앞 열에 새로운  오늘의 날짜를 붙이고 부서번호가 null인 사람을 찾아서 null을 80으로 바꿔라
SELECT sysdate, nvl(department_id, 80)
FROM employees;
--2. 유럽 영국에서 일하는 사람 4명중에 봉급을 제일 많이 받는사람은?
SELECT first_name || ' ' || last_name
FROM employees e, departments d, locations l, countries c, regions r
WHERE e.department_id = d.department_id and
        d.location_id = l.location_id and
        l.country_id = c.country_id and
        country_name = 'United Kingdom';
    SELECT *
    FROM employees;
    SELECT * 
    FROM countries;
    SELECT *
    FROM locations;
    SELECT *
    FROM departments;
--3. jobs 테이블에서 직무 이름과 최소 급여, 최대급여, 평균급여를 출력하고 평균급여의 별칭을 평균 급여로 하시오.
--(평균급여는 최소급여와 최대급여의 평균값으로 한다.)

--4. locations 테이블에서 전체주소를 출력하고 별칭을 주소 로 하시오 . (전체주소 : street_address, city, country_ID )

--5.부서번호가 ()인 사원의 커미션포함급여는 ()이다. 라고 출력하시오

--6.(풀네임은)의 폰번호는 ()이고 이메일은()이다. 라고 출력하시오

--7.'직무'가 받을 수 있는 최저 금액은 ' '원이며, 최고금액은 ' '원입니다. 그리고 그 금액의 차이는 ' '원입니다. 
--(이렇게 쫙 출력되게 쓰기, 테이블의 이름은 as를 이용해서 쇼미더머니로 수정할 것)

--8.

--9.President"의 최대 급여는 40000입니다. (위와 같은 형태로 출력하며, 별칭은 비고로 한다.)

--10.사번, 입사일, 커미션이 포함된 급여를 출력하라. (별칭은 각각 사번, 입사일, 급여_커미션 포함 으로 한다.)