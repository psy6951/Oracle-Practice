/*
���ϸ�: Or12Sequence&Index.sql
������&�ε���
����: ���̺��� �⺻Ű �ʵ忡 �������� �Ϸù�ȣ�� �ο��ϴ� �������� 
        �˻��ӵ��� ����ų �� �ִ� �ε���
*/

-- study �������� �ǽ��մϴ�.

/*
������(Sequence)
-���̺��� �÷�(�ʵ�)�� �ߺ����� �ʴ� �������� �Ϸù�ȣ�� �ο��Ѵ�.
-�������� ���̺� ���� �� ������ ������ �Ѵ�. �� �������� ���̺�� 
    ���������� ����ǰ� �����ȴ�.

[������ ��������]
create sequence ��������
    [Increment by N] ->����ġ ����
    [Start with N] ->���۰� ����
    [Minvalue n | NoMinvalue] -> ������ �ּҰ� ���� : ����Ʈ1
    [Maxvalue n | NoMaxvalue] ->������ �ִ밪 ���� : ����Ʈ 1.00E +28
    [Cycle | NoCycle] ->�ִ�/�ּҰ��� ������ ��� ó������ �ٽ� 
                                �������� ���θ� ����(cycle�� �����ϸ� �ִ밪���� 
                                ���� �� �ٽ� ���۰����� ����۵�)
    [Cache | NoCache]; -> cache �޸𸮿� ����Ŭ������ ���������� �Ҵ��ϴ°� ���θ� ����
    
������ ������ ���ǻ���
1. Start with�� Minvalue���� �������� �����Ҽ� ����. 
    �� Start with���� Minvalue�� ���ų� Minvalue���� Ŀ���Ѵ�.
2. NoCycle�� �����ϰ� �������� ��� ���ö� 
    MaxValue�� �������� �ʰ��ϸ� ������ �߻��Ѵ�.
3. Primary key�� Cycle�ɼ��� ����� �����ϸ� �ȵȴ�.

*/

create table tb_goods (
    idx number(10) primary key,
    g_name varchar2(30)
);
insert into tb_goods values (1,'��Ϲ���Ĩ');
--idk�� PK�� ������ �÷��̹Ƿ� �ߺ����� �ԷµǸ� �����߻�
insert into tb_goods values (1,'���±�');

--������ ����
create sequence seq_serial_num
    increment by 1 /*����ġ: 1*/
    start with 100 /*�ʱⰪ(���۰�): 100*/
    minvalue 99 /*�ּҰ�: 99*/
    maxvalue 110 /*�ִ밪: 110*/
    cycle /*�ִ밪 ���޽� ��������� ����: yes*/
    nocache; /*ĳ�ø޸� ��뿩��: no*/
--�����ͻ������� ������ ������ ���� Ȯ��
select * from user_sequences;
/*������ ���� �� ���ʽ��� �ÿ��� currval�� ������ �� ���� �����߻���.
nextval�� ���� �����ؼ� �������� ���� �� ����ؾ� �Ѵ�.*/
select  seq_serial_num.currval from dual;
/*���� �Է��� �������� ��ȯ�Ѵ�. 
  ������ ������ ������ ����ġ��ŭ ������ ���� ��ȯ�ȴ�.*/
select  seq_serial_num.nextval from dual;

/*
�������� nextval�� ����ϸ� ��� ���ο� ���� ��ȯ�ϹǷ� �Ʒ��� ���� insert���� ����Ҽ� �ִ�. 
���� ���� ������ ������ �����ϴ��� �������� �Էµȴ�.
*/
insert into tb_goods values (seq_serial_num.nextval,'���±�');
/*
��, �������� cycle�ɼǿ� ���� �ִ밪�� �����ϸ� �ٽ� ó������ �������� �����ǹǷ� 
���Ἲ �������ǿ� ����Ǿ� �����߻���.
�� PK �÷��� ����� �������� cycle�ɼ��� ������� �ʾƾ� �Ѵ�.
*/
select * from tb_goods;
    increment by 1 
    minvalue 99 
    nomaxvalue /*�ִ밪 ���X. �� ǥ�������� �ִ������ ����� */
    nocycle /*cycle ������� ����*/
    nocache; /*cache �޸� ������� ����*/
/*
������ ���� : ���̺�� �����ϰ� alter����� ����Ѵ�.
                    ��, start with�� ������ �� ����.
*/
alter sequence seq_serial_num;
    
--������ ����
drop sequence seq_serial_num;
select * from user_sequences;

/*
�Ϲ����� ������ ������ �Ʒ��� ���� �ϸ� �ȴ�.
PK�� ������ �÷��� �Ϸù�ȣ�� �Է��ϴ� �뵵�� �ַ� ���ǹǷ� 
�ִ밪,����Ŭ, ĳ�ô� ������� �ʴ� ���� ������. 
*/
create sequence seq_serial_num;
    increment by 1 
    start with 1
    minvalue 1
    nomaxvalue 
    nocycle 
    nocache; 


/*
�ε���(Index)
-���� �˻��ӵ��� ����ų �� �ִ� ��ü
-�ε����� �����(create index)�� �ڵ���(primary key, unique)���� ������ �� �ִ�.
-�÷��� ���� �ε����� ������ ���̺� ��ü�� �˻��Ѵ�.
-�� �ε����� ������ ������ ����Ű�� ���� �� �����̴�.
-�ε����� �Ʒ��� ���� ��쿡 �����Ѵ�.
        1. where�����̳� join���ǿ� ���� ����ϴ� �÷�
        2. �������� ���� �����ϴ� �÷�
        3. ���� null���� �����ϴ� �÷�
*/
--�ε��� ����
create index tb_goods_name on tb_goods (g_name);
/*�����ͻ������� Ȯ��. ����� ���� PKȤ�� Unique�� ������ �÷��� 
   �ڵ����� �ε����� �����Ǿ� �ִ� ���� �� �� �ִ�.*/
select * from user_ind_columns;
--�ε��� ����
drop index  tb_goods_name;
  

































