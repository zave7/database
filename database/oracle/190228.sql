--�μ��̸��� 'IT'�� �ٹ��ϴ� ����� ���, �̸�, �޿�

SELECT  e.employee_id, e.first_name, e.salary
FROM    employees e, departments d
WHERE   e.department_id = d.department_id
AND     lower(d.department_name) = lower('IT');

--������ ������ �������� ī�׽þ� ���δ�Ʈ�� �ϰ� �̾ƿ��� ������
--�������� ���� ������ ��ȿ����

SELECT  employee_id, first_name, salary
FROM    employees
WHERE   lower(d.department_name) = lower('IT');
--
SELECT  department_id 
FROM    departments
WHERE   department_name = 'IT';
--
SELECT  employee_id, first_name, salary
FROM    employees
WHERE   department_id = 60;

--�������� ������
SELECT  employee_id, first_name, salary
FROM    employees
WHERE   department_id =     (SELECT department_id 
                            FROM departments
                            WHERE department_name = 'IT'
                            );

--'Seattle' �� �ٹ��ϴ� ����� ���, �̸�, �޿�
SELECT  employee_id, first_name, salary
FROM    employees
WHERE   department_id in    ((SELECT department_id
                            FROM departments
                            WHERE location_id =     (SELECT l.location_id
                                                    FROM locations l
                                                    WHERE l.city = 'Seattle')));
--
SELECT  location_id
FROM    locations
WHERE   city = 'Seattle';
--
SELECT  department_id
FROM    departments
WHERE   location_id =   (SELECT location_id
                        FROM locations
                        WHERE city = 'Seattle');
--
SELECT  employee_id, first_name, salary
FROM    employees
WHERE   department_id in    ((SELECT department_id
                            FROM departments
                            WHERE location_id =     (SELECT location_id
                                                    FROM locations
                                                    WHERE city = 'Seattle')));

-- join + subquery
SELECT  e.employee_id, 
        e.first_name, 
        e.salary, 
        d.department_name
        
FROM    employees e, 
        departments d
        
WHERE   e.department_id = d.department_id

AND     d.location_id =     (SELECT location_id
                            FROM locations
                            WHERE city = 'Seattle');

--������ȣ�� 1700�� �μ����� ���ϴ� �����
-- ���, �̸�, �μ���ȣ ,�μ��̸�
--160���� �����Ѵ�
SELECT  e.employee_id, 
        e.first_name, 
        e.department_id, 
        d.department_name
        
FROM    employees e, departments d
WHERE   e.department_id = d.department_id
AND     d.location_id = 1700;

--�ζ��� �� ��� ��Ī���� �Ҹ���.
SELECT e.employee_id, e.first_name, e.department_id, d.department_name
FROM employees e,   (SELECT department_id, department_name
                    FROM departments
                    WHERE location_id = 1700) d
                    
WHERE e.department_id = d.department_id;

SELECT department_id, department_name
FROM departments
WHERE location_id = 1700;

--'Kevin' ���� �޿��� ���� �޴� ����� ���, �̸�, �޿�
SELECT employee_id, first_name, salary
FROM employees
WHERE salary >  (SELECT salary
                FROM employees 
                WHERE first_name = 'Kevin');
-- 50�� �μ��� �ִ� ����� ���� �޿��� ���� �޴� ����� ���, �̸�, �޿�
SELECT employee_id, first_name, salary
FROM employees
WHERE salary > all (SELECT salary FROM employees WHERE department_id = 50);

-- �μ��� �ٹ��ϴ� ��� ������� ��� �޿����� ���� �޴� ����� ���, �̸�, �޿�
-- ��ȣ���ü�������
SELECT employee_id, first_name, salary
FROM employees
WHERE salary >  (SELECT avg(salary) 
                FROM employees 
                WHERE department_id is not null);
                
-- �� ����� ���� �μ��� �ٹ��ϴ� ������� ��� �޿����� ���� �޴� ����� ���, �̸�, �޿�
-- �μ��� ���� ����� ������� �ʴ´�
SELECT employee_id, first_name, salary
FROM employees;

SELECT round(avg(salary), 2) "asal", department_id
FROM employees
GROUP BY department_id;

SELECT e.employee_id, e.first_name, e.salary, d.asal, d.department_id
FROM employees e,   (SELECT avg(salary) asal, department_id
                    FROM employees
                    GROUP BY department_id) d
WHERE e.department_id = d.department_id
AND e.salary > d.asal
ORDER BY d.department_id;

--�μ���ȣ�� 20���� ��� �޿����� ũ��, 
--�Ŵ����� �ִ� ������� �μ� ��ȣ�� 20�� �ƴ� �����
--���, �̸�, �޿�, �μ���ȣ

SELECT employee_id, first_name, salary, department_id
FROM employees
WHERE salary >  (SELECT avg(salary)
                FROM employees
                WHERE department_id = 20)
AND manager_id is not null
AND department_id != 20;

--�μ���ȣ�� 20���� ��� �޿����� ũ��, 
--�Ŵ����� ������� �μ� ��ȣ�� 20�� �ƴ� �����
--���, �̸�, �޿�, �μ���ȣ
SELECT e.employee_id, e.first_name, e.salary, e.department_id
FROM employees e,    (SELECT employee_id
                    FROM employees e
                    WHERE salary >  (SELECT avg(salary)
                                    FROM employees
                                    WHERE department_id = 20)) d
