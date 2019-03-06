-- ���, �̸�, �μ���ȣ, ��������
-- �μ���ȣ 60�̸� ������, 
-- 90�̸� �ӿ���
-- ������ �񰳹���

SELECT  employee_id, first_name, department_id, 
    case
        when department_id = 60
        then '������'
        when department_id = 90
        then '�ӿ���'
        else '�񰳹���'
    end ��������
FROM    employees;

SELECT  employee_id, 
        first_name, 
        department_id,
        decode(department_id, 60, '������', 90, '�ӿ���', '�񰳹���') -- equal �񱳸� ����
FROM    employees;

--�׷��Լ�
--ȸ���� �ѻ����, �޿� ����, �޿� ���, �ְ�޿�, �����޿�
SELECT count(employee_id), sum(salary), avg(salary), max(salary), min(salary)
FROM employees;

--��ձ޿����� ���� �޴� ����� ���, �̸�, �޿�
SELECT employee_id, first_name, salary
FROM employees
WHERE salary > (SELECT avg(salary) FROM employees);

SELECT 
    case 
        when salary > avg(salary)
        then employee_id
    end ���,
    case 
        when salary > avg(salary)
        then first_name
    end �̸�,
    case 
        when salary > avg(salary)
        then salary
    end �޿�
FROM employees; --��� �ȵǳ�

--���, �̸�, �μ���ȣ, �μ��̸�
SELECT employee_id, first_name, department_id, department_name
FROM employees;

--JOIN
--n-1���� ���������� �ɾ���Ѵ� (n�� ������ ���̺��� ����)

SELECT * 
FROM employees, departments
WHERE employees.department_id = departments.department_id;
--���踦 �ΰ� �ִ� �÷����� join �ؾ��Ѵ�
--�⺻Ű�� ���ϼ��� not null Ư���� �������ִ�
--�ܷ�Ű

--���̺��� ��Ī�� �ټ� �ִ�
SELECT e.employee_id, e.first_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;

--'seattle'�� �ٹ��ϴ� ����� ���, �̸�, �μ��̸�, �����̸�

SELECT e.employee_id, e.first_name, d.department_name, l.city
FROM employees e, departments d, locations l
WHERE lower(l.city) = lower('seattle') 
and e.department_id = d.department_id
and d.location_id = l.location_id;

--'asia'�� �ٹ��ϴ� ��� �̸� �μ��̸� �����̸�
SELECT  e.employee_id, e.first_name, d.department_id, d.department_name, l.city

FROM    employees e, departments d, locations l, countries c, regions r

WHERE   lower(r.region_name) = lower('asia')
and     e.department_id = d.department_id 
and     d.location_id = l.location_id
and     l.country_id = c.country_id
and     c.region_id = r.region_id;

--catesian product
--cross join

--equi join(natural join)ansi

--10,80,90�� �μ��� �ٹ����� �����
--���, �̸�, ��å�̸�, �μ��̸�

SELECT e.employee_id, e.first_name, e.job_id, d.department_name
FROM employees e, departments d
WHERE e.department_id in(10, 80, 90)
and e.department_id = d.department_id;


--��å���̵� 'SA_REP'�� �����
--���, �̸�, ��å�̸�, �μ��̸�
--��, �μ��� ���� ��� '���߷�'���� ���

SELECT e.employee_id, first_name, e.job_id, nvl(d.department_name, '���߷�')
FROM employees e, departments d
WHERE lower(e.job_id) = lower('SA_REP')
and e.department_id = d.department_id(+);

--����� 200�� ����� �ٹ� �̷�, 

--���, �̸�, ��å�̸�, �μ��̸�, �ٹ������� �Ҽ���°
SELECT *
FROM job_history;
--������ �ذ��Ҷ� �� �����غ��� ����
SELECT  e.employee_id, e.first_name, j.job_title, d.department_name, 
        to_char(round(months_between(jh.end_date, jh.start_date), 2),'999.99')
FROM employees e, job_history jh, departments d, jobs j
WHERE jh.employee_id = 200
and e.employee_id = jh.employee_id
and jh.department_id = d.department_id
and jh.job_id = j.job_id;

SELECT to_date('2000/02/02') - to_date('2000/01/01')
FROM dual;

--��� ����� �μ��̸�, ���, �̸�, �Ŵ������, �Ŵ����̸�
SELECT d.department_name, e.first_name, e.manager_id, m.first_name
FROM employees e, departments d, employees m
WHERE e.department_id = d.department_id
and e.manager_id = m.employee_id;


SELECT e.first_name, m.first_name FROM employees e ,employees m
WHERE e.manager_id = m.employee_id;

SELECT * FROM employees;
-- 'canada'���� �ٹ��ϴ� ������� �Ŵ������� �޿������ ���Ͻÿ�
-- ���� -> �޿����
            145,000
SELECT avg(m.salary) "�޿����"
FROM countries c, locations l, departments d, employees e, employees m
WHERE lower(c.country_name) = lower('canada')
and c.country_id = l.country_id
and l.location_id = d.location_id
and d.department_id = e.department_id
and e.manager_id = m.employee_id;

-- first_name�� e�� ���� ������� �Ŵ����� �߿��� �޿��� 10000�̻��� ������� �޿� �հ踦 ���Ͻÿ�

SELECT sum(m.salary)
FROM employees e, employees m
WHERE e.first_name like '%e%'
and e.manager_id = m.employee_id
and m.salary >= 10000;