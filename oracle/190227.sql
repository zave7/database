-- ��� ����� ���, �̸�, �޿�, �޿����

SELECT employee_id, first_name, salary, 
    case 
        when salary between 1000 and 2999
        then 'A'
        when salary between 3000 and 5999
        then 'B'
        when salary between 6000 and 9999
        then 'C'
        when salary between 10000 and 14999
        then 'D'
        when salary between 15000 and 24999
        then 'E'
        when salary between 25000 and 40000
        then 'F'
    end �޿����
FROM employees e
ORDER BY �޿����;
SELECT *
FROM job_grades;
-- non-equi join

SELECT e.employee_id, e.first_name, e.salary, jg.grade_level
FROM employees e, job_grades jg
WHERE salary >= jg.lowest_sal 
and salary <= jg.highest_sal;

SELECT *
FROM employees e, job_grades jg
WHERE salary between jg.lowest_sal and jg.highest_sal;

--outer join
--��� ����� ���, �̸�, �μ���ȣ, �μ��̸�
--��,�μ��� �������� ��� �μ��̸��� '���߷���'
SELECT e.employee_id, e.first_name, d.department_id, nvl(d.department_name, '���߷���')
FROM employees e, departments d
WHERE e.department_id = d.department_id(+);

SELECT *
FROM employees
WHERE department_id is null;

-- ��� ����� ���, �̸�, ������, ����̸�
-- ��, ����� ���� ��� ����̸��� '����'���� ���

SELECT e.employee_id, e.first_name, e.manager_id, nvl(m.first_name,'����')
FROM employees e, employees m
WHERE e.manager_id = m.employee_id(+);

-- ��� ����� ���, �̸�, ������, ����̸�, �μ��̸�
-- ��, ����� ���� ��� ����̸��� '����'���� ���
-- ��, �μ��� �������� ��� �μ��̸��� '���߷���'���� ���
SELECT  e.employee_id, 
        e.first_name, 
        e.manager_id, 
        nvl(m.first_name, '����'), 
        nvl(d.department_name, '���߷���')
FROM employees e, employees m, departments d
WHERE e.manager_id = m.employee_id(+)
and e.department_id = d.department_id(+);

--ANSI JOIN ǥ��

SELECT * 
FROM employees, departments;

SELECT * 
FROM employees CROSS JOIN departments;

--���, �̸�, �μ��̸�
SELECT e.employee_id, e.first_name, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;

--INNER JOIN

--INNER JOIN �̳� ������ INNER�� ���� �ȴ�(default)
--on�� �������Ǹ� ����ϴ� Ű����
--������ WHERE ����
SELECT e.employee_id, e.first_name, d.department_name
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id
WHERE e.department_id = 50;

SELECT e.employee_id, e.first_name, d.department_name
FROM employees e JOIN departments d
ON e.department_id = d.department_id
WHERE e.department_id = 50;

--USING�� �� ���� ���̺��� ���������� �� �÷����� �����ؾ��Ѵ�.
--WHERE ���� ��Ī�� �ٿ� �ĺ��� �ʿ䰡 ����
SELECT e.employee_id, e.first_name, d.department_name
FROM employees e JOIN departments d
USING (department_id)
WHERE department_id = 50;

--NUTURAL JOIN ��� ���� �÷��� �̿��� ������ �Ѵ�
--�׷��� ������ �����÷��� 1���ΰ�쿡�� ����ϴ°� ����
SELECT e.employee_id, e.first_name, d.department_name
FROM employees e NATURAL JOIN departments d
WHERE department_id = 50;

-- 'Seattle'�� �ٹ��ϴ� ���, �̸�, �μ��̸�, ����
SELECT e.employee_id, e.first_name, d.department_name, l.city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id
and d.location_id = l.location_id
and l.city = 'Seattle';

--���� ���̺��� 3�� �̻��� ���
SELECT e.employee_id, e.first_name, d.department_name, l.city
FROM employees e 
    JOIN departments d
        ON e.department_id = d.department_id
    JOIN locations l
        ON d.location_id = l.location_id
WHERE l.city = 'Seattle';

--outer join
--��� ����� ���, �̸�, �μ���ȣ, �μ��̸�

SELECT e.employee_id, e.first_name, d.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id(+);

SELECT e.employee_id, e.first_name, d.department_id, nvl(d.department_name, '���߷���')
FROM employees e LEFT OUTER JOIN departments d
ON e.department_id = d.department_id;

--��� �μ��� �ٹ��ϴ� ����� ���, �̸�(�������), �μ���ȣ, �μ��̸�
SELECT e.employee_id, nvl(e.first_name, '�������'), d.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id(+) = d.department_id;

SELECT e.employee_id, nvl(e.first_name, '�������'), d.department_id, d.department_name
FROM employees e RIGHT OUTER JOIN departments d
ON e.department_id = d.department_id;


--��� �μ��� ��� ����� �ٹ��ϴ� ����� ���, �̸�(�������), �μ���ȣ, �μ��̸�

SELECT  e.employee_id, 
        nvl(e.first_name, '�������'), 
        d.department_id, 
        nvl(d.department_name, '���߷���')
        
FROM employees e, departments d
WHERE e.department_id(+) = d.department_id
AND e.department_id = d.department_id(+); --�ȴ�

SELECT  e.employee_id, 
        nvl(e.first_name, '�������'), 
        d.department_id, 
        nvl(d.department_name, '���߷���')
        
FROM employees e FULL OUTER JOIN departments d

ON e.department_id = d.department_id;

--��� �μ��� ��� ����� �ٹ��ϴ� ����� ���, �̸�(�������), �μ���ȣ, �μ��̸�
SELECT  e.employee_id, 
        nvl(e.first_name, '�������'), 
        d.department_id, 
        nvl(d.department_name, '���߷���')
        
FROM employees e FULL OUTER JOIN departments d

ON e.department_id = d.department_id;

--�ǿ��� 0227
--���̺� �����ϴ� ��� ����� ����� ���(����� �ߺ��ؼ� ���͵� ��)
--����, ���
SELECT c.country_name, r.region_name
FROM countries c FULL OUTER JOIN regions r
ON c.region_id = r.region_id;
select *
from regions;

--�μ����� ���ϰ� �ִ� �����̸�  
--�μ��� �̸�, �μ��̸�, �����̸�(���� ��� '�μ������')
SELECT nvl(e.first_name, '�μ��� ����'), d.department_name, l.city
FROM departments d, employees e, locations l
WHERE d.manager_id = e.employee_id(+)
AND d.location_id = l.location_id;