--DDL data definition language

-- char �������� max 2000 byte
-- varchar2�� �������� max 4000 byte

-- ksc5601 - euc-kr �ѱ� 2byte

-- utf �����ڵ� ������ ��繮�� ǥ�� �ѱ� 3byte
-- ����Ŭ���� long Ÿ���� �˻��ӵ� �����ٰ���
-- LOB large object , blob(binary) clob(charactor) max 4GB
-- db���� ������ ������ ������
-- �Ϲ������� Ÿ�ӽ��������� ����Ʈ�� ���� ����

-- ȸ�� member (�ʼ�)

-- �̸�            name        varchar2(30)
-- ���̵�          id          varchar2(16)
-- ��й�ȣ        pass        varchar(16)
-- ����            age         number(3)
-- �̸��Ͼ��̵�    emailid     varchar(30)
-- �̸��ϵ�����    emaildomain varchar(30)
-- ������          joindate    date

create table member (
    name varchar2(30) not null,
    id varchar2(16) ,
    pass varchar2(16) not null,
    age number(3) check (age < 150),
    emailid varchar2(30),
    emaildomain varchar2(30),
    joindate date default sysdate,
    
    constraint member_id_pk primary key (id) -- constraint ���� ���� �Ŵ� ���
); --���̺� ���������� ������ ���� �����ʴ�

DROP table member; -- member table �� ����
DROP table member_detail;



-- ȸ��       member_detail������

-- ���̵�       id              varchar(16)
-- �����ȣ     zipcode         varchar2(5) ���ھտ� 0�� ������
-- �Ϲ��ּ�     address         varchar(100)
-- ���ּ�     address_detail  varchar(100)
-- ��ȭ��ȣ     tel1            varchar(3)
-- ��ȭ��ȣ2    tel2            varchar(4)
-- ��ȭ��ȣ3    tel3            varchar(4)

create table member_detail (
    id varchar2(16),
    zipcode varchar2(5),
    address varchar2(100),
    address_detail varchar2(100),
    tel1 varchar2(3),
    tel2 varchar2(4),
    tel3 varchar2(4),
    
    constraint member_detail_id_fk foreign key (id)
    references member (id) -- �ܷ�Ű ���� ���� �Ŵ� ���
);

create table emp_all --table �������� �������� ����
    as 
    SELECT * 
    FROM employees;
    
SELECT * 
FROM emp_all;

create table emp_blank --���̺� ������ �������� ���� ��� �̷� ������� ����
    AS
    SELECT *
    FROM employees
    WHERE 1=0;
SELECT *
FROM emp_blank;

create table emp_50 --Ư���� �÷��� ������ �÷� �̸��� �����ؼ� ���� �� �ִ�
    AS
    SELECT employee_id eid, first_name name, salary sal, d.department_name dname
    FROM employees e, departments d
    WHERE e.department_id = 50
    AND e.department_id = d.department_id;

SELECT *
FROM emp_50;

--DML
--INSERT
INSERT INTO member
VALUES ('�ǿ���','zave','1234',23,'zave7','naver.com', sysdate);

INSERT INTO member
VALUES ('zave1','�迵��','1234',149,'zave7','naver.com', sysdate);

INSERT INTO member (id, name, age, pass, emailid, emaildomain, joindate)
VALUES ('zave1','�迵��','123',149,'zave7','naver.com', sysdate);

INSERT INTO member (id, name, pass, joindate)
VALUES ('zave2','�迵��',149, sysdate);

SELECT *
FROM member;

INSERT INTO member_detail
VALUES ('zave', '12345', '��õ������ ����', '����������', 010, 7777, 1234);

INSERT INTO member_detail 
VALUES ('zave2', '12445', '����', 'ȫ����', '010', '1277', '1212');

INSERT INTO member_detail 
VALUES ('zave3', '12445', '����', 'ȫ����', '010', '1277', '1212');


INSERT INTO member (id, name, age, pass, emailid, emaildomain, joindate)
VALUES ('oracle', '����Ŭ', '30', 'a1234567', 'oracle', 'oracle.com', sysdate);

INSERT INTO member_detail (id, zipcode, addess, addredd_detail, tel1, tel2, tel3) 
VALUES ('oracle', '12345', '�λ� ������', '����Ŭ��', '010', '1111', '2222');

INSERT ALL --insert �ѹ��� ������
    INTO member (id, name, age, pass, emailid, emaildomain, joindate)
    VALUES ('oracle', '����Ŭ', '30', 'a1234567', 'oracle', 'oracle.com', sysdate)
    INTO member_detail (id, zipcode, address, address_detail, tel1, tel2, tel3) 
    VALUES ('oracle', '12345', '�λ� ������', '����Ŭ��', '010', '1111', '2222')
SELECT * --insert all �������� select �� ���;� �Ѵ�.
FROM dual;

SELECT *
FROM member m, member_detail md
WHERE m.id = md.id;


commit;


