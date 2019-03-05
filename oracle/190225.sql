--숫자 함수
SELECT  1234.6438, 
        round(1234.6438), 
        round(1234.6438, 1), 
        round(1234.6438, -1), -- 반올림
        round(1234.6438, 3), 
        round(1234.6438,-3)
        
FROM    dual;
SELECT round(1616.1616)
FROM dual;
--내림 제거
SELECT  1234.6438, 
        trunc(1234.6438), 
        trunc(1234.6438, 1), 
        trunc(1234.6438, -1), 
        trunc(1234.6438, 3), 
        trunc(1234.6438,-3)
        
FROM    dual;
SELECT TRUNC (1616.1616)
FROM dual;
--소수점 제거 후 가장 작은 정수 변환
SELECT  1234.5438, 
        floor(1234.5438)
        
FROM    dual;

--소수점 제거 후 가장 큰 정수 변환
SELECT  CEIL(123.1234)
FROM    dual;

--나머지 연산
SELECT  1+3, 
        MOD(17,5) 
        
FROM    dual;
SELECT MOD((1+3)/2,2)
FROM dual;
--절댓값
SELECT  abs(-1234)
FROM    dual;

--문제
-- 사원의 사번, 이름, 급여, 커미션포함급여
-- 커미션 포함 급여는 100의 자리수로 표현(반올림)
SELECT  employee_id, 
        first_name, 
        salary, 
        round(salary + (salary * nvl(commission_pct, 0)), -2)
        
FROM    employees;
SELECT nvl2(7, 1, 0)
FROM dual;

--문자 함수
SELECT  'kiTRi', 
        lower('kiTRi'), 
        upper('kiTRi'), 
        initcap('kiTRi'), 
        length('kiTRi')
        
FROM    dual;

SELECT  employee_id, 
        first_name || ' '|| last_name, 
        CONCAT(first_name || ' ', last_name)
        
FROM    employees;

SELECT  CONCAT(first_name, CONCAT(' ', last_name)) 
FROM    employees; 

--데이터베이스의 인덱스는 1부터, instr 얘도 많이쓴다고함
SELECT  'hello oracle', substr('hello oracle', -4,7), 
        substr('hello oracle', 3)
        
FROM    dual; 

SELECT  'hello oracle', substr('hello oracle', 1), 
        instr('hello oracle', 'o', 6)
        
FROM    dual; 

--'123-456' zipcode
SELECT  '12345-67' zipcode, 
        substr('12345-67', 1, (instr('12345-67', '-')-1)) zip1, 
        substr('12345-67', (instr('12345-67', '-')+1)) zip2
        
FROM    dual;
-- '-' 2개일 때
SELECT  '010-34-568' pnum, 
        substr('010-34-568', 1, (instr('010-34-568', '-')-1)) pnum1, 
        substr('010-34-568', instr('010-34-568', '-') +1 , (instr('010-34-568', '-', (instr('010-34-568', '-')+1)) - instr('010-34-568', '-')-1)) pnum2,
        substr('010-34-568', (instr('010-34-568', '-', instr('010-34-568', '-')+1)+1)) pnum3
        
FROM    dual;

--주로 커맨드 라인에서 가독성을 높이기 위해 LPAD, RPAD를 사용함trim 도

--날짜함수
SELECT  sysdate +3, 
        sysdate -3, 
        to_char(sysdate + 3 / 24, 'yyyy-hh-mm hh24:mi:ss') --날짜에 계산은 일 단위로 + -
        
FROM    dual;




SELECT  sysdate,                                
        months_between(sysdate, sysdate + 70),  -- 개월차이를 리턴 +day 
        next_day(sysdate, 3),                   -- 오늘 기준으로 다음 요일 날짜를 리턴(1,2,3,4,5,6,7)
        add_months(sysdate, 6),                 -- 개월을 추가
        last_day(sysdate)                       -- 월의 마지막 날짜를 리턴
        
FROM    dual;

-- yyyy 2019
-- yy 19
-- mm 02
-- mon 2월 2jau
-- w 월 주차
-- ww 년 주차
-- d 요일
-- dd 일
-- ddd 년 중 일
-- dy 월 mon
-- day 월요일 monday
SELECT sysdate, to_char(sysdate, 'yyyy yy mm mon month w ww d dd ddd dy day')
FROM dual;
-- pm hh 
-- am hh
-- hh 
-- mi 
-- ss
SELECT sysdate, to_char(sysdate, 'am hh hh24 mi ss')
FROM dual;

-- 날짜 반올림
SELECT  to_char(sysdate, 'yyyy.mm.dd hh24:mi:ss'),
        to_char(round(sysdate), 'yyyy.mm.dd hh24:mi:ss'),
        to_char(round(sysdate, 'mm'), 'yyyy.mm.dd hh24:mi:ss'),
        to_char(round(sysdate, 'yy'), 'yyyy.mm.dd hh24:mi:ss'),
        to_char(round(sysdate, 'hh'), 'yyyy.mm.dd hh24:mi:ss'),
        to_char(round(sysdate, 'mi'), 'yyyy.mm.dd hh24:mi:ss')
        
FROM dual
union
SELECT  to_char(sysdate, 'yyyy.mm.dd hh24:mi:ss'),
        to_char(trunc(sysdate), 'yyyy.mm.dd hh24:mi:ss'),
        to_char(trunc(sysdate, 'mm'), 'yyyy.mm.dd hh24:mi:ss'),
        to_char(trunc(sysdate, 'yy'), 'yyyy.mm.dd hh24:mi:ss'),
        to_char(trunc(sysdate, 'hh'), 'yyyy.mm.dd hh24:mi:ss'),
        to_char(trunc(sysdate, 'mi'), 'yyyy.mm.dd hh24:mi:ss')
        