WHERE d.employee_id = e.manager_id;
--
SELECT e20.employee_id, e20.first_name, e20.salary, e20.department_id
FROM    (SELECT distinct manager_id 
        FROM employees
        WHERE manager_id is not null) m, 
        (SELECT employee_id, 
                first_name, 
                salary, 
                department_id
        FROM employees
        WHERE salary >  (SELECT avg(salary)
                        FROM employees
                        WHERE department_id = 20)) e20
WHERE m.manager_id = e20.employee_id
AND department_id != 20;
--
SELECT e20.employee_id, e20.first_name, e20.salary, e20.department_id
FROM     
        (SELECT employee_id, 
                first_name, 
                salary, 
                department_id
        FROM employees
        WHERE salary >  (SELECT avg(salary)
                        FROM employees
                        WHERE department_id = 20)) e20
WHERE e20.employee_id = (SELECT distinct manager_id 
                        FROM employees
                        WHERE manager_id is not null)
AND department_id != 20;

--�μ���ȣ�� 20���� ��� �޿����� ũ��, 
--�μ��� ������� �μ� ��ȣ�� 20�� �ƴ� �����
--���, �̸�, �޿�, �μ���ȣ
SELECT  e.employee_id, 
        e.first_name, 
        e.salary, 
        e.department_id
FROM    employees e, departments d
WHERE   salary >    (SELECT avg(salary)
                    FROM employees
                    WHERE department_id = 20)
AND     e.employee_id = d.manager_id
AND     e.department_id != 20;

SELECT  *
FROM    departments;

--20�� �μ��� ��ձ޿�
--50�� �μ��� �޿�����
--80�� �μ��� �ο���

--scala ������������ ���� ��, ���� �÷��� �� �� �ִ�.
--��Į�� ���������� Select-List���� ���������� ���� �� �̸� ��Į�� ���������� Ī��.
--��Į�� ���������� Ư¡�� ������ ����.
--�ϳ��� ���ڵ常 ������ �����ϸ�, �ΰ� �̻��� ���ڵ�� ������ �� ����.
--��ġ�ϴ� �����Ͱ� ������ NULL���� ������ �� �ִ�.
--�̴� ���� �׷��Լ��� Ư¡�߿� �ϳ��ε� ��Į�� �������� ���� �� Ư¡�� ������ �ִ�.

--�׷��Լ��� Ư¡�� ����������
SELECT  (SELECT AVG(salary) FROM employees WHERE department_id = 20) "20�� �μ� ��� �޿�",
        (SELECT SUM(salary) FROM employees WHERE department_id = 50) "50�� �μ� �޿�����",
        (SELECT COUNT(*) FROM employees WHERE department_id = 80) "80�� �μ��� �ο���"
FROM    dual;

--��� ���, ���, �̸�, �޿� ���, �μ��̸�
--��, A�� 1���, B�� 2��� ... F�� 6���

SELECT  e.employee_id, 
        e.first_name, 
        e.salary, 
        decode(jg.grade_level, 'A','1���',
                            'B','2���',
                            'C','3���',
                            'D','4���',
                            'E','5���',
                            'F','6���') "�޿����",
        d.department_name
FROM    employees e, departments d, job_grades jg 
WHERE   e.department_id = d.department_id(+)
AND     e.salary between jg.lowest_sal and jg.highest_sal
ORDER BY e.salary desc;
--
SELECT  e.employee_id, d.department_name,
        e.first_name, 
        e.salary,
        case
            when (SELECT grade_level FROM job_grades WHERE e.salary between lowest_sal and highest_sal) = 'A'
            then '1���'
            when (SELECT grade_level FROM job_grades WHERE e.salary between lowest_sal and highest_sal) = 'B'
            then '2���'
            when (SELECT grade_level FROM job_grades WHERE e.salary between lowest_sal and highest_sal) = 'C'
            then '3���'
            when (SELECT grade_level FROM job_grades WHERE e.salary between lowest_sal and highest_sal) = 'D'
            then '4���'
            when (SELECT grade_level FROM job_grades WHERE e.salary between lowest_sal and highest_sal) = 'E'
            then '5���'
            when (SELECT grade_level FROM job_grades WHERE e.salary between lowest_sal and highest_sal) = 'F'
            then '6���'
            else '��޿� ����'
        end �޿����
FROM employees e, departments d
WHERE e.department_id = d.department_id;
--
SELECT  e.employee_id, d.department_name,
        e.first_name, 
        e.salary,
        decode((SELECT grade_level FROM job_grades WHERE e.salary between lowest_sal and highest_sal),
            'A','1���','B','2���','C','3���','D','4���','E','5���','F','6���')
FROM employees e, departments d
WHERE e.department_id = d.department_id;
SELECT *
FROM job_grades;
--ORDER BY ������ �������� ����
--GROUP BY ���� ����

--���, �̸�, ���(n�� m����), �޿����, �޿�����
SELECT  e.employee_id, e.first_name, concat(to_char(trunc(months_between(sysdate,e.hire_date)/12)), '����'),
        (SELECT count(employee_id) FROM employees WHERE e.salary > salary)
FROM employees e;
