/***********************
���ϸ�: Or08GroupBy.sql
�׷��Լ�(select�� 2��°)
����: ��ü ���ڵ忡�� ������� ����� ���ϱ� ���� 
        �ϳ� �̻��� ���ڵ带 �׷����� ��� ���� �� 
        ����� ��ȯ�ϴ� �Լ� Ȥ�� ������
***********************/
--������̺��� ������ ����. �� 107���� �����.
select job_id from employees;
/*
distinct : ������ ���� �ִ� ��� �ߺ��� ���ڵ带 ������ �� �ϳ��� ���ڵ常 �����ͼ� ������.
            ������ �ϳ��� ���ڵ��̹Ƿ� ������� ���� ����� �� ����.
*/
select distinct job_id from employees;
/*
group by : ������ ���� �ִ� ���ڵ带 �ϳ��� �׷����� ��� �����Ѵ�.
            �������� �� �ϳ��� ���ڵ����� �ټ��� ���ڵ尡 �ϳ��� �׷����� ������ ����̹Ƿ� 
            ������� ���� ����� �� �ִ�.
            �ִ�, �ּ�, ���, �հ� ���� ������ �����ϴ�.
*/
select job_id from employees group by  job_id;


--�� �������� ���� ���� ����ϱ��??
select job_id,count(*) from employees group by  job_id;
/* count() �Լ��� ���� ����� ���� ������ �Ʒ��� ���� �Ϲ����� select������ 
������ �� �ִ�. */
select * from employees where job_id='PU_CLERK';
select * from employees where job_id='SA_REP';


/*
group by���� ���Ե� select���� ����
    select
        �÷�1, �÷�2,...Ȥ�� ��ü(*)
    from
        ���̺��
    where
        ����1 and ����2 or ����3(���������� �����ϴ� �÷�)
    group by
        ���ڵ��� �׷�ȭ�� ���� �÷���
    having
        �׷쿡���� ����(�������� ������ �÷�)
    order by
        ������ ���� �÷���� ���Ĺ��
*/


/*
sum() : �հ踦 ���Ҷ� ����ϴ� �Լ�
-number Ÿ���� �÷������� ����� �� �ִ�.
-�ʵ���� �ʿ��� ��� as�� �̿��ؼ� ��Ī�� �ο��� �� �ִ�.
*/
--��ü������ �޿��� �հ踦 ����Ͻÿ�.
select  
    sum(salary) sumSalary1,
    to_char(sum(salary), '999,000') sumSalary2,
    ltrim(to_char(sum(salary), '999,000')) sumSalary3
from employees;

--10�� �μ��� �ٹ��ϴ� ������� �޿� �հ�� ������ ����Ͻÿ�.
select
    ltrim(to_char(sum(salary), '$999,000'))
from employees where department_id=10;

/*
count() : ���õ� ���ڵ��� ������ ī��Ʈ�Ҷ� ����ϴ� �Լ�
*/
select count(*) from employees;
select count(employee_id) from employees;

/*
    count() �Լ��� ����� ���� �� 2���� ��� ��� ���������� *�� ����� ���� �����Ѵ�. 
    �÷��� Ư�� Ȥ�� �����Ϳ� ���� ���ظ� ���� �����Ƿ� ����ӵ��� ������.
*/

/*
 count() �Լ��� ����
    1. count(all �÷���)
        => ����Ʈ �������� �÷� ��ü�� ���ڵ带 �������� ī��Ʈ��
    2. count(distinct �÷���)
        => �ߺ��� ������ ���¿��� ī��Ʈ�Ѵ�.
*/
select 
    count(job_id) "��������ü����1",
    count(all job_id) "��������ü����2",
    count(distinct job_id)  "��������������"
from employees;


/*
 avg(): ��հ��� ���Ҷ� ����ϴ� �Լ�
*/
--��ü����� ��ձ޿��� ������ ����ϴ� �������� �ۼ��Ͻÿ�.
select
    count(*) "��ü�����",
    sum(salary) "�޿��հ�",
    sum(salary) / count(*) "��ձ޿�(�������)",
    trim(to_char(avg(salary),'999,000.00')) "avg�Լ����"
from employees;

--������(SALES)�� ��ձ޿��� ���ΰ���?
/*1. �μ����̺��� �������� �μ���ȣ�� ������� Ȯ���Ѵ�.
    ������ ��ҹ��ڰ� �ٸ��Ƿ� ����� ������� �ʴ´�.*/
select * from departments where department_name='SALES';
/*2. �÷� ��ü�� ���� �빮�ڷ� ��ȯ �� ������ �������� ����Ѵ�.
    80�� �μ����� Ȯ���Ѵ�.*/
select * from departments where upper(department_name)='SALES';
/*3. 80�� �μ����� �ٹ��ϴ� ������� ��ձ޿��� ���� ����Ѵ�.*/
select 
    ltrim(to_char(avg(salary),'$990,000.0'))
from employees  where department_id=80;










