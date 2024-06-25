/***********************
파일명: Or08GroupBy.sql
그룹함수(select문 2번째)
설명: 전체 레코드에서 통계적인 결과를 구하기 위해 
        하나 이상의 레코드를 그룹으로 묶어서 연산 후 
        결과를 반환하는 함수 혹은 쿼리문
***********************/
--사원테이블에서 담당업무 인출. 총 107개가 인출됨.
select job_id from employees;
/*
distinct : 동일한 값이 있는 경우 중복된 레코드를 제거한 후 하나의 레코드만 가져와서 보여줌.
            순수한 하나의 레코드이므로 통계적인 값을 계산할 수 없다.
*/
select distinct job_id from employees;
/*
group by : 동일한 갑이 있는 레코드를 하나의 그룹으로 묶어서 인출한다.
            보여지는 건 하나의 레코드지만 다수의 레코드가 하나의 그룹으로 묶여진 결과이므로 
            통계적인 값을 계산할 수 있다.
            최대, 최소, 평균, 합계 등의 연산이 가능하다.
*/
select job_id from employees group by  job_id;


--각 담당업무별 직원 수는 몇명일까요??
select job_id,count(*) from employees group by  job_id;
/* count() 함수를 통해 인출된 행의 개수는 아래와 같이 일반적인 select문으로 
검증할 수 있다. */
select * from employees where job_id='PU_CLERK';
select * from employees where job_id='SA_REP';


/*
group by절이 포함된 select문의 형식
    select
        컬럼1, 컬럼2,...혹은 전체(*)
    from
        테이블명
    where
        조건1 and 조건2 or 조건3(물리적으로 존재하는 컬럼)
    group by
        레코드의 그룹화를 위한 컬럼명
    having
        그룹에서의 조건(논리적으로 생성된 컬럼)
    order by
        정렬을 위한 컬럼명과 정렬방식
*/


/*
sum() : 합계를 구할때 사용하는 함수
-number 타입의 컬럼에서만 사용할 수 있다.
-필드명이 필요한 경우 as를 이용해서 별칭을 부여할 수 있다.
*/
--전체직원의 급여의 합계를 출력하시오.
select  
    sum(salary) sumSalary1,
    to_char(sum(salary), '999,000') sumSalary2,
    ltrim(to_char(sum(salary), '999,000')) sumSalary3
from employees;

--10번 부서에 근무하는 사원들의 급여 합계는 얼마인지 출력하시오.
select
    ltrim(to_char(sum(salary), '$999,000'))
from employees where department_id=10;

/*
count() : 선택된 레코드의 갯수를 카운트할때 사용하는 함수
*/
select count(*) from employees;
select count(employee_id) from employees;

/*
    count() 함수를 사용할 때는 위 2가지 방법 모두 가능하지만 *를 사용할 것을 권장한다. 
    컬럼의 특성 혹은 데이터에 따른 방해를 받지 않으므로 실행속도가 빠르다.
*/

/*
 count() 함수의 사용법
    1. count(all 컬럼명)
        => 디폴트 사용법으로 컬럼 전체의 레코드를 기준으로 카운트함
    2. count(distinct 컬럼명)
        => 중복을 제거한 상태에서 카운트한다.
*/
select 
    count(job_id) "담당업무전체개수1",
    count(all job_id) "담당업무전체개수2",
    count(distinct job_id)  "순수담당업무개수"
from employees;


/*
 avg(): 평균값을 구할때 사용하는 함수
*/
--전체사원의 평균급여는 얼마인지 출력하는 쿼리문을 작성하시오.
select
    count(*) "전체사원수",
    sum(salary) "급여합계",
    sum(salary) / count(*) "평균급여(직접계산)",
    trim(to_char(avg(salary),'999,000.00')) "avg함수사용"
from employees;

--영업팀(SALES)의 평균급여는 얼마인가요?
/*1. 부서테이블에서 영업팀의 부서번호가 몇번인지 확인한다.
    하지만 대소문자가 다르므로 결과가 인출되지 않는다.*/
select * from departments where department_name='SALES';
/*2. 컬럼 자체의 값을 대문자로 변환 후 쿼리의 조건으로 사용한다.
    80번 부서임을 확인한다.*/
select * from departments where upper(department_name)='SALES';
/*3. 80번 부서에서 근무하는 사원들의 평균급여를 구해 출력한다.*/
select 
    ltrim(to_char(avg(salary),'$990,000.0'))
from employees  where department_id=80;










