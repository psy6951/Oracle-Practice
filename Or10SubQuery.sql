/*
#Or10SubQuery.sql 파일 아래에 연결해서 아래 문제를 풀어주세요.

#scott 계정에서 진행합니다.
*/

/*
01.사원번호가 7782인 사원과 담당 업무가 같은 사원을 표시(사원이름과 담당 업무)하시오.
*/
--7782사원 확인
select *from emp where empno=7782;

--담당업무가 manager인 사원 인출
select *from emp where job='MANAGER';
select *from emp where job=(select job from emp where empno=7782);


/*
02.사원번호가 7499인 사원보다 급여가 많은 사원을 표시(사원이름과 담당 업무)하시오.
*/
--7499 사원확인
select *from emp where empno=7499;
--1600보다 급여가 많은 직원
select *from emp where sal>1600;
select *from emp where sal>(select sal from emp where empno=7499);
)

/*
03.최소 급여를 받는 사원의 이름, 담당 업무 및 급여를 표시하시오(그룹함수 사용).
*/
--급여의 최소값 확인
select min(sal) from emp;
--급여 800을 받는 직원
select *from emp where sal=800;
select *from emp where sal=(select min(sal) from emp);


/*
04.평균 급여가 가장 적은 직급(job)과 평균 급여를 표시하시오.
*/
--직급별 평균급여 인출
select job, avg(sal) from emp group by job;
/* 앞에서 구한 평균급여 레코드에서 가장 작은 값을 찾기 위해 min()함수를 한번 더 사용한다.
이 경우 job컬럼은 제외해야 에러가 발생하지 않는다. */
select job, min(avg(sal)) from emp group by job;--에러발생(job컬럼이 애매함)
select min(avg(sal)) from emp group by job;--정상실행. 평균급여 중 최소값을 인출함.
/*평균급여는 물리적으로 존재하는 컬럼이 아니므로 where절에는 사용할 수 없고
having절에 사용해야 한다. 
즉 평균급여가 1016.xx인 직급을 출력하는 방식으로 서브쿼리를 작성해야 한다.*/
select job, avg(sal) 
from emp 
group by job
having avg(sal)=(select min(avg(sal)) from emp group by job);


/*
05.각부서의 최소 급여를 받는 사원의 이름, 급여, 부서번호를 표시하시오.
*/
--그룹을 통해 최소급여 확인
select min(sal) from emp group by deptno;
--앞에서 나온 결과를 일반쿼리문으로 작성
select ename, sal, deptno from emp where
    (deptno=20 and sal=800) or
    (deptno=30 and sal=950) or
    (deptno=10 and sal=1300) ;
--복수형 서브쿼리 연산자를 통해 쿼리문을 작성해야 한다.
select ename, sal, deptno from emp
where(deptno, sal) in (
    select deptno, min(sal) from emp group by deptno);

/*
06.담당 업무가 분석가(ANALYST)인 사원보다 급여가 적으면서 
    업무가 분석가(ANALYST)가 아닌 사원들을 표 시(사원번호, 이름, 담당업무, 급여)하시오.
*/
--담당업무를 통해 급여 확인: 3000
select * from emp where job='ANALYST';
--문제의 조건을 일반쿼리문으로 작성
select * from emp where sal<3000 and job<>'ANALYST';
--서브쿼리문으로 작성
select * from emp where sal<(select sal from emp where job='ANALYST') 
    and job<>'ANALYST';



/*
07.이름에 K가 포함된 사원과 같은 부서에서 일하는 사원의 
    사원번호와 이름을 표시하는 질의를 작성하시오
*/
--K가 포함된 사원은 10,30번 부서에서 근무함을 확인
select * from emp where ename like '%K%';
--10번 혹은 30번 부서에서 근무하는 사원을 출력
select * from emp where deptno in (10, 30);
/*
or 조건을 in으로 표현할 수 있다. 따라서 서브쿼리에서 복수행 연산자인 in을 사용한다.
2개 이상의결과를 or로 연결하여 출력하는 기능을 수행한다.
*/
select * from emp where deptno in (select deptno from emp where ename like '%K%');

/*
08.부서 위치가 DALLAS인 사원의 이름과 부서번호 및 담당 업무를 표시하시오.
*/
--부서번호가 20임을 확인
select * from dept where loc='DALLAS';
--20번 부서에서 근무하는 사원
select * from emp where deptno=20;
--서브쿼리로 작성
select * from emp where deptno=(select deptno from dept where loc='DALLAS');


/*
09.평균 급여 보다 많은 급여를 받고 
이름에 K가 포함된 사원과 같은 부서에서 근무하는 사원의 사원번호, 이름, 급여를 표시하시오.
*/
--평균급여 확인: 2077
select avg(sal) from emp;
--급여가 2077 이상이고 이름에 K가 포함된 사원의 부서 확인: 10, 30
select * from emp where sal>2077 and ename like '%K%';
--위 2개의 쿼리를 단순하게 작성하면..
select * from emp where deptno in (10, 30);
--서브쿼리로 작성
select empno, ename, sal from emp where deptno in (
    select deptno from emp 
    where sal>(select avg(sal) from emp)
        and ename like '%K%');





/*
10.담당 업무가 MANAGER인 사원이 소속된 부서와 동일한 부서의 사원을 표시하시오.
*/
--10, 20, 30번 부서임을 확인
select * from emp where job='MANAGER';

select *from emp where deptno in(select deptno from emp where job='MANAGER');




/*
11.BLAKE와 동일한 부서에 속한 사원의 이름과 입사일을 표시하는 질의를 작성하시오(단. BLAKE는 제외)
*/
--DEPTNO 30번임을 확인
select * from emp where ename='BLAKE';
select ename, hiredate from emp where ename<>'BLAKE' and deptno in(30);

select ename, hiredate from emp where ename<>'BLAKE' and deptno in(select deptno from emp where ename='BLAKE');


