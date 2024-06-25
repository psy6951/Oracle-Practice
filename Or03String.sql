/****************************
���ϸ� : Or03String.sql
���ڿ� ó���Լ�
���� : ���ڿ��� ���� ��ҹ��ڸ� ��ȯ�ϰų� ���ڿ��� ���̸� ��ȯ�ϴ� �� 
        ���ڿ��� �����ϴ� �Լ�
****************************/

/*
concat(���ڿ�1, ���ڿ�2)
: ���ڿ�1, 2�� ���� �����ؼ� ����ϴ� �Լ�. ���ڿ� �κ��� �÷����� ����� �� �ִ�.
���1 : concat(���ڿ�1, ���ڿ�2)
���2 : ���ڿ�1 | | ���ڿ�2
*/
select concat('Good ', 'morning') as "��ħ�λ�" from dual;
select 'Good ' | | 'morning' from dual;

--concat �����ڸ� ����ϸ� ���� ������ ��쿡�� ���� ���ϴ�
select 'Oracle ' || '21c ' || 'Good....!!'  from dual;
/* ==> �� SQL ���� concat() �Լ��� �����غ���*/
select concat (concat('Oracle ' , '21c '),  'Good....!!') from dual;


/*
�ó�����] ������̺��� ����� �̸��� �����ؼ� �Ʒ��� ���� ����Ͻÿ�.
    ��³���: first + last name, �޿�, �μ���ȣ
*/
--1�ܰ�
select first_name, last_name, salary, department_id from employees;
--2�ܰ�: �̸��� ���������� ���Ⱑ �ȵż� �������� ������
select concat(first_name, last_name), salary, department_id from employees;
--3�ܰ�: �̸� ���̿� �����̽� �ϳ��� �߰��Ѵ�.
select concat(first_name|| ' ', last_name), salary, department_id from employees;
--�̿� ���� �����ڿ� �Լ��� ��ø�ؼ� ����ϴ°� �����ϴ�.
--4�ܰ�: �÷����� �ʹ� ��� ��µǹǷ� ��Ī�� �ο��Ѵ�.
select concat(first_name || ' ', last_name) as full_name, salary, department_id from employees;

/*
initcap(���ڿ�) : ���ڿ��� ù���ڸ� �빮�ڷ� ��ȯ�ϴ� �Լ�
lower() : �ҹ��ڷ� ��������
upper() : �빮�ڷ� ��������
*/
select initcap('good') , lower('MORning'), upper('sIR') from dual;

/*
�ó�����] ������̺��� first_name�� john�� ����� ã�� ����Ͻÿ�
*/
--�̿� ���� �����ϸ� ����� ������� �ʴ´�. �����ʹ� ��ҹ��ڸ� �����Ѵ�.
select * from employees where first_name='john';
--�Էư��� ù���ڸ� �빮�ڷ� ������ �� �����Ѵ�.
select * from employees where first_name=initcap('john');
--�÷��� �Լ��� �����ϸ� ���ڵ� ��ü�� �ҹ��ڷ� �������ش�.
select * from employees where lower (first_name)='john';
--���ڵ�� �Է°� ��ü�� �빮�ڷ� �����Ѵ�.
select * from employees where upper (first_name)=upper('john');

/*
lpad(), rpad()
: ���ڿ��� ����, �������� Ư���� ��ȣ�� ä�ﶧ ����Ѵ�.
����] lpad('���ڿ�', '��ü�ڸ���', 'ä�﹮�ڿ�')
    => ��ü �ڸ������� ���ڿ��� ���̸�ŭ�� ������ ������ ��(��)��
     �κ��� �־��� ���ڷ� ä���ִ� �Լ�
*/
--��ü 7���� �� ���� Ȥ�� �������� #���� ä���.
--����° ���ڰ� ���� ��쿡�� ����(�����̽�)���� �� ������ ä���.
select 'good', lpad('good', 7, '#'), rpad('good', 7, '#'), lpad('good', 7) from dual;
/*
�ó�����] ����� �̸��� 10���ڷ� �����Ͽ� ������ �κ��� *�� ä��ÿ�.
*/
select rpad(first_name, 10 ,'*') from employees;


/*
trim() : ������ ������ �� ����Ѵ�.
����] trim([leading | trailing | both] ������ ���� from �÷�)
    -leading :  ����
    -trailing : ����
    -both : �������� ������(default��)
    [����1] ���� ���� ���ڸ� ���ŵǰ�, �߰��� ���ڴ� ���ŵ��� ����
    [����2] '����'�� ������ �� �ְ�, '���ڿ�'�� ������ �� ����. 
            ���ڿ��� �����ϴ� ��� ������ �߻��Ѵ�.
*/
select
    trim('��' from '�ٶ��㰡 ������ ž�ϴ�') /*������ '��' ����*/
    , trim(both '��' from '�ٶ��㰡 ������ ž�ϴ�') /*both�� ����Ʈ��*/
    , trim(leading '��' from '�ٶ��㰡 ������ ž�ϴ�') /*���� ���� ����*/
    , trim(trailing '��' from '�ٶ��㰡 ������ ž�ϴ�') /*���� ���� ����*/
    , trim(' �ٶ��㰡 ������ ž�ϴ� ') /*������ ���� ����*/

