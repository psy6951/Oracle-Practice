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


/*
min() / max() : �ִ밪, �ּҰ��� ã�� �� ����ϴ� �Լ�
*/
--��ü ����� �޿��� ���� ���� ������ �����ΰ���?
/*
�Ʒ� �������� ������ �߻��Ѵ�. �׷��Լ��� �Ϲ��÷��� �ٷ� ����� �� ����.
�̿� ���� ��쿡�� �ڿ��� �н��� '��������'�� ����ؾ� �Ѵ�.
*/
select first_name, salary from employees where salary=min(salary);

--��ü ����� ���� ���� �޿��� ���ΰ���? �� �޿��� �ּҰ��� ���ΰ���?
--2100 �����
select min(salary) from employees; 
--���� 2100�� �޴� ������ ã���� ù��° ������ �ذ��� �� �ִ�.
select first_name, last_name, salary from employees where salary=2100;
--�� 2���� �������� ��ġ�� �Ʒ��� ���� ���������� �ȴ�.
select first_name, last_name, salary from employees where salary=(select min(salary) from employees);


/*
 group by �� : �������� ���ڵ带 �ϳ��� �׷����� �׷�ȭ�Ͽ� 
                     ������ ����� ��ȯ�ϴ� ������
                    **distinct�� �ܼ��� �ߺ����� ������
*/
--������̺��� �� �μ��� �޿��� �հ�� ���ΰ���?
--60�� �μ��� �޿� �հ�
select sum(salary) from employees where department_id=60;
--100�� �μ��� �޿� �հ�
select sum(salary) from employees where department_id=100;
/*
1�ܰ� : �μ��� ���� ��� ������ �μ����� Ȯ���� �� �����Ƿ� �μ��� �׷�ȭ�Ѵ�.
        �ߺ��� ���ŵ� ����� �������� ������ ���ڵ尡 �ϳ��� �׷����� ������ 
        ����� ����ȴ�.
*/
select department_id from employees group by department_id;
/*
2�ܰ� : �� �μ����� �޿��� �հ踦 ���� �� �ִ�.
*/
select department_id, sum(salary) from employees group by department_id;
/*
�Ʒ� �������� �μ���ȣ�� �׷����� ��� ����� �����ϹǷ�, �̸��� ����ϸ� ������ �߻��Ѵ�. 
�� ���ڵ庰�� ���� �ٸ� �̸��� ����Ǿ� �����Ƿ� �׷��� ���ǿ� ���� �÷��� ����� �� ���� �����̴�.
*/
select department_id, sum(salary), first_name from employees group by department_id;-- first_name������ �����߻�

/*
����] ������̺��� �� �μ��� ������� ��ձ޿��� ������ ����ϴ� �������� �ۼ��Ͻÿ�.
        ��°��: �μ���ȣ, �޿�����, �������, ��ձ޿�
        ��½� �μ���ȣ�� �������� �������� �����Ͻÿ�.
*/
select 
    department_id, 
    trim(to_char(sum(salary),'999,000')) sum_salary, 
    count(*) cnt_clerk, 
    trim(to_char(avg(salary),'999,000')) avg_salary
from employees group by department_id order by department_id asc;


/*
having �� : ���������� �����ϴ� �÷��� �ƴ� �׷��Լ��� ���� 
                �������� ������ �÷��� ������ �߰��� �� ����Ѵ�.
                �ش� ������ where���� ����ϸ� ������ �߻��Ѵ�. 
*/
/*
�ó�����] ������̺��� �� �μ����� �ٹ��ϰ� �ִ� ������ 
            �������� ������� ��� �޿��� ������ ����ϴ� �������� �ۼ��Ͻÿ�.
            ��, ������� 10�� �ʰ��ϴ� ���ڵ常 �����Ͻÿ�
*/
/*���� �μ����� �ٹ��ϴ��� �������� �ٸ� �� �����Ƿ� 
    �� ���������� group by ���� 2���� �÷��� ����ؾ� �Ѵ�.
    �� �μ��� �׷�ȭ�� �� �ٽ� ��� �������� �׷�ȭ�Ѵ�.*/
select 
    department_id, job_id, count(*), avg(salary)
