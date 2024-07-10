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

--������ �ַ� ����ϴ� ���̵� �߰��Է��ϱ�
insert into member values ('sunny','1234','sun',sysdate);
select * from member;
--���ڵ� �Է� �� Ŀ���� �ؾ� �ܺ� ���α׷����� ��� ������. �ݵ�� Ŀ���ؼ� ���� ���̺� �����ؾ� ��.
commit;

/***********************************
��1 ����� ȸ���� �Խ��� �����ϱ�
***********************************/
insert into board (num, title, content, id, postdate, visitcount)
    values (seq_board_num.nextval, '������ ���Դϴ�', '���ǿ���', 'musthave', sysdate, 0);
insert into board (num, title, content, id, postdate, visitcount)
    values (seq_board_num.nextval, '������ �����Դϴ�', '�������', 'musthave', sysdate, 0);
insert into board (num, title, content, id, postdate, visitcount)
    values (seq_board_num.nextval, '������ �����Դϴ�', '������ȭ', 'musthave', sysdate, 0);
insert into board (num, title, content, id, postdate, visitcount)
    values (seq_board_num.nextval, '������ �ܿ��Դϴ�', '�ܿ￬��', 'musthave', sysdate, 0);

select * from board;

--DAO�� selectCount()�޼���: board���̺��� �Խù� ���� ī��Ʈ
select count(*) from board;
select count(*) from board where title like '%�ܿ�%';
select count(*) from board where title like '%������%';
--���ǿ� ���� 0 Ȥ�� �� �̻��� �������� ����� ����ȴ�.

--selectList() �޼���: �Խ��� ��Ͽ� ����� ���ڵ带 �����ؼ� ����
select * from board order by num desc;
select * from board where title like '%��%' order by num desc;
select * from board where content like '%����%' order by num desc;
select * from board where title like '%�ﱹ��%' order by num desc;
--���ǿ� ���� ����Ǵ� ���ڵ尡 �ƿ� ���� ���� �ִ�.

commit;


--selectView() �޼��� : �Խù��� ���� �󼼺���
/*  board���̺��� id�� ����Ǿ� �����Ƿ� �̸����� ����ϱ� ���� 
    member���̺�� join�� �ɾ �������� �����Ѵ�. */
select *
    from board B inner join member M
        on B.id=M.id
where num=4 ; /* 2�� ���̺��� ��� �÷��� �����ͼ� �����Ѵ�. */

/* ���뺸�⿡�� ����� ���븸 �������� �ǹǷ� �Ʒ��� ���� ��Ī�� �̿��ؼ� 
������ �÷��� �����Ѵ�.*/
select B.*, M.name
    from board B inner join member M
        on B.id=M.id
where num=5 ;

--Join�� ���� �����÷����� �����ϹǷ� using���� �����ϰ� ǥ���� �� �ִ�.
select *
    from board inner join member using(id)
where num=5 ;


--updateVisitCount() �޼��� : �Խù� ��ȸ�� visitcount �÷��� 1�� ������Ű�� �۾�
update board set visitcount = visitcount + 1 where num=2;
select * from board;

commit;

--updateEdit() �޼��� : �Խù� ������ ���� ������
update board 
    set title='�����׽�Ʈ', content='update������ �Խù��� �����غ��ϴ�.'
    where num=6 ;
select * from board;
commit;


/*
��1 �Խ����� ����¡ ��� �߰��� ���� ����������
*/
--1. board ���̺��� �Խù��� ������������ �����Ѵ�.
select * from board order by num desc;

--2. ������������ ���ĵ� ���¿��� rownum�� ���� �������� ��ȣ�� �ο��Ѵ�.
select tb.*, rownum from (
    select*from board order by num desc) tb;

--3. rownum�� ���� �� ���������� ����� �Խù��� ������ �����Ѵ�.
select*from 
    (select tb.*, rownum rNum from 
        (select*from board order by num desc) tb
)
/*where  rNum>=1 and rNum<=10;*/
where  rNum>=11 and rNum<=20;
/*where  rNum>=11 and rNum<=20;*/
/*where rNum between 21 and 30*/

--4. �˻�� �ִ� ��쿡�� where���� �������� �߰��ȴ�. 
  --  like���� ���� ������ �������� �߰��ϸ� �ȴ�.
  -- �˻����ǿ� �´� �Խù��� ������ �� rownum�� �ο��Ѵ�.

select*from 
    (select tb.*, rownum rNum from 
        (select*from board 
        where title like '%9��°%'
        order by num desc) tb
)
where  rNum>=1 and rNum<=10;




--��2 ����� ����÷���� �Խ��� ���̺� ����
create table mvcboard (
    idx number primary key, /*�Ϸù�ȣ*/
    name varchar2(50) not null, /*�ۼ��� �̸�*/
    title varchar2(200) not null, /*����*/
    content varchar2(2000) not null,/*����*/
    postdate date default sysdate not null,/*�ۼ���*/
    ofile varchar2(200),/*�������ϸ�*/
    sfile varchar2(30),/*������ ����� ���ϸ�*/
    downcount number(5) default 0 not null,/*���ϴٿ�ε� Ƚ��*/
    pass varchar2(50) not  null,/*�н�����*/
    visitcount number default 0 not null/*�Խù� ��ȸ��*/
);

--���� ������ �Է�
insert into mvcboard (idx, name, title, content, pass)
    values (seq_board_num.nextval, '������', '�ڷ�� ����1 �Դϴ�.','����','1234');
insert into mvcboard (idx, name, title, content, pass)
    values (seq_board_num.nextval, '�庸��', '�ڷ�� ����2 �Դϴ�.','����','1234');
insert into mvcboard (idx, name, title, content, pass)
    values (seq_board_num.nextval, '�̼���', '�ڷ�� ����3 �Դϴ�.','����','1234');
insert into mvcboard (idx, name, title, content, pass)
    values (seq_board_num.nextval, '������', '�ڷ�� ����4 �Դϴ�.','����','1234');
insert into mvcboard (idx, name, title, content, pass)
    values (seq_board_num.nextval, '������', '�ڷ�� ����5 �Դϴ�.','����','1234');


commit;
select * from mvcboard;































































