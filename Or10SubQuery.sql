/*
#Or10SubQuery.sql ���� �Ʒ��� �����ؼ� �Ʒ� ������ Ǯ���ּ���.

#scott �������� �����մϴ�.
*/

/*
01.�����ȣ�� 7782�� ����� ��� ������ ���� ����� ǥ��(����̸��� ��� ����)�Ͻÿ�.
*/
--7782��� Ȯ��
select *from emp where empno=7782;

--�������� manager�� ��� ����
select *from emp where job='MANAGER';
select *from emp where job=(select job from emp where empno=7782);


/*
02.�����ȣ�� 7499�� ������� �޿��� ���� ����� ǥ��(����̸��� ��� ����)�Ͻÿ�.
*/
--7499 ���Ȯ��
select *from emp where empno=7499;
--1600���� �޿��� ���� ����
select *from emp where sal>1600;
select *from emp where sal>(select sal from emp where empno=7499);
)

/*
03.�ּ� �޿��� �޴� ����� �̸�, ��� ���� �� �޿��� ǥ���Ͻÿ�(�׷��Լ� ���).
*/
--�޿��� �ּҰ� Ȯ��
select min(sal) from emp;
--�޿� 800�� �޴� ����
select *from emp where sal=800;
select *from emp where sal=(select min(sal) from emp);


/*
04.��� �޿��� ���� ���� ����(job)�� ��� �޿��� ǥ���Ͻÿ�.
*/
--���޺� ��ձ޿� ����
select job, avg(sal) from emp group by job;
/* �տ��� ���� ��ձ޿� ���ڵ忡�� ���� ���� ���� ã�� ���� min()�Լ��� �ѹ� �� ����Ѵ�.
�� ��� job�÷��� �����ؾ� ������ �߻����� �ʴ´�. */
select job, min(avg(sal)) from emp group by job;--�����߻�(job�÷��� �ָ���)
select min(avg(sal)) from emp group by job;--�������. ��ձ޿� �� �ּҰ��� ������.
/*��ձ޿��� ���������� �����ϴ� �÷��� �ƴϹǷ� where������ ����� �� ����
having���� ����ؾ� �Ѵ�. 
�� ��ձ޿��� 1016.xx�� ������ ����ϴ� ������� ���������� �ۼ��ؾ� �Ѵ�.*/
select job, avg(sal) 
from emp 
group by job
having avg(sal)=(select min(avg(sal)) from emp group by job);


/*
05.���μ��� �ּ� �޿��� �޴� ����� �̸�, �޿�, �μ���ȣ�� ǥ���Ͻÿ�.
*/
--�׷��� ���� �ּұ޿� Ȯ��
select min(sal) from emp group by deptno;
--�տ��� ���� ����� �Ϲ����������� �ۼ�
select ename, sal, deptno from emp where
    (deptno=20 and sal=800) or
    (deptno=30 and sal=950) or
    (deptno=10 and sal=1300) ;
--������ �������� �����ڸ� ���� �������� �ۼ��ؾ� �Ѵ�.
select ename, sal, deptno from emp
where(deptno, sal) in (
    select deptno, min(sal) from emp group by deptno);

/*
06.��� ������ �м���(ANALYST)�� ������� �޿��� �����鼭 
    ������ �м���(ANALYST)�� �ƴ� ������� ǥ ��(�����ȣ, �̸�, ������, �޿�)�Ͻÿ�.
*/
--�������� ���� �޿� Ȯ��: 3000
select * from emp where job='ANALYST';
--������ ������ �Ϲ����������� �ۼ�
select * from emp where sal<3000 and job<>'ANALYST';
--�������������� �ۼ�
select * from emp where sal<(select sal from emp where job='ANALYST') 
    and job<>'ANALYST';



/*
07.�̸��� K�� ���Ե� ����� ���� �μ����� ���ϴ� ����� 
    �����ȣ�� �̸��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�
*/
--K�� ���Ե� ����� 10,30�� �μ����� �ٹ����� Ȯ��
select * from emp where ename like '%K%';
--10�� Ȥ�� 30�� �μ����� �ٹ��ϴ� ����� ���
select * from emp where deptno in (10, 30);
/*
or ������ in���� ǥ���� �� �ִ�. ���� ������������ ������ �������� in�� ����Ѵ�.
2�� �̻��ǰ���� or�� �����Ͽ� ����ϴ� ����� �����Ѵ�.
*/
select * from emp where deptno in (select deptno from emp where ename like '%K%');

/*
08.�μ� ��ġ�� DALLAS�� ����� �̸��� �μ���ȣ �� ��� ������ ǥ���Ͻÿ�.
*/
--�μ���ȣ�� 20���� Ȯ��
select * from dept where loc='DALLAS';
--20�� �μ����� �ٹ��ϴ� ���
select * from emp where deptno=20;
--���������� �ۼ�
select * from emp where deptno=(select deptno from dept where loc='DALLAS');


/*
09.��� �޿� ���� ���� �޿��� �ް� 
�̸��� K�� ���Ե� ����� ���� �μ����� �ٹ��ϴ� ����� �����ȣ, �̸�, �޿��� ǥ���Ͻÿ�.
*/
--��ձ޿� Ȯ��: 2077
select avg(sal) from emp;
--�޿��� 2077 �̻��̰� �̸��� K�� ���Ե� ����� �μ� Ȯ��: 10, 30
select * from emp where sal>2077 and ename like '%K%';
--�� 2���� ������ �ܼ��ϰ� �ۼ��ϸ�..
select * from emp where deptno in (10, 30);
--���������� �ۼ�
select empno, ename, sal from emp where deptno in (
    select deptno from emp 
    where sal>(select avg(sal) from emp)
        and ename like '%K%');





/*
10.��� ������ MANAGER�� ����� �Ҽӵ� �μ��� ������ �μ��� ����� ǥ���Ͻÿ�.
*/
--10, 20, 30�� �μ����� Ȯ��
select * from emp where job='MANAGER';

select *from emp where deptno in(select deptno from emp where job='MANAGER');




/*
11.BLAKE�� ������ �μ��� ���� ����� �̸��� �Ի����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�(��. BLAKE�� ����)
*/
--DEPTNO 30������ Ȯ��
select * from emp where ename='BLAKE';
select ename, hiredate from emp where ename<>'BLAKE' and deptno in(30);

select ename, hiredate from emp where ename<>'BLAKE' and deptno in(select deptno from emp where ename='BLAKE');