from employees 
where count(*)>10 --�� �κп��� �����߻�
group by department_id, job_id;
/*
�������� ������� ���������� �����ϴ� �÷��� �ƴϹǷ� where���� �߰��ϸ� �����߻���.
�� ��쿡�� having ���� ������ �߰��ؾ� �Ѵ�.
Ex) �޿��� 3000�� ��� =>���������� �����ϹǷ� where���� �߰�
    ��ձ޿��� 3000�� ��� =>�������� ��Ȳ�� �°� �������� ���� ����̹Ƿ� having ���� �߰�
*/
--�տ��� �߻��� ������ having���� ������ �ű�� �ذ�ȴ�.
select 
    department_id, job_id, count(*), avg(salary)
from employees 
group by department_id, job_id
having count(*)>10;



/*
�ó�����] �������� ����� �����޿��� ����Ͻÿ�.
            ��,(������(Manager))�� ���� ����� �����޿��� 3000 �̸��� �׷�)��
            ���ܽ�Ű��, ����� �޿��� ������������ �����Ͽ� ����Ͻÿ�.
*/
--�����ڰ� ���� ����� ���������� �����ϹǷ� where���� ���
--�����޿��� �׷��Լ��� ���� ������� ����̹Ƿ� having���� ���
--select ���� ����� ������ Į��(���� ��)�� order by���� ��밡��
select 
   job_id, min(salary)
from employees where manager_id is not null
group by  job_id
having not min(salary)<3000
order by min(salary) desc;


/* �׷��Լ�*/
/*
#�ش� ������ hr������ employees ���̺��� ����մϴ�.

1. ��ü ����� �޿��ְ��, ������, ��ձ޿��� ����Ͻÿ�. �÷��� ��Ī�� �Ʒ��� ���� �ϰ�, ��տ� ���ؼ��� �������·� �ݿø� �Ͻÿ�.
��Ī) �޿��ְ�� -> MaxPay
�޿������� -> MinPay
�޿���� -> AvgPay
*/
select
    to_char(max(salary),'999,000' as MaxPay,
    min(salary) MinPay,
    round(avg(salary)) AvgPay
from employees;




/*
2. �� ������ �������� �޿��ְ��, ������, �Ѿ� �� ��վ��� ����Ͻÿ�. �÷��� ��Ī�� �Ʒ��� �����ϰ� ��� ���ڴ� to_char�� �̿��Ͽ� ���ڸ����� �ĸ��� ��� �������·� ����Ͻÿ�.
��Ī) �޿��ְ�� -> MaxPay
�޿������� -> MinPay
�޿���� -> AvgPay
�޿��Ѿ� -> SumPay
����) employees ���̺��� job_id�÷��� �������� �Ѵ�.
*/
select
    job_id, ltrim(to_char(max(salary),'$99,000')) MaxPay,
    min(salary), sum(salary), avg(salary)
from employees group by job_id;

/*
3. count() �Լ��� �̿��Ͽ� �������� ������ ������� ����Ͻÿ�.
����) employees ���̺��� job_id�÷��� �������� �Ѵ�.
*/
select
    job_id, count(*) ClerkCnt
from employees group by job_id order by ClerkCnt desc;
/*���������� �����ϴ� �÷��� �ƴ϶�� �Լ� Ȥ�� ������ �״�� order by���� ����ϸ� �ȴ�. 
���� �ʹ� �� �����̶�� ��Ī�� ����ص� �ȴ�.*/


/*
4. �޿��� 10000�޷� �̻��� �������� �������� �հ��ο����� ����Ͻÿ�.
*/
select
     job_id, count(*)
from employees where salary>=10000
group by job_id;


/*
5. �޿��ְ�װ� �������� ������ ����Ͻÿ�. 
*/
select max(salary) - min(salary) from employees;
/*
6. �� �μ��� ���� �μ���ȣ, �����, �μ� ���� ��� ����� ��ձ޿��� ����Ͻÿ�. 
��ձ޿��� �Ҽ��� ��°�ڸ��� �ݿø��Ͻÿ�.
*/
select
     department_id, count(*), 
     ltrim(to_char(avg(salary),'$999,000.00'))
from employees group by department_id order by  ltrim(to_char(avg(salary),'$999,000.00'));

