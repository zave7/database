SELECT *
FROM tab;
-- 테이블을 drop 하면 바로 지워지지 않고 bin 에 박아버린다

purge recyclebin; -- bin 에 있는 드랍했던 테이블들을 완전히 삭제

SELECT *
FROM emp_blank; -- 테이블 구조를 카피 할때 제약조건까지 모두 복사한다

-- subquery 를 이용한 insert 
INSERT INTO emp_blank
SELECT *
FROM employees
WHERE department_id = 80;

SELECT *
FROM employees
WHERE department_id = 80;

-- 100번 사원의 사번, 이름, 직책, 부서전호
-- emp_blank
INSERT INTO emp_blank (employee_id, first_name, last_name, email, hire_date, job_id, department_id)
SELECT employee_id, first_name, last_name, email, hire_date, job_id, department_id
FROM employees
WHERE employee_id = 100;

SELECT employee_id, first_name, job_id, department_id
FROM employees
WHERE employee_id = 100;

drop table emp_all;
drop table emp_blank;
drop table emp_50;

create table emp_blank -- 테이블 구조만 가져오고 싶을 경우 이런 방법으로 가능
    AS
    SELECT *
    FROM employees
    WHERE 1=0;
    
SELECT *
FROM emp_blank;

-- update
-- update 는 항상 WHERE 조건을 달고 다니자

SELECT *
FROM member;
commit;
rollback;

UPDATE member
SET pass = 9876;

UPDATE member
SET pass = 9876
WHERE id = '3oracle';

-- 자바2의 비번을 1234로 나이 25 변경
UPDATE member
SET pass = '1234', age = 25
WHERE id = '3oracle';

-- 3oracle의 비번을 5678로 나이는 아이디가 oracle인 사람과 같게 변경
UPDATE member
SET pass = '5678', age = (SELECT age FROM member WHERE id = 'oracle')
WHERE id = '3oracle';

UPDATE member
SET id = 'java2'
WHERE id = '3oracle';

-- DELETE 
-- from 있어도 되고 없어도 된다
-- delete 는 delete all 이 없다
DELETE member_detail WHERE id = 'java2';
DELETE member WHERE id = 'java2';
SELECT *
FROM member;
--자바에서 배치를 이용해 한번의 커넥션으로 해결 가능

-- merge !!! 쓸만할 때가 있어요
drop table product;
create table product (
    pid number,
    pname varchar2(10),
    cnt number,
    price number,
    constraint product_pid_pk primary key (pid)
    );
    
INSERT INTO product (pid, pname, cnt, price)
values (100, '새우깡', 100, 1500);
INSERT INTO product (pid, pname, cnt, price)
values (200, '감자깡', 80, 2000);
INSERT INTO product (pid, pname, cnt, price)
values (300, '고구마깡', 120, 3000);
select *
from product;

-- 상품코드가 400인 자갈치 1200원 150 개 입고

merge INTO product 
using dual
on (pid = 400)
when matched then 
update set cnt = cnt + 150
when not matched then
insert (pid, pname, cnt, price) values (400, '자갈치', 150, 1200);

merge INTO product 
using dual
on (pid = 100)
when matched then 
update set cnt = cnt +50
when not matched then
insert (pid, pname, cnt, price) values (100, '새우깡', 50, 1500);

-- 상품 코드가 100번인 새우깡 1500원 50개 입고


-- transaction --작업의 단위
SELECT *
FROM product;

update product 
set cnt = 800 
where pid=100;

commit;

rollback;
-- rollback 할 지짐 포인트를 설정 savepoint 변수명;
INSERT INTO product 
VALUES ('101', '꿍1', 501, 12001);

INSERT INTO product 
VALUES ('102', '꿍2', 502, 12002);

INSERT INTO product 
VALUES ('103', '꿍3', 503, 12003);

savepoint a;

INSERT INTO product 
VALUES ('104', '꿍4-1', 504, 12004);

INSERT INTO product 
VALUES ('105', '꿍5', 505, 12005);

savepoint b;

INSERT INTO product 
VALUES ('106', '꿍6', 506, 12006);

INSERT INTO product 
VALUES ('107', '꿍7', 507, 12007);

SELECT *
FROM product;

rollback to b;

-- sequence
-- 시퀀스는 오브젝트이다 오브젝트 레벨은 커밋 롤백 불가
-- commit, rollback은 DML에서만 가능

CREATE SEQUENCE product_pid_seq
start with 1 increment by 1;
SELECT *
FROM product;

delete product;
commit;

INSERT INTO product (pid, pname, cnt, price)
VALUES (product_pid_seq.nextval, '이름', 10, 1000);

--하나의 쿼리에서 nextval은 여러번 안됌
SELECT product_pid_seq.nextval, product_pid_seq.nextval, product_pid_seq.currval  --코드 사용이 되면 증가된다
FROM dual;

SELECT 
    product_pid_seq.currval
FROM dual;

rollback;

--일단 마무리