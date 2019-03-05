--�������ϴ� �Լ�
--����� �޿�����
SELECT first_name, rank() over (ORDER BY salary) 
FROM employees;
--���ڹи�����
SELECT first_name, salary, dense_rank() over (ORDER BY salary DESC)
FROM employees;
--�׷����� ������ ���Ҷ�
--����� �μ��� �޿� ����
SELECT first_name, rank() over (partition BY department_id ORDER BY salary)
FROM employees;

--�ּ��Դϴ�
SELECT * FROM employees;
--���, �̸�, �μ��̸�, �޿�, �μ������� ��ձ޿�, �μ��� �޿� ����, ��ü�޿������� ������������

SELECT e.employee_id, e.first_name, e.salary, d.department_id
FROM employees e, departments d
WHERE e.department_id = d.department_id(+);

SELECT avg(salary), e.department_id
FROM employees e, departments d
WHERE e.department_id = d.department_id
GROUP BY e.department_id;

SELECT avg(salary)
FROM employees
WHERE department_id = e.department_id;

SELECT  e.employee_id, e.first_name, d.department_name, e.salary, ROUND((SELECT avg(salary)
                                                        FROM employees
                                                        WHERE department_id = e.department_id)) "�μ��� ��� �޿�",
        rank() over (partition by e.department_id order by salary DESC) "�μ��� �޿� ����"
FROM employees e, departments d
WHERE e.department_id = d.department_id
ORDER BY salary DESC;