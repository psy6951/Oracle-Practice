/**********************************************
���ϸ�: Or09join.sql
���̺� ����(Join)
����: �ΰ� �̻��� ���̺��� ���ÿ� �����Ͽ� ���ڵ带 �����Ҷ� ����ϴ� SQL��
**********************************************/

--HR�������� �ǽ��մϴ�.

/*
1] inner join(��������)
-���� ���� ����ϴ� ���ι����� ���̺����� ���������� ��� �����ϴ� ���ڵ带 �˻��� �� ����Ѵ�.
-�Ϲ������� �⺻Ű(primary key)�� �ܷ�Ű(foreign key)�� ����Ͽ� join�ϴ� ��찡 ��κ��̴�.
-�ΰ��� ���̺��� ������ �̸��� �÷��� �����ϸ� "���̺���.�÷���" ���·� ����ؾ� �Ѵ�.
-���̺��� ��Ī�� ����ϸ� "��Ī.�÷���" ���·� ����� �� �ִ�.

����1(ǥ�ع��)
        select  �÷�1, �÷�2,......�÷�N
        from ���̺�1 inner join ���̺�2
            on ���̺�1.�⺻Ű�÷�=���̺�2.�ܷ�Ű(����Ű)�÷�    
        where ����1 and ����2 or ����3;
*/
/*
�ó�����] ������̺��� �μ����̺��� �����Ͽ� �� ������ � �μ����� �ٹ��ϴ��� ����Ͻÿ�.
                ��, ǥ�ع������ �ۼ��Ͻÿ�.
                ��°�� : ������̵�, �̸�1, �̸�2, �̸���, �μ���ȣ, �μ���
*/
select  
    employee_id, first_name, last_name, email, 
    department_id, department_name
from employees inner join departments
    on employees.department_id=departments.department_id;

/*ù��° �������� �����ϸ� ���� ���ǰ� �ָ��ϴٴ� ������ �߻��Ѵ�. 
�μ���ȣ�� ���ϴ� department_id�� ���� ���̺� ��ο� �����ϹǷ� 
� ���̺����� ������ �����ؾ� ���� �����ؾ� �Ѵ�.
*/
select
    employee_id, first_name, last_name, email, 
    employees.department_id, department_name
from employees inner join departments
    on employees.department_id=departments.department_id;
/*������������ �Ҽӵ� �μ��� ���� 1���� ������ ������ 106���� ���ڵ尡 ����ȴ�.
��, inner join�� ������ ���̺� ���� ��� �����ϴ� ���ڵ尡 �����Ѵ�.*/

--as(�˸��ƽ�)�� ���� ���̺��� ��Ī�� �ο��ϸ� �������� ����������.
select
    employee_id, first_name, last_name, email, 
    Emp.department_id, department_name
from employees Emp inner join departments Dep
    on Emp.department_id=Dep.department_id;

--3�� �̻��� ���̺� �����ϱ�
/*
�ó�����] seattle(�þ�Ʋ)�� ��ġ�� �μ����� �ٹ��ϴ� ������ ������
    ����ϴ� �������� �ۼ��Ͻÿ�. �� ǥ�ع������ �ۼ��Ͻÿ�. 
    ��°��] ����̸�, �̸���, �μ����̵�, �μ���, ���������̵�, 
        ��������, �ٹ�����
    �� ��°���� ���� ���̺��� �����Ѵ�. 
    ������̺� : ����̸�, �̸���, �μ����̵�, ���������̵�
    �μ����̺� : �μ����̵�(����), �μ���, �����Ϸù�ȣ(����)
    ���������̺� : ��������, ���������̵�(����)
    �������̺� : �ٹ��μ�, �����Ϸù�ȣ(����)
*/
--1. ���� ���̺��� ���� seattle�� ��ġ�� ���ڵ��� �Ϸù�ȣ�� ã�ƺ���.
select * from locations where city=initcap('seattle');
--���� �Ϸù�ȣ�� '1700'���� Ȯ��

--2. �����Ϸù�ȣ�� ���� �μ����̺��� ���ڵ带 Ȯ���Ѵ�.
select * from departments where location_id=1700;

--3. �μ��Ϸù�ȣ�� ���� ������̺��� ���ڵ带 Ȯ���Ѵ�.
select * from employees where department_id=10;--1��
select * from employees where department_id=30;--6��

--4. �������� Ȯ���ϱ�
select * from jobs where job_id='PU_MAN'; --Purchasing Manager
select * from jobs where job_id='PU_CLERK'; --Purchasing Clerk

/*
5. join ������ �ۼ�
���� ���̺��� ���ÿ� �����ϴ� �÷��� ��쿡�� 
�ݵ�� ���̺����̳� ��Ī�� �����ؾ� �Ѵ�.
*/

select
    first_name, last_name, email,
    departments.department_id, department_name, 
    city, state_province,
    jobs.job_id, job_title
from locations 
    inner join departments 
        on  locations.location_id=departments.location_id
    inner join employees 
        on employees.department_id=departments.department_id
    inner join jobs 
        on employees.job_id=jobs.job_id
where city=initcap('seattle');

