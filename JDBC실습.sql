/*
JDBC ���α׷��� �ǽ��� ���� ��ũ��Ʈ
*/
--JAVA���� member ���̺� CRUD��� �����ϱ�
--member���̺� ����
CREATE TABLE member(
    /* id, pass, name�� ����Ÿ������ ����. null���� ������� ������ �÷����� ������ . 
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

