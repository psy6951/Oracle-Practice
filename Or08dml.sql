/**********************************************
���ϸ�: Or08dml.sql
DML : Data Manipulation Language(������ ���۾�)
����: ���ڵ带 ������ �� ����ϴ� ������. �տ��� �н��ߴ� select���� ����Ͽ� 
        update(���ڵ� ����), delete(���ڵ� ����), insert(���ڵ� �Է�)�� �ִ�.
**********************************************/

--study�������� �ǽ��մϴ�.

--���ο� ���̺� �����ϱ�
create table tb_sample(
    no number(10),
    name varchar2(20),
    loc varchar2(15),
    manager varchar2(30)
);

desc tb_sample;
select * from tb_sample;


/*
���ڵ� �Է��ϱ� : insert
                ���ڵ� �Է��� ���� ���������� �������� �ݵ�� '�� ���ξ� �ϰ� �������� '���� ����Ѵ�. 
                ���� �������� '�� ���δ� ��쿡�� �ڵ����� ��ȯ�Ǿ� �Էµȴ�.
*/
--���ڵ� �Է�1 : �÷��� ������ �� insert �Ѵ�.
insert into tb_sample (no, name, loc, manager) values (10, '��ȹ��', '����', '����');
insert into tb_sample (no, name, loc, manager) values (20, '������', '����', '����');
select * from tb_sample;

--���ڵ� �Է�2 : �÷� ���� ���� ��ü �÷��� ������� insert �Ѵ�.
insert into tb_sample values (30, '������', '�뱸', '���');
insert into tb_sample values (40, '�λ��', '�λ�', '���ڷ�');
select * from tb_sample;

/*
�÷��� �����ؼ� insert �ϴ� ��� �����͸� �������� ���� �÷��� ������ �� �ִ�.
�Ʒ��� ��� name �÷��� null���� �Էµȴ�.
*/
insert into tb_sample (no, loc, manager) values (50, '����', '����');
select * from tb_sample;

/*
���ݱ����� �۾�(Ʈ�����)�� �״�� �����ϰڴٴ� ������� 
Ŀ���� �������� ������ �ܺο����� ����� ���ڵ带 Ȯ�� �� �� ����.
���⼭ ���ϴ� �ܺζ� Java/JSP�� ���� Oracle �̿��� ���α׷��� ���Ѵ�.

**Ʈ������̶� �۱ݰ� ���� �ϳ��� �����۾��� ���Ѵ�.
*/
commit;
--Ŀ�� ���� ���ο� ���ڵ带 �����ϸ� �ӽ����̺� ����ȴ�.
insert into tb_sample (no, loc, manager) values (60, '�±�', '�տ���');
--select ������� Ȯ���Ҽ� ������ �������̺��� �ݿ����� ���� �����̴�.
select * from tb_sample;
--�ѹ� ������� ������ Ŀ�� ���·� �ǵ��� �� �ִ�.
rollback;
--������ Ŀ���۾� ���Ŀ� �Է��� '�տ���'�� ���ŵȴ�.
select * from tb_sample;


/*
���ڵ� �����ϱ�: update
����] update ���̺��
                    set �÷�1=��, �÷�2=�� ...
                    where ����;
**������ ���� ��� ��� ���ڵ尡 �Ѳ����� �������ϴ�.
**���̺�� �տ� from�� ���� �ʴ´�.
*/
--��ȣ�� 40�� ���ڵ��� ������ '�̱�'���� �����Ͻÿ�.
update tb_sample set loc='�̱�'  where no=40;
select * from tb_sample;

--������ ������ ���ڵ��� �Ŵ������� '��������'���� �����Ͻÿ�
update tb_sample set manager='��������'  where loc='����';
select * from tb_sample;

--��� ���ڵ带 ������� ������ '����'���� �����Ͻÿ�.
--��ü ���ڵ尡 ����� ��쿡�� where���� �����ϸ� �ȴ�
update tb_sample set loc='����';
select * from tb_sample;



/*
���ڵ� �����ϱ�: delete
����] delete from ���̺�� where ����1 and ����2;
**���ڵ带 �����ϹǷ� delete �ڿ� �÷��� ������� �ʴ´�.
*/
--��ȣ 10�� ���ڵ带 �����Ͻÿ�.
delete  from tb_sample where no=10;
select * from tb_sample;
--���ڵ� ��ü�� �����Ͻÿ�.
delete  from tb_sample ;
select * from tb_sample;
--������ Ŀ���ߴ� �������� �����ش�.
rollback;
select * from tb_sample;

/*
DDL�� : ���̺��� ���� �� �����ϴ� ������
        (Data Definition Language: ������ ���Ǿ�)
        ���̺� ���� : create table ���̺��
        ���̺� ����
            �÷��߰� : alter table ���̺�� add
            �÷����� : alter table ���̺�� modify 
            �÷����� : alter table ���̺�� drop column �÷���
        ���̺� ���� : drop table ���̺��
*/

/*
DML�� : ���ڵ带 �Է� �� �����ϴ� ������
        (Data Manipulation Language: ������ ���۾�)
        ���ڵ� �Է� : insert into ���̺�� (�÷�) values (��)
        ���ڵ� ���� : update ���̺�� set �÷�=�� where ����
        ���ڵ� ���� : delete from ���̺�� where ����
        ���ڵ� ��ȸ : select �÷� from ���̺�� where ����
*/