--���̺��� ��Ī�� ����ϸ� �������� ���� �� �����ϰ� ���� �� �ִ�.
select
    first_name, last_name, email,
    D.department_id, department_name, 
    city, state_province,
    J.job_id, job_title
from locations L
    inner join departments D
        on  L.location_id=D.location_id
    inner join employees E
        on E.department_id=D.department_id
    inner join jobs J
        on E.job_id=J.job_id
where city=initcap('seattle');


/*
����2(Oracle ���) 
        select �÷�1, �÷�2,.....�÷�N
        from ���̺�1, ���̺�2
        where 
            ���̺�1.�⺻Ű=���̺�2.�ܷ�Ű 
                and ����1 or ����2 .... ����N;
ǥ�ع�Ŀ��� ����� inner join�� on�� �����ϰ� ������ ������ 
where���� ǥ���ϴ� ����̴�.
*/

/*
�ó�����] ������̺��� �μ����̺��� �����Ͽ� �� ������ � �μ����� �ٹ��ϴ��� ����Ͻÿ�.
��, ����Ŭ������� �ۼ��Ͻÿ�.
��°��: ������̵�, �̸�1, �̸�2, �̸���, �μ���ȣ, �μ���
*/
select
    employee_id, first_name, last_name, email, 
    DEP.department_id, department_name
from employees EMP, departments DEP
where EMP.department_id=DEP.department_id;

/*
�ó�����] seattle(�þ�Ʋ)�� ��ġ�� �μ����� �ٹ��ϴ� ������ ������
    ����ϴ� �������� �ۼ��Ͻÿ�. �� ����Ŭ������� �ۼ��Ͻÿ�. 
    ��°��] ����̸�, �̸���, �μ����̵�, �μ���, ���������̵�, 
        ��������, �ٹ�����
    �� ��°���� ���� ���̺��� �����Ѵ�. 
    ������̺� : ����̸�, �̸���, �μ����̵�, ���������̵�
    �μ����̺� : �μ����̵�(����), �μ���, �����Ϸù�ȣ(����)
    ���������̺� : ��������, ���������̵�(����)
    �������̺� : �ٹ��μ�, �����Ϸù�ȣ(����)
*/
select
    first_name, last_name, email, 
    D.department_id, department_name, J.job_id, job_title,
    city, state_province
from locations L, departments D, employees E, jobs J
where
    L.location_id=D.location_id and
    D.department_id=E.department_id and
    E.job_id=J.job_id and
    lower(city)='seattle';



/*
2] outer join(�ܺ�����)
outer join�� inner join�� �޸� �� ���̺��� ���������� ��Ȯ�� ��ġ���� �ʾƵ�
������ �Ǵ� ���̺����� ���ڵ带 �����ϴ� ����̴�.
outer join�� ����� ���� �ݵ�� ������ �Ǵ� ���̺��� �����ϰ� �������� �ۼ��ؾ� �Ѵ�.
-> left(�������̺�), right(���������̺�), full(�������̺�)

����1](ǥ�ع��)
        select �÷�1, �÷�2,......�÷�N
        from ���̺�1 
                left[right, full] outer join ���̺�2
                    on ���̺�1.�⺻Ű�÷�=���̺�2.�ܷ�Ű(����Ű)�÷�    
        where ����1 and ����2 or ����3;    
*/
/*
�ó�����] ��ü������ �����ȣ, �̸�, �μ����̵�, �μ���, ������ 
            �ܺ�����(left)�� ���� ����Ͻÿ�
*/
select
    employee_id, first_name, last_name, Em.department_id,
    department_name, city
from employees Em
    left outer join departments De 
        on Em.department_id=De.department_id
    left outer join locations Lo
        on De.location_id=Lo.location_id;
/*�������� ���� �������ΰ��� �ٸ��� 107���� ���ڵ尡 ����ȴ�.
�μ��� �������� ���� ������� ����Ǳ� �����ε�, �� ��� �μ��ʿ� 
���ڵ尡 �����Ƿ� null���� ��µȴ�.*/


/*
����2(Oracle ���)
        select �÷�1, �÷�2......�÷�N
        from ���̺�1, ���̺�2
        where 
            ���̺�1.�⺻Ű=���̺�2.�ܷ�Ű(+)
            and ����1 or ����2 ... ����n;
--����Ŭ������� ����ÿ��� outer join�������� (+)�� where�� �ٿ��ش�.
--���� ��� �������̺��� ������ �ȴ�.
--������ �Ǵ� ���̺��� ������ ���� ���̺��� ��ġ�� �Ű��ش�.(+)�� �ű��� �ʴ´�.
*/
/*
�ó�����] ��ü������ �����ȣ, �̸�, �μ����̵�, �μ���, ������ 
            �ܺ�����(left)�� ���� ����Ͻÿ�. �� ����Ŭ ����� ����Ͻÿ�.
*/
select
    employee_id, first_name, last_name, 
    Em.department_id, department_name, city

from employees Em,departments De, locations Lo
where 
    Em.department_id=De.department_id (+) and
    De.location_id=Lo.location_id (+);












