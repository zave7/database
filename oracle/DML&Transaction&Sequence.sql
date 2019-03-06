SELECT *
FROM tab;
-- ���̺��� drop �ϸ� �ٷ� �������� �ʰ� bin �� �ھƹ�����

purge recyclebin; -- bin �� �ִ� ����ߴ� ���̺���� ������ ����

SELECT *
FROM emp_blank; -- ���̺� ������ ī�� �Ҷ� �������Ǳ��� ��� �����Ѵ�

-- subquery �� �̿��� insert 
INSERT INTO emp_blank
SELECT *
FROM employees
WHERE department_id = 80;

SELECT *
FROM employees
WHERE department_id = 80;

-- 100�� ����� ���, �̸�, ��å, �μ���ȣ
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

create table emp_blank -- ���̺� ������ �������� ���� ��� �̷� ������� ����
    AS
    SELECT *
    FROM employees
    WHERE 1=0;
    
SELECT *
FROM emp_blank;

-- update
-- update �� �׻� WHERE ������ �ް� �ٴ���

SELECT *
FROM member;
commit;
rollback;

UPDATE member
SET pass = 9876;

UPDATE member
SET pass = 9876
WHERE id = '3oracle';

-- �ڹ�2�� ����� 1234�� ���� 25 ����
UPDATE member
SET pass = '1234', age = 25
WHERE id = '3oracle';

-- 3oracle�� ����� 5678�� ���̴� ���̵� oracle�� ����� ���� ����
UPDATE member
SET pass = '5678', age = (SELECT age FROM member WHERE id = 'oracle')
WHERE id = '3oracle';

UPDATE member
SET id = 'java2'
WHERE id = '3oracle';

-- DELETE 
-- from �־ �ǰ� ��� �ȴ�
-- delete �� delete all �� ����
DELETE member_detail WHERE id = 'java2';
DELETE member WHERE id = 'java2';
SELECT *
FROM member;
--�ڹٿ��� ��ġ�� �̿��� �ѹ��� Ŀ�ؼ����� �ذ� ����

-- merge !!! ������ ���� �־��
drop table product;
create table product (
    pid number,
    pname varchar2(10),
    cnt number,
    price number,
    constraint product_pid_pk primary key (pid)
    );
    
INSERT INTO product (pid, pname, cnt, price)
values (100, '�����', 100, 1500);
INSERT INTO product (pid, pname, cnt, price)
values (200, '���ڱ�', 80, 2000);
INSERT INTO product (pid, pname, cnt, price)
values (300, '������', 120, 3000);
select *
from product;

-- ��ǰ�ڵ尡 400�� �ڰ�ġ 1200�� 150 �� �԰�

merge INTO product 
using dual
on (pid = 400)
when matched then 
update set cnt = cnt + 150
when not matched then
insert (pid, pname, cnt, price) values (400, '�ڰ�ġ', 150, 1200);

merge INTO product 
using dual
on (pid = 100)
when matched then 
update set cnt = cnt +50
when not matched then
insert (pid, pname, cnt, price) values (100, '�����', 50, 1500);

-- ��ǰ �ڵ尡 100���� ����� 1500�� 50�� �԰�


-- transaction --�۾��� ����
SELECT *
FROM product;

update product 
set cnt = 800 
where pid=100;

commit;

rollback;
-- rollback �� ���� ����Ʈ�� ���� savepoint ������;
INSERT INTO product 
VALUES ('101', '��1', 501, 12001);

INSERT INTO product 
VALUES ('102', '��2', 502, 12002);

INSERT INTO product 
VALUES ('103', '��3', 503, 12003);

savepoint a;

INSERT INTO product 
VALUES ('104', '��4-1', 504, 12004);

INSERT INTO product 
VALUES ('105', '��5', 505, 12005);

savepoint b;

INSERT INTO product 
VALUES ('106', '��6', 506, 12006);

INSERT INTO product 
VALUES ('107', '��7', 507, 12007);

SELECT *
FROM product;

rollback to b;

-- sequence
-- �������� ������Ʈ�̴� ������Ʈ ������ Ŀ�� �ѹ� �Ұ�
-- commit, rollback�� DML������ ����

CREATE SEQUENCE product_pid_seq
start with 1 increment by 1;
SELECT *
FROM product;

delete product;
commit;

INSERT INTO product (pid, pname, cnt, price)
VALUES (product_pid_seq.nextval, '�̸�', 10, 1000);

--�ϳ��� �������� nextval�� ������ �ȉ�
SELECT product_pid_seq.nextval, product_pid_seq.nextval, product_pid_seq.currval  --�ڵ� ����� �Ǹ� �����ȴ�
FROM dual;

SELECT 
    product_pid_seq.currval
FROM dual;

rollback;

--�ϴ� ������