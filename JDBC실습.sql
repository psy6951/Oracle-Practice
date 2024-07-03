/*
JDBC ���α׷��� �ǽ��� ���� ��ũ��Ʈ
*/
--JAVA���� member ���̺� CRUD��� �����ϱ�
--member���̺� ����
CREATE TABLE member(
    /* id, pass, name�� ����Ÿ������ ����. null���� ������� �ʴ� �÷����� ������ . 
    �� �ݵ�� �Է°��� �־�� insert ������.*/
    id VARCHAR2(30) NOT NULL,
    pass VARCHAR2(40) NOT NULL,
    name VARCHAR2(50) NOT NULL,
    /* ��¥Ÿ������ ������. null�� ����ϴ� �÷����� ����. 
    ���� �Է°��� ���ٸ� ���簢�� ����Ʈ�� �Է��Ѵ� */
    regidate DATE DEFAULT SYSDATE,
    /*���̵� �⺻Ű�� ������*/
    PRIMARY KEY (id)
);

--member���̺� ���ڵ�(���� ������) �Է�
insert into member (id, pass, name) values ('tjoeun01', '1234', '������IT');
insert into member (id, pass, name) values ('test5', '1234', '�׽���5');

/*
    �Է� �� commit�� �������� ������ ����Ŭ �ܺ����α׷�(JAVA, JSP)������ 
    ���Ӱ� �Է��� ���ڵ带 Ȯ�� �� �� ����.
    �Էµ� ���ڵ带 �����ϱ� ���� �ݵ�� commit�� �����ؾ� �Ѵ�.
    
    Java�� ���� �ܺο��� �ԷµǴ� �����ʹ� �ڵ����� Ŀ�ԵǹǷ� ������ ó���� �ʿ����� �ʴ�.
*/
select * from member;
commit;

--like�� �̿��� ������ �˻� ��� �����ϱ�
select * from member where name like '%����%';
select * from member where regidate like '___07_01';



/*
JSP���� JDBC �����ϱ� �ǽ�
*/
--���� system �������� ������ �� ���ο� ������ �����մϴ�.
--c## ���ξ� ���� ������ �����ϱ� ���� ���� ����
alter session set "_ORACLE_SCRIPT"=true;
--���ο� ����� ���� ����
create user musthave identified by 1234;
--2���� Role(����)�� ���̺� �����̽����� ���� �ο�
grant connect, resource to,  unlimited tablespace to  musthave;



/*
CMDȯ�濡�� sqlplus�� ���� ������ ��쿡�� �ٸ� �������� ��ȯ�� 
�Ʒ��� ���� conn(Ȥ�� connect)��ɾ ����� �� �ִ�.
�𺧷��ۿ����� ���� ����â�� ����Ѵ�.
*/
conn musthave/1234;
show user;

--musthave ������ �����Ǹ� ����â�� ����� �� �����մϴ�.
--������ �Ϸ�Ǹ� member, board ���̺� ���� �� �������� ������ �����մϴ�.



--���̺� ��� ��ȸ
select*from tab;
/* ���̺� �� ������ ������ ���� ���� ������ ��ü�� �ִٸ� ������ �� ���Ӱ� �����Ѵ�.*/
drop table member;
drop table board;
drop sequence seq_board_num;

--ȸ�����̺� ����
create table member (
        id varchar2(10) not null,
        pass varchar2(10) not null,
        name varchar2(30) not null,
        regidate date default sysdate not null,
        primary key(id) /*id�÷��� �⺻Ű��*/
);

--��1����� �Խ��� ���̺� ����
create table board (
        num number primary key, /*�Ϸù�ȣ*/
        title varchar2(200) not null, /*����*/
       content varchar2(2000) not null, /*����*/
        id varchar2(10) not null, /*ȸ���� �Խ����̹Ƿ� ȸ�����̵� �ʿ�*/
        postdate date default sysdate not null, /*�Խù��� �ۼ���*/
        visitcount number(6) /*�Խù��� ��ȸ��*/   
);

--�ܷ�Ű ����
/*
�ڽ����̺��� board�� �θ����̺��� member�� �����ϴ� �ܷ�Ű�� �����Ѵ�.
board�� id �÷��� member�� �⺻Ű�� id�÷��� �����ϵ��� ���������� ����.
*/
alter table board
    add constraint board_mem_fk foreign key(id)
    references member(id); --�������Ǹ���� �����ؼ� �ܷ�Ű ������.
    
--������ ����
--board���̺� �ߺ����� �ʴ� �Ϸù�ȣ�� �ο��Ѵ�.
create sequence seq_board_num
    /*����ġ, ���۰�, �ּҰ��� ��� 1�� ����*/
    increment by 1
    start with 1
    minvalue 1
    /*�ִ밪, ����Ŭ, ĳ�ø޸� ����� ��� no�� ����*/
    nomaxvalue
    nocycle
    nocache;
    
--���� ������ �Է�
/*
�θ����̺��� member�� ���� ���ڵ带 ������ �� �ڽ����̺��� board�� �����ؾ� �Ѵ�.
���� �ڽ����̺� ���� �Է��ϸ� �θ�Ű�� ���ٴ� ������ �߻��Ѵ�.
2���� ���̺��� ���� �ܷ�Ű(��������)�� �����Ǿ� �����Ƿ� �������Ἲ�� �����ϱ� ���� 
������� ���ڵ带 �����ؾ� �Ѵ�.
*/
insert into member(id, pass, name) values('musthave', '1234', '�ӽ�Ʈ�غ�');
insert into board (num, title, content, id, postdate, visitcount)
    values (seq_board_num.nextval, '����1�Դϴ�', '����1�Դϴ�', 'musthave', sysdate, 0);

--Ŀ���ؼ� ���� ���̺� ����
commit;





































