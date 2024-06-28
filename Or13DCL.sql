/*
���ϸ�: Or13DCL.sql
DCL : Data Control Language
����� ����
����: ���ο� ����ڰ����� �����ϰ� �ý��۱����� �ο��ϴ� ����� �н�
*/

/*
[����ڰ��� ���� �� ���Ѽ���]
�ش�κ��� DBA������ �ִ� �ְ������(sys, system)���� ������ �� �����ؾ� �Ѵ�.
���ο� ����ڰ����� ������ �� ���� �� �������� �׽�Ʈ�� CMD(���������Ʈ)���� �����Ѵ�.
*/

/*
1] ����� ���� ���� �� ��ȣ ����
����]
    create user ���̵� identified by �н�����;
*/
/*Oracle 12c ���ĺ��ʹ� �Ϲݰ��� ������ ���ξ�� C##�� �߰��ؾ� ������ ���� ������.
���� �Ʒ��� ���� ������ �����ϴ� ����� ���� ���ξ� ���� ���� �����ؾ� �Ѵ�.*/
alter session set "_ORACLE_SCRIPT"=true;
--���ο� ����� ���� ����
create user test_user1 identified by 1234;
/*
    �������� ���� CMD���� sqlplus ������� ������ �õ��غ���
    create session  ������ ���� �����Ҽ� ���ٴ� �����߻�
*/

/*
2] ������ ����� ������ ���� Ȥ�� ���� �ο�
����]
        grant �ý��۱���1, ����2 Ȥ�� ����(Role)
            to ����ڰ���
            [with grant option];
*/
--���ӱ��Ѻο�
grant create session to test_user1;
/*create session ���� �ο� �� ���ӿ��� ����������, ���̺��� ������ �� ����.*/
--���̺� ���� ���� �ο�
grant create table to test_user1;
/*
    create table���� �ο� �� ���̺� ���� �� desc ������� ��Ű�� Ȯ�� ����
*/

/*
3] ��ȣ����
    alter user ����ھ��̵� identified by ���ο��ȣ;
*/
alter user  test_user1 identified by 4321;
/*
    exit Ȥ�� quit������� ���� ���� �� �ٽ� �����ϸ� ������ ��ȣ�δ� ������ �� ����.
    ������ ��ȣ�� �����ؾ� �Ѵ�.
*/


/*
4]Role(��, ����)�� ���� �������� ������ ���ÿ� �ο��ϱ�
: ���� ����ڰ� �پ��� ������ ȿ�������� ������ �� �ֵ��� ���õ� ���ѳ��� ������� ���� ���Ѵ�.
**�츮�� �ǽ��� ���� ���Ӱ� ������ ���Ŀ� connect, resource���� �ַ� �ο��Ѵ�.
*/
--�ι�° ���� ���� �� Role�� ���� ������ �ο��Ѵ�.
create user test_user2 identified by 1234;
/*�Ʒ� 2���� Role�� ����Ŭ���� �⺻������ �����ȴ�.*/
grant connect, resource to test_user2;


/*
4-1] Role �����ϱ� : ����ڰ� ���ϴ� ������ ���� ���ο� ���� �����Ѵ�.
*/
create role my_role;

/*
4-2] Role�� ���� �ο��ϱ�
*/
--���Ӱ� ������ Role�� 3���� ������ �ο��Ѵ�.
grant create session, create table, create view to my_role;
create user test_user3 identified by 1234;
--�츮�� ������ Role�� ���� ������ �ο��Ѵ�.
grant my_role to test_user3;

/*
    my_role�� ���� ������ �ο������Ƿ� ���� �� ���̺���� ���� ����
*/

drop role my_role;

/*
    test_user3�� my_role�� ���� ������ �ο��޾����Ƿ� 
    �ش�  Role�� �����ϸ� ��� ������ ȸ��(Revoke)�ȴ�.
    ��, Role ���� �Ŀ��� ���� �� ��Ÿ�۾��� �� �� ����.
*/

/*
5] ��������(ȸ��)
����] revoke ���� �� ���� from ����ھ��̵�;
*/
revoke create session from test_user1;
/*
    ���ӱ��� ȸ�� �� ������ �õ��� �� ��й�ȣ�� Ʋ���� '������' ������ �߻��ϰ�
    ��й�ȣ�� ��ġ�ϸ� create session ������ ���ٰ� ��µ�
*/


/*
6] ����� ���� ����
����] drop user ����ھ��̵� [cascade];
��cascade�� ����ϸ� ����ڰ����� ���õ� ��� �����ͺ��̽� ��Ű���� 
�����ͻ������� ���� �����ǰ� ��� ��Ű�� ��ü�� ���������� �����ȴ�. 
*/
--���� ������ ����� ������ Ȯ���� �� �ִ� �����ͻ���
select username from dba_users;
select * from dba_users where username=upper('test_user1');
--������ �����ϸ鼭 ��� �������� ��Ű������ ���� �����Ѵ�.
drop user test_user1 cascade;


































