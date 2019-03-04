-- �μ���ȣ�� 50�̰ų�, 90�� �����
-- �޿��� 10000�̻��� ���
-- ���, �̸�, �޿�, �μ���ȣ
-- db�� �����ߴ� ���� �۾��� ũ��
SELECT *
FROM employees;

-- union �ߺ� ����
SELECT employee_id, first_name, salary, department_id
FROM employees
WHERE department_id in (50, 90)
union 
SELECT employee_id, first_name, salary, department_id
FROM employees
WHERE salary > 10000;

-- union �ߺ� ���� x
SELECT employee_id, first_name, salary, department_id
FROM employees
WHERE department_id in (50, 90)
union all
SELECT employee_id, first_name, salary, department_id
FROM employees
WHERE salary > 10000;

-- INTERSECT �������� ����
SELECT employee_id, first_name, salary, department_id
FROM employees
WHERE department_id in (50, 90)
intersect
SELECT employee_id, first_name, salary, department_id
FROM employees
WHERE salary > 10000;

-- MINUS
SELECT employee_id, first_name, salary, department_id
FROM employees
WHERE department_id in (50, 90)
MINUS
SELECT employee_id, first_name, salary, department_id
FROM employees
WHERE salary > 10000;

-- �μ��� �޿�����, ��ձ޿�, �����, �ִ�޿�, �ּұ޿�
-- �׷����� �� �÷���, �׷��Լ��� ���� �ִ�
SELECT  nvl(d.department_name, '�μ�����') "�μ��̸�", 
        sum(e.salary) ����, 
        round(avg(e.salary), 2) ��ձ޿�, 
        count(e.employee_id) �����, 
        max(e.salary) �ִ�޿�, 
        min(e.salary) �ּұ޿�
FROM employees e, departments d
WHERE e.department_id = d.department_id (+)
GROUP BY nvl(d.department_name, '�μ�����');

-- �μ��� �޿�����, ��ձ޿�, �����, �ִ�޿�, �ּұ޿�
-- ��ձ޿��� 5000������ �μ�
SELECT  nvl(d.department_name, '�μ�����') "�μ��̸�", 
        sum(e.salary) ����, 
        round(avg(e.salary), 2) ��ձ޿�, 
        count(e.employee_id) �����, 
        max(e.salary) �ִ�޿�, 
        min(e.salary) �ּұ޿�
FROM employees e, departments d
WHERE e.department_id = d.department_id (+)
GROUP BY nvl(d.department_name, '�μ�����')
having round(avg(e.salary), 2) <= 5000;

-- �� �μ��� ��� �޿����� ���� �޴�
-- ���, �̸�, �޿�

SELECT employee_id, first_name, salary
FROM employees
WHERE salary >  all(SELECT avg(salary) 
                    FROM employees 
                    GROUP BY department_id);
                    
-- �ڽ��� �μ� ��� �޿����� ���� �޴�
-- ���, �̸�, �޿�
SELECT e.employee_id, e.first_name, e.salary
FROM employees e,   (SELECT department_id, avg(salary) asal 
                    FROM employees 
                    GROUP BY department_id) d
WHERE e.department_id = d.department_id
AND d.asal > e.salary;

-- �μ��� �ְ� �޿��� �޴� �����
-- �μ��̸�, ���, �̸�, �޿�

SELECT d.department_name, e.employee_id, e.first_name, e.salary
FROM employees e, departments d,    (SELECT department_id, max(salary) msal 
                                    FROM employees 
                                    GROUP BY department_id) ms
WHERE e.department_id = d.department_id
AND e.department_id = ms.department_id
AND e.salary = ms.msal;

-- �̰Ŷ� ���� �ٸ���
SELECT d.department_name, e.employee_id, e.first_name, e.salary
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.salary in (SELECT max(salary) msal 
                FROM employees 
                GROUP BY department_id);
-- �μ��� �ְ� �޿��� �޴� �����
-- �μ��̸�, ���, �̸�, �޿�

SELECT d.department_name, e.employee_id, e.first_name, e.salary
FROM employees e,   (SELECT department_id, max(salary) msal
                    FROM employees
                    GROUP BY department_id) m, departments d
WHERE e.department_id = m.department_id
AND e.department_id = d.department_id
AND e.salary = m.msal;

-- rownum ���ȣ!!
-- ũ�� �񱳴� �Ұ�
-- rownum �� SELECT ���� �� �;��ϴ°� �ƴϴ�
SELECT rownum, employee_id, salary
FROM employees
ORDER BY salary desc;

SELECT rownum, employee_id, salary
FROM employees
WHERE rownum < 12
ORDER BY salary desc;

SELECT rownum, employee_id, salary
FROM employees
WHERE rownum between 5 and 10;

--TOP N query
-- ����, ���, �̸�, �޿�, �Ի���, �μ��̸�, 
-- �޿��� ����, 
-- �� �������� 5�� ���
-- 2page ���
-- 1980���, 1990���, 2000���

SELECT  base2.*

FROM    (SELECT rownum rnum, base1.*

        FROM    (SELECT e.employee_id employee_id,
                        e.first_name first_name, 
                        e.salary salary, 
                        concat(trunc(to_char(e.hire_date, 'yyyy'),-1), '���') "�Ի���", 
                        d.department_name department_name
                FROM employees e, departments d 
                WHERE e.department_id = d.department_id(+)
                ORDER BY salary DESC) base1
                
        WHERE rownum <= (&a * 5)) base2
        
WHERE rnum >= (&a * 5) - 4; -- rnum >= (&a * 5) - 5 �̰� �� ����

--Ʃ��
SELECT  rnum, employee_id, first_name, salary, concat(trunc(to_char(hire_date, 'yyyy'),-1), '���') "�Ի���", department_name

FROM    (SELECT rownum rnum, base1.*

        FROM    (SELECT employee_id,
                        first_name, 
                        salary,  
                        hire_date,
                        department_id
                FROM employees
                ORDER BY salary DESC) base1
                
        WHERE rownum <= (&a * 5)) base2, departments d
        
WHERE rnum >= (&a * 5) - 4
AND base2.department_id = d.department_id(+)
ORDER BY rnum;

-- 1 1-5  2 6-10  3   11-15
--  1�������� 5�� �ѷ���
-- (&a * 5) - 4  -> ���� ���� ��ũ
-- &a * 5 -> ���� ū ��ũ

-- rank() over()
SELECT t.rnum, t.employee_id, t.first_name, t.salary, concat(trunc(to_char(t.hire_date, 'yyyy'), -1), '���')
FROM    (SELECT rank() over(ORDER BY salary DESC) rnum, employee_id, first_name, salary, hire_date
        FROM employees) t
WHERE t.rnum <= (&a * 5) and t.rnum > (&a * 5) - 5;
