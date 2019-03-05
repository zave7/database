--���� �Լ�
SELECT  1234.6438, 
        round(1234.6438), 
        round(1234.6438, 1), 
        round(1234.6438, -1), -- �ݿø�
        round(1234.6438, 3), 
        round(1234.6438,-3)
        
FROM    dual;
SELECT round(1616.1616)
FROM dual;
--���� ����
SELECT  1234.6438, 
        trunc(1234.6438), 
        trunc(1234.6438, 1), 
        trunc(1234.6438, -1), 
        trunc(1234.6438, 3), 
        trunc(1234.6438,-3)
        
FROM    dual;
SELECT TRUNC (1616.1616)
FROM dual;
--�Ҽ��� ���� �� ���� ���� ���� ��ȯ
SELECT  1234.5438, 
        floor(1234.5438)
        
FROM    dual;

--�Ҽ��� ���� �� ���� ū ���� ��ȯ
SELECT  CEIL(123.1234)
FROM    dual;

--������ ����
SELECT  1+3, 
        MOD(17,5) 
        
FROM    dual;
SELECT MOD((1+3)/2,2)
FROM dual;
--����
SELECT  abs(-1234)
FROM    dual;

--����
-- ����� ���, �̸�, �޿�, Ŀ�̼����Ա޿�
-- Ŀ�̼� ���� �޿��� 100�� �ڸ����� ǥ��(�ݿø�)
SELECT  employee_id, 
        first_name, 
        salary, 
        round(salary + (salary * nvl(commission_pct, 0)), -2)
        
FROM    employees;
SELECT nvl2(7, 1, 0)
FROM dual;

--���� �Լ�
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

--�����ͺ��̽��� �ε����� 1����, instr �굵 ���̾��ٰ���
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
-- '-' 2���� ��
SELECT  '010-34-568' pnum, 
        substr('010-34-568', 1, (instr('010-34-568', '-')-1)) pnum1, 
        substr('010-34-568', instr('010-34-568', '-') +1 , (instr('010-34-568', '-', (instr('010-34-568', '-')+1)) - instr('010-34-568', '-')-1)) pnum2,
        substr('010-34-568', (instr('010-34-568', '-', instr('010-34-568', '-')+1)+1)) pnum3
        
FROM    dual;

--�ַ� Ŀ�ǵ� ���ο��� �������� ���̱� ���� LPAD, RPAD�� �����trim ��

--��¥�Լ�
SELECT  sysdate +3, 
        sysdate -3, 
        to_char(sysdate + 3 / 24, 'yyyy-hh-mm hh24:mi:ss') --��¥�� ����� �� ������ + -
        
FROM    dual;




SELECT  sysdate,                                
        months_between(sysdate, sysdate + 70),  -- �������̸� ���� +day 
        next_day(sysdate, 3),                   -- ���� �������� ���� ���� ��¥�� ����(1,2,3,4,5,6,7)
        add_months(sysdate, 6),                 -- ������ �߰�
        last_day(sysdate)                       -- ���� ������ ��¥�� ����
        
FROM    dual;

-- yyyy 2019
-- yy 19
-- mm 02
-- mon 2�� 2jau
-- w �� ����
-- ww �� ����
-- d ����
-- dd ��
-- ddd �� �� ��
-- dy �� mon
-- day ������ monday
SELECT sysdate, to_char(sysdate, 'yyyy yy mm mon month w ww d dd ddd dy day')
FROM dual;
-- pm hh 
-- am hh
-- hh 
-- mi 
-- ss
SELECT sysdate, to_char(sysdate, 'am hh hh24 mi ss')
FROM dual;

-- ��¥ �ݿø�
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

-- �ڷ��� ��ȯ �Լ�
-- to_char, to_number, to_date
-- ����Ŭ�� ��Ģ������ �������ۿ� ���� �ʴ´�(�ڵ� ����ȯ ����) ||�� ������
SELECT 'a', 3, '3', 3 + 5, '3' + 5
FROM dual;

SELECT  1123456.789,
        to_char(1123456.789, 'L0,000,000,000.00'), -- ���� ������ 0���� ä��
        to_char(1123456.789, '$9,999,999,999.99')  -- ���� ������ �������� ä��
FROM dual;
 
SELECT '123,456,98', length(to_char(to_number('123,456.98', '000000.00'))) "t"
FROM dual;

SELECT  sysdate, to_char(sysdate, 'yy.mm.dd w ww dy day pm mon month ddd'),
        to_char(sysdate, 'hh:mi:ss'),
        to_char(sysdate, 'hh24:mi:ss')
FROM dual;

--20190225142154 >> ��¥ >> 3����
SELECT to_char(to_date(to_char(20190225142154, '00000000000000'), 'yyyymmddhh24miss') +3, 'yyyy-mm-dd hh24:mi:ss')
FROM dual;

SELECT to_char(to_date(to_char(20190225142154), 'yyyymmddhh24miss') + 3, 'yyyy--mm-dd hh24:mi:ss')
FROM dual;

--�Ϲ��Լ�
--�޿��� 4000�̸��� ����� ������
--  10000�̸� ��տ���
-- 10000�̻� ����
--  ���, �̸�, �޿�, �������
SELECT nvl2(commission_pct, 1, 2)
FROM employees;
SELECT employee_id, first_name, salary, 
    case 
        when salary < 4000
        then '������'
        when salary < 10000
        then '��տ���'
        else '����'
    end �������
FROM employees
ORDER BY salary desc;

SELECT employee_id, 
    case 
        when commission_pct is not null
        then 'Ŀ�̼� ����!!'
        else '  Ŀ�̼� ����'
    end Ŀ�̼ǿ���
FROM employees;
SELECT salary �޿�
FROM employees;

--�������
--1980�⵵ �Ի� �ӿ�
-- 90 ����
-- 2000 ���Ի��
--���,�̸�,�Ի���,�������

SELECT  employee_id ���, first_name �̸� , hire_date �Ի���, 

    case
        when to_number(to_char(hire_date, 'yyyy'), '0000') < 1990 
        then '�ӿ�'
        when to_number(to_char(hire_date, 'yyyy'), '0000') < 2000
        then '����'
        else '���Ի��'
    end �������
    
FROM employees;

SELECT ascii('0') || ' 48', ascii('A') || ' 65', ascii('a') || ' 97'
FROM dual;

SELECT case when 'abc'<'abd' then '�۴�'
end ��
FROM dual;

SELECT chr(48)
FROM dual;

--���� 
--���, �̸�, �ڵ�����ȣ, �Ի��Ȧ¦, �Ի�⵵�ϼ�
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

