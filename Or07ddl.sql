/***********************
���ϸ�: Or07ddl.sql
DDL: Data Definition Language(������ ���Ǿ�)
����:  ���̺�, ��� ���� ��ü�� ���� �� �����ϴ� �������� ���Ѵ�.
***********************/

--system �������� ������ �� �Ʒ� ����� �����Ѵ�.
--���ο� ����� ������ ������ �� ���ӱ��� �� ���̺� ���������� �ο��Ѵ�.

alter session set "_ORACLE_SCRIPT"=true;
create user study identified by 1234;
grant connect, resource to study;

---------------------------------------------------------------------------------
--study ������ developer�� ����� �� �����Ѵ�.
--DDL ���๮�� study�������� �����մϴ�.

--������ ��� ������ �������� �����ϴ� ���̺�
select * from dual;
/*���� ������ ������ ������ ���̺��� ����� ������ �ý��� ���̺�� 
�̿� ���� ������ �������� ������ ���̺��� "�����ͻ���"�̶�� ǥ���Ѵ�.*/
select * from tab;

/*
���̺� ����
����] create table ���̺�� (
                �÷�1 �ڷ��� [not null],
                �÷�2 �ڷ��� [not null],
            	......
                primary key (�ʵ��) �� ��������(�ܷ�Ű, ����ũŰ ��)
);
*/
create table tb_member (
    idx number(10), --������(����)
    userid varchar2(30), --������
    passwd varchar2(50),
    username varchar2(30),
    mileage number(7,2) --������(�Ǽ�)
);

--������ ������ ������ ���̺��� ����� Ȯ���Ѵ�.
select * from tab;

desc tb_member;

/*
���� ������ ���̺� ���ο� �÷� �߰��ϱ�
    -> tb_member ���̺� email �÷��� �߰��Ͻÿ�.
����] alter table ���̺�� add �߰��� �÷��� �ڷ���(ũ��) ��������;
*/
alter table tb_member add email varchar2(100);
desc tb_member;

/*
���� ������ ���̺��� �÷� ����(����)�ϱ�
    -> tb_member ���̺��� email �÷��� ����� 200���� Ȯ���Ͻÿ�.
����] alter table ���̺�� modify �������÷��� �ڷ���(ũ��);
*/
alter table tb_member modify email varchar2(200);
alter table tb_member modify username varchar2(600);
desc tb_member;

/*
���� ������ ���̺��� �÷� �����ϱ�
-> tb_member ���̺��� mileage �÷��� �����Ͻÿ�.
����] alter table ���̺�� drop column �������÷���;
*/
alter table tb_member drop column mileage;
desc tb_member;

/*
����] ���̺� ���Ǽ��� �ۼ��� employees���̺��� �ش� study������ �״�� �����Ͻÿ�.
        �� ���������� ������� �ʽ��ϴ�.
*/
create table employees ( 
    EMPLOYEE_ID NUMBER(6),
    FIRST_NAME VARCHAR2(20),
    LAST_NAME VARCHAR2(20),
    EMAIL VARCHAR2(20),
    PHONE_NUMBER VARCHAR2(20),
    HIRE_DATE DATE,
    JOB_ID VARCHAR2(20),
    SALARY NUMBER(8,2),
    COMMISSION_PCT NUMBER(2,2),
    MANAGER_ID NUMBER(6),
    DEPARTMENT_ID NUMBER(4)
    );

select * from tab;
desc employees;

/*
���̺� �����ϱ�
    -> employees ���̺��� �� �̻� ������� �����Ƿ� �����Ͻÿ�.
����] drop table ������ ���̺��;
*/
drop table employees;
desc employees;
select * from tab;

--���̺��� ����(drop)�ϸ� ������(recyclebin)�� �ӽú����ȴ�.
show recyclebin;
--������ ����
purge recyclebin;
--�����뿡 ������ ���̺� �����ϱ�. ���⼭�� employees�� �����Ѵ�.
flashback table employees to before drop;

/*
tb_member ���̺� ���ο� ���ڵ带 �����Ѵ�.(DML���� �н�����)
������ ���̺����̽��� ������ ������ �� ���� �����̴�.
*/
insert into tb_member values(1,'tjoeun','1234','������','tj@naver.com');
/*
Oracle 11g������ ���ο� ������ ������ �� connect, resources�� ��(Role)�� 
�ο��ϸ� ���̺� ���� �� ���Ա��� ������, �� ���� ���������� ���̺����̽� ���� ������ �߻��Ѵ�.
���� �Ʒ��� ���� ���̺� �����̽��� ���� ���ѵ� �Բ� �ο��ؾ� �Ѵ�.
*/

--CMD�� ����ϰ� �ִٸ� conn ����� ���� �ٸ� �������� ����Ī�Ѵ�.
--conn system/123456;
--�𺧷��ۿ����� ���� ����� ���� �޺��ڽ��� ���� system���� ������ �� ����� �����Ѵ�.
grant unlimited tablespace to study;

--���ڵ� ������ ���� study�������� ��ȯ �� insert ������ �����Ѵ�.
insert into tb_member values(2,'hong','1234','ȫ����','hong@naver.com');
insert into tb_member values(3,'sung','1234','������','sung@naver.com');
--���Ե� ���ڵ带 Ȯ��
select * from  tb_member;
--true�� �����̹Ƿ� ��� ���ڵ带 ������� �����Ѵ�.
select * from  tb_member where 1=1; --true
--false�� �����̹Ƿ� ���ڵ带 �������� �ʴ´�.
select * from  tb_member where 1=0; --false


--���̺���1 : ��Ű��(����)�� �����ϱ�
create table tb_member_copy
as
select * from tb_member where 1=0;
--���̺��� ����Ǿ����� Ȯ��
desc tb_member_copy;
--���̺��� ������ ����Ǿ����Ƿ� ���ڵ�� ������� �ʴ´�.
select * from  tb_member_copy;


--���̺���2 : ��Ű��(����)�� ���ڵ���� ��� �����ϱ�
create table tb_member_clone
as
select * from tb_member where 1=1;
--���̺��� ����Ǿ����� Ȯ��
desc tb_member_clone;
--true�� �������� ���ڵ���� ���������Ƿ� ����ȴ�.
select * from  tb_member_clone;







