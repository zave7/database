--DDL data definition language

-- char 고정길이 max 2000 byte
-- varchar2는 가변길이 max 4000 byte

-- ksc5601 - euc-kr 한글 2byte

-- utf 유니코드 전세계 모든문자 표현 한글 3byte
-- 오라클에서 long 타입은 검색속도 느리다고함
-- LOB large object , blob(binary) clob(charactor) max 4GB
-- db에는 가벼운 파일을 저장함
-- 일반적으로 타임스탬프보다 데이트를 많이 쓴다

-- 회원 member (필수)

-- 이름            name        varchar2(30)
-- 아이디          id          varchar2(16)
-- 비밀번호        pass        varchar(16)
-- 나이            age         number(3)
-- 이메일아이디    emailid     varchar(30)
-- 이메일도메인    emaildomain varchar(30)
-- 가입일          joindate    date

create table member (
    name varchar2(30) not null,
    id varchar2(16) ,
    pass varchar2(16) not null,
    age number(3) check (age < 150),
    emailid varchar2(30),
    emaildomain varchar2(30),
    joindate date default sysdate,
    
    constraint member_id_pk primary key (id) -- constraint 제약 조건 거는 방법
); --테이블에 제약조건이 많으면 별로 좋지않다

DROP table member; -- member table 을 제거
DROP table member_detail;



-- 회원       member_detail상세정보

-- 아이디       id              varchar(16)
-- 우편번호     zipcode         varchar2(5) 숫자앞에 0을 못붙임
-- 일반주소     address         varchar(100)
-- 상세주소     address_detail  varchar(100)
-- 전화번호     tel1            varchar(3)
-- 전화번호2    tel2            varchar(4)
-- 전화번호3    tel3            varchar(4)

create table member_detail (
    id varchar2(16),
    zipcode varchar2(5),
    address varchar2(100),
    address_detail varchar2(100),
    tel1 varchar2(3),
    tel2 varchar2(4),
    tel3 varchar2(4),
    
    constraint member_detail_id_fk foreign key (id)
    references member (id) -- 외래키 제약 조건 거는 방법
);

create table emp_all --table 구문에도 서브쿼리 가능
    as 
    SELECT * 
    FROM employees;
    
SELECT * 
FROM emp_all;

create table emp_blank --테이블 구조만 가져오고 싶을 경우 이런 방법으로 가능
    AS
    SELECT *
    FROM employees
    WHERE 1=0;
SELECT *
FROM emp_blank;

create table emp_50 --특정한 컬럼과 임의이 컬럼 이름을 지정해서 만들 수 있다
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
VALUES ('권영찬','zave','1234',23,'zave7','naver.com', sysdate);

INSERT INTO member
VALUES ('zave1','김영찬','1234',149,'zave7','naver.com', sysdate);

INSERT INTO member (id, name, age, pass, emailid, emaildomain, joindate)
VALUES ('zave1','김영찬','123',149,'zave7','naver.com', sysdate);

INSERT INTO member (id, name, pass, joindate)
VALUES ('zave2','김영찬',149, sysdate);

SELECT *
FROM member;

INSERT INTO member_detail
VALUES ('zave', '12345', '인천광역시 서구', '무지개빌라', 010, 7777, 1234);

INSERT INTO member_detail 
VALUES ('zave2', '12445', '서울', '홍은동', '010', '1277', '1212');

INSERT INTO member_detail 
VALUES ('zave3', '12445', '서울', '홍은동', '010', '1277', '1212');


INSERT INTO member (id, name, age, pass, emailid, emaildomain, joindate)
VALUES ('oracle', '오라클', '30', 'a1234567', 'oracle', 'oracle.com', sysdate);

INSERT INTO member_detail (id, zipcode, addess, addredd_detail, tel1, tel2, tel3) 
VALUES ('oracle', '12345', '부산 광역시', '오라클동', '010', '1111', '2222');

INSERT ALL --insert 한번에 여러번
    INTO member (id, name, age, pass, emailid, emaildomain, joindate)
    VALUES ('oracle', '오라클', '30', 'a1234567', 'oracle', 'oracle.com', sysdate)
    INTO member_detail (id, zipcode, address, address_detail, tel1, tel2, tel3) 
    VALUES ('oracle', '12345', '부산 광역시', '오라클동', '010', '1111', '2222')
SELECT * --insert all 다음에는 select 가 나와야 한다.
FROM dual;

SELECT *
FROM member m, member_detail md
WHERE m.id = md.id;


commit;


