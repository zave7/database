--oo�� ����� oo�� �μ����� oo������ �����ϰ� �� ���ڴ� oo�� �Դϴ�. (��Ī "�������")
SELECT employee_id || '�� ����� ' || department_id || '�� �μ����� ' || job_id || '������ �����ϰ� �� ���ڴ� '
    || start_date || '�� �Դϴ�.' "�������"
    FROM job_history;

-- ����̸�(Ǯ����), �Ի���, �Ŵ�����ȣ (�Ŵ����� ���� ��� '-1' ���� ǥ��)
SELECT first_name || ' ' || last_name, hire_date, nvl(manager_id, -1)
FROM employees;
SELECT * 
FROM job_history;

--2�� ����
--1. employees���̺� ���� �� ���� ���ο�  ������ ��¥�� ���̰� �μ���ȣ�� null�� ����� ã�Ƽ� null�� 80���� �ٲ��
SELECT sysdate, nvl(department_id, 80)
FROM employees;
--2. ���� �������� ���ϴ� ��� 4���߿� ������ ���� ���� �޴»����?
SELECT first_name || ' ' || last_name
FROM employees e, departments d, locations l, countries c, regions r
WHERE e.department_id = d.department_id and
        d.location_id = l.location_id and
        l.country_id = c.country_id and
        country_name = 'United Kingdom';
    SELECT *
    FROM employees;
    SELECT * 
    FROM countries;
    SELECT *
    FROM locations;
    SELECT *
    FROM departments;
--3. jobs ���̺��� ���� �̸��� �ּ� �޿�, �ִ�޿�, ��ձ޿��� ����ϰ� ��ձ޿��� ��Ī�� ��� �޿��� �Ͻÿ�.
--(��ձ޿��� �ּұ޿��� �ִ�޿��� ��հ����� �Ѵ�.)

--4. locations ���̺��� ��ü�ּҸ� ����ϰ� ��Ī�� �ּ� �� �Ͻÿ� . (��ü�ּ� : street_address, city, country_ID )

--5.�μ���ȣ�� ()�� ����� Ŀ�̼����Ա޿��� ()�̴�. ��� ����Ͻÿ�

--6.(Ǯ������)�� ����ȣ�� ()�̰� �̸�����()�̴�. ��� ����Ͻÿ�

--7.'����'�� ���� �� �ִ� ���� �ݾ��� ' '���̸�, �ְ�ݾ��� ' '���Դϴ�. �׸��� �� �ݾ��� ���̴� ' '���Դϴ�. 
--(�̷��� �� ��µǰ� ����, ���̺��� �̸��� as�� �̿��ؼ� ��̴��ӴϷ� ������ ��)

--8.

--9.President"�� �ִ� �޿��� 40000�Դϴ�. (���� ���� ���·� ����ϸ�, ��Ī�� ���� �Ѵ�.)

--10.���, �Ի���, Ŀ�̼��� ���Ե� �޿��� ����϶�. (��Ī�� ���� ���, �Ի���, �޿�_Ŀ�̼� ���� ���� �Ѵ�.)