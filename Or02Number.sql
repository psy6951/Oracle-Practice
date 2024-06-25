/**
���ϸ�: Or02Number.sql
����(����) ���� �Լ�
    ���� : ���ڵ����͸� ó���ϱ� ���� ���ڰ��� �Լ��� �н�.
    ���̺� ������ number Ÿ������ ����� �÷��� ����� �����͸� ������� �Ѵ�.
**/
--���� ������ ������ ������ ���̺�, ���� ����� �����ش�.
select * from tab;
--�̿� ���� ���̺��� ���� ��쿡�� ���� ������ �߻��Ѵ�.
select * from tjoeun;
/*Dual ���̺�
: �ϳ��� ������ ����� ����ϱ� ���� �����Ǵ� ���̺�� ����Ŭ���� �ڵ����� �����Ǵ� ���� ���̺��̴�.
varchar2(1)�� ���ǵ� dummy��� �� �ϳ��� �÷����� �����Ǿ� �ִ�.
*/
select * from dual;



/*
abs() :  ���밪 ���ϱ�
*/
select abs(12000) from dual;
select abs(-9000) from dual;
select abs(salary) "�޿��� ���밪" from employees;

/*
trunc() : �Ҽ����� Ư���ڸ������� �߶� �� ����ϴ� �Լ�
    ����] trunc(�÷��� Ȥ�� ��, �Ҽ��� �����ڸ���)
        �ι�° ���ڰ� 
            ����϶�: �־��� ���ڸ�ŭ �Ҽ����� ǥ��
            ���� ��: �����θ� ǥ��. �� �Ҽ��� �Ʒ��κ��� ����
            �����϶�: �����θ� ���ڸ�ŭ �߶� �������� 0���� ä��
*/
select trunc(12345.12345, 2) from dual;  --12345.12
select trunc(12345.12345) from dual;     --12345
select trunc(12345.12345, -2) from dual; --12300

/*
�ó�����] ������̺��� ��������� �޿��� ���� Ŀ�̼��� ����Ͽ� ���� ����� ����ϴ� �������� �ۼ��Ͻÿ�.
Ex) �޿�: 1000, ���ʽ���: 0.1 
=> 1000 + (1000*0.1) = 1100
*/
--1. ��������� ã�� �����Ѵ�.(��������� job_id�� SA_xx�� �Ǿ� �ִ�.)
select * from employees where job_id like 'SA_%';
--��������� Ŀ�̼��� �ޱ� ������ ���� �ԷµǾ� �ִ�.
select * from employees where commission_pct is not null;
--2. Ŀ�̼��� ����Ͽ� �̸��� �Բ� ����Ѵ�.
select first_name, salary, commission_pct, salary+(salary*commission_pct) 
from employees where job_id like 'SA_%';
--3. Ŀ�̼��� �Ҽ��� 1�ڸ����������� �ݾ� ����ϱ�
select first_name, salary, trunc(salary*commission_pct, 1), salary+(salary*trunc(salary*commission_pct, 1)) 
from employees where job_id like 'SA_%';
--4. ������ ���Ե� �÷��� ��Ī�� �ο��Ѵ�.
select first_name, salary, trunc(salary*commission_pct, 1) as comm_pct, 
    salary+(salary*trunc(salary*commission_pct, 1)) TotalSalary 
from employees where job_id like 'SA_%';