from dual;
--���ڿ��� ������ �� �����Ƿ� ������ �߻��Ѵ�.(�ѱ��ڸ� ���Ű���)
select trim('�ٶ���' from '�ٶ��㰡 ������ ž�ϴ�') from dual;
/*
ltrim(), rtrim()
: ����, ������ '����' Ȥ�� '���ڿ�'�� ������ �� ����Ѵ�.
*/
select
    /*������ ���鸸 ���ŵ�*/
    ltrim(' ������������ ')
    /*������ ������ ���ԵǾ��־� ���ڿ��� �������� �ʴ´�.*/
    , ltrim(' ������������ ', '����')
    /*�� ��� �Լ��� ��ø�� ���� ���ϴ� ����� ������ �� �ִ�.*/
    , ltrim(trim(' ������������ '), ' ����')
from dual;

/*
substr() : ���ڿ��� �����ε������� ���̸�ŭ �߶� ���ڿ��� ����Ѵ�.
    ����] substr(�÷�, �����ε���, ����)
    
    ����1) ����Ŭ�� �ε����� 1���� �����Ѵ�. (0���� �ƴ�)
    ����2) '����'�� �ش��ϴ� ���ڰ� ������ ���ڿ��� �������� �ǹ��Ѵ�.
    ����3) �����ε����� ������ ���������� �·� �ε����� �����Ѵ�.
*/

select substr('good morning john', 8, 4) from dual; --rning
select substr('good morning john', 8) from dual; --rning john (r���� ������ ����)
--���ڿ��� ���̸� ��ȯ�Ѵ�.
select length('good morning') from dual;

/*
�ó�����] ������̺��� first_name�� ù���ڸ� ������ ������ �κ��� *�� 
����ŷó���ϴ� �������� �ۼ��Ͻÿ�
*/
--�̸��� ù���ڸ� ����ϱ�(�ε��� 1���� 1���ڸ� �߶󳽴�)
select first_name, substr(first_name,1,1) from employees;
--�̸��� 10���ڷ� �����Ͽ� ������ �κ��� *�� ä������
select rpad(first_name, 10, '*') from employees;
/*�̸��� ù���ڸ� ��������, �̸��� ����(length)�� ���´�.
 �̸� ���� *�� ����ϸ� ù���ڸ� ������ ���� ���̸�ŭ�� ����ŷ ó���� �� �ִ�.*/
select
    first_name,
    rpad(substr(first_name,1,1), length(first_name), '*')
from employees;



/*
replace() : ���ڿ��� �ٸ� ���ڿ��� ��ü�Ҷ� ����Ѵ�. ���� �������� ���ڿ��� ��ü�Ѵٸ� 
���ڿ��� �����Ǵ� ����� �ȴ�.
����] replace(�÷��� or ���ڿ�, '������ ����� ����', '������ ����')

*trim(), ltrim(), rtrim()�� ����� replace() �ϳ��� 
��ü�� �� �����Ƿ� trim()�� ���� replace()�� �ξ� �� ���󵵰� ����.
*/
--���ڿ��� �����Ѵ�.
select replace('good morning john', 'morning', 'evening')
from dual;
--���ڿ��� �����Ѵ�.
select replace('good morning john', 'john', '')
from dual;
--trim()�� ���� ������ �����Ѵ�. �� ���ڿ� �߰��� ���鵵 ���ŵȴ�.
select replace('good morning john', ' ', '')
from dual;


/*
instr() : ���ڿ����� Ư�����ڰ� ��ġ�� �ε������� ��ȯ�Ѵ�.
    ����1] instr(�÷���, 'ã������')
        : ���ڿ��� ó������ ���ڸ� ã�´�.
    ����2] instr(�÷���, 'ã������', 'Ž���� ������ �ε���', '���°����')
        : Ž���� �ε������� ���ڸ� ã�´�. ��, ã�� ���� �� ����翡 �ִ� �������� ������ �� �ִ�.
        **Ž���� ������ �ε����� ������ ��� �������� �������� ã�� �ȴ�.
*/
--n�� �߰ߵ� ù��° �ε��� ��ȯ
select instr('good morning john', 'n') from dual;
--�ε��� 1���� Ž���� �����ؼ� n�� ������ �ι�° �ε��� ��ȯ
select instr('good morning john', 'n', 1, 2) from dual; 
--�ε��� 10���� �����ؼ� n�� ������ �ι�° �ε��� ��ȯ
select instr('good morning john', 'n', 10, 2) from dual; 






