FROM dual;

-- 자료형 변환 함수
-- to_char, to_number, to_date
-- 오라클의 사칙연산은 산술연산밖에 되지 않는다(자동 형변환 가능) ||가 있으니
SELECT 'a', 3, '3', 3 + 5, '3' + 5
FROM dual;

SELECT  1123456.789,
        to_char(1123456.789, 'L0,000,000,000.00'), -- 남은 공간을 0으로 채움
        to_char(1123456.789, '$9,999,999,999.99')  -- 남은 공간을 공백으로 채움
FROM dual;
 
SELECT '123,456,98', length(to_char(to_number('123,456.98', '000000.00'))) "t"
FROM dual;

SELECT  sysdate, to_char(sysdate, 'yy.mm.dd w ww dy day pm mon month ddd'),
        to_char(sysdate, 'hh:mi:ss'),
        to_char(sysdate, 'hh24:mi:ss')
FROM dual;

--20190225142154 >> 날짜 >> 3일후
SELECT to_char(to_date(to_char(20190225142154, '00000000000000'), 'yyyymmddhh24miss') +3, 'yyyy-mm-dd hh24:mi:ss')
FROM dual;

SELECT to_char(to_date(to_char(20190225142154), 'yyyymmddhh24miss') + 3, 'yyyy--mm-dd hh24:mi:ss')
FROM dual;

--일반함수
--급여가 4000미만인 사원은 저연봉
--  10000미만 평균연봉
-- 10000이상 고연봉
--  사번, 이름, 급여, 연봉등급
SELECT nvl2(commission_pct, 1, 2)
FROM employees;
SELECT employee_id, first_name, salary, 
    case 
        when salary < 4000
        then '저연봉'
        when salary < 10000
        then '평균연봉'
        else '고연봉'
    end 연봉등급
FROM employees
ORDER BY salary desc;

SELECT employee_id, 
    case 
        when commission_pct is not null
        then '커미션 있음!!'
        else '  커미션 없음'
    end 커미션여부
FROM employees;
SELECT salary 급여
FROM employees;

--사원구분
--1980년도 입사 임원
-- 90 평사원
-- 2000 신입사원
--사번,이름,입사일,사원구분

SELECT  employee_id 사번, first_name 이름 , hire_date 입사일, 

    case
        when to_number(to_char(hire_date, 'yyyy'), '0000') < 1990 
        then '임원'
        when to_number(to_char(hire_date, 'yyyy'), '0000') < 2000
        then '평사원'
        else '신입사원'
    end 사원구분
    
FROM employees;

SELECT ascii('0') || ' 48', ascii('A') || ' 65', ascii('a') || ' 97'
FROM dual;

SELECT case when 'abc'<'abd' then '작다'
end 비교
FROM dual;

SELECT chr(48)
FROM dual;

--문제 
--사번, 이름, 핸드폰번호, 입사월홀짝, 입사년도일수
SELECT to_char(hire_date, 'ddd') 
FROM employees;
SELECT * from employees;
SELECT  phone_number, 
        substr('010-34568-1234-4321', 1, (instr('010-34568-1234-4321', '-')-1)) pnum1,
        case
            when instr('010-34568-1234-4321', '-', (instr('010-34568-1234-4321', '-')+1)) !=0
            then substr('010-34568-1234-4321', instr('010-34568-1234-4321', '-') +1 , (instr('010-34568-1234-4321', '-', (instr('010-34568-1234-4321', '-')+1)) - instr('010-34568-1234-4321', '-')-1))
            else 'x'
        end pnum2,
        case 
            when instr('010-34568-1234-4321', '-', instr('010-34568-1234-4321', '-', instr('010-34568-1234-4321', '-')+1)+1) !=0
            then substr('010-34568-1234-4321', instr('010-34568-1234-4321', '-', instr('010-34568-1234-4321', '-')+1)+1 , instr('010-34568-1234-4321', '-', instr('010-34568-1234-4321', '-', instr('010-34568-1234-4321', '-')+1)+1) - (instr('010-34568-1234-4321', '-', instr('010-34568-1234-4321', '-')+1)+1))
            else 'x'
        end pnum3,
        case 
            when instr('010-34568-1234-4321', '-', instr('010-34568-1234-4321', '-', instr('010-34568-1234-4321', '-', instr('010-34568-1234-4321', '-')+1)+1)+1) !=0
            then substr('010-34568-1234-4321', instr('010-34568-1234-4321', '-', instr('010-34568-1234-4321', '-', instr('010-34568-1234-4321', '-')+1)+1))
            else 'x'
        end pnum4
FROM employees;

    SELECT instr('010-34568-1234-1234', '-', instr('010-34568-1234-1234', '-', instr('010-34568-1234-1234', '-')+1)+1) - (instr('010-34568-1234-1234', '-', instr('010-34568-1234-1234', '-')+1)+1)
    from dual;
    SELECT instr('010-34568-1234-4321', '-', instr('010-34568-1234-4321', '-', instr('010-34568-1234-4321', '-', instr('010-34568-1234-4321', '-')+1)+1)+1)
    FROM dual;
SELECT  '010-34-568' pnum, 
        substr('010-34-568', 1, (instr('010-34-568', '-')-1)) pnum1, 
        substr('010-34-568', instr('010-34-568', '-') +1 , (instr('010-34-568', '-', (instr('010-34-568', '-')+1)) - instr('010-34-568', '-')-1)) pnum2,
        substr('010-34-568', (instr('010-34-568', '-', instr('010-34-568', '-')+1)+1)) pnum3
        
FROM    dual;

