/**
파일명: Or01SelectBasic.sql
처음으로 실행해보는 질의어(SQL문 혹은 Query문)
개발자들 사이에서는 '시퀄'이라고 표현하기도 한다.
설명:selcet, where, order by 등 가장 기본적이 DQL문 사용해보기
**/

/*
SQL Developer에서 주석 사용하기
    블럭단위주석: 자바와 동일하다.
    라인단위주석: -- 실행문장. 하이픈 2개를 연속으로 사용한다.
*/

--select문: 테이블에 저장된 레코드를 조회하는 SQL문으로 DQL문에 해당한다.
/*
형식]
    selsect 컬럼1, 컬럼2, ... 혹은*
    from 테이블명
    where 조건1 and 조건2 or 조건3
    
    order by 정렬할컬럼 asc(오름차순), desc(내림차순);
*/

--사원테이블에 저장된 모든 레코드를 대상으로 모든 컬럼을 조회한다.
select * from employees;
--쿼리문은 대소문자를 구분하지 않는다.
SELECT * FROM employees;


/*
컬럼명을 지정해서 조회하고 싶은 컬럼만 조회하기
=> 사원번호, 이름, 이메일, 부서번호만 조회하시오.
*/
select employee_id, first_name, last_name, email, department_id from employees;
--하나의 쿼리문이 끝날때 ;을 반드시 명시해야한다.

/*테이블의 구조와 컬럼별 자료형 및 크기를 출력해준다. 
 즉 테이블의 스키마(구조)를 알 수 있다.*/
desc employees;

/*
컬럼이 숫자형(number)인 경우 산술연산이 가능하다.
-> 100불 인상된 직원의 급여를 조회하시오. */
select employee_id, first_name, salary, salary+100 from employees;

--number(숫자) 타입의 컬럼끼리도 산술 연산을 할 수 있다.
select employee_id, first_name, salary, salary+commission_pct from employees;

/*
AS(알리아스): 테이블 혹은 컬럼에 별칭(별명)을 부여할 때 사용한다.
            내가 원하는 이름(영문, 한글)으로 변경한 후 출력할 수 있다.
            활용] 급여+성과급율 => SalComm과 같은 형태로 별칭을 부여한다.
*/
--별칭은 한글로 기술할 수 있다.
select employee_id, first_name, salary, salary+100 as "급여100불 증가" from employees;

--하지만 별칭은 영문으로 기술하는 것을 권장한다.
select first_name, salary, commission_pct, salary+(salary*commission_pct) as SalComm from employees;

--as는 생략가능
select employee_id "사원번호", first_name "이름", last_name "성" from employees where first_name='William';
/*
오라클은 기본적으로 대소문자를 구분하지 않는다. 
예약어의 경우 대소문자 구분 없이 사용할 수 있다.
*/
SELECT employee_id "사원번호", first_name "이름", last_name "성" FROM employees WHERE first_name='William';
/* 단, 레코드인 경우 대소문자를 구분한다. 따라서 아래 SQL문을 실행하면 아무 결과도 인출되지 않는다. */
select employee_id "사원번호", first_name "이름", last_name "성" from employees where first_name='william';

/*
where 절을 이용해서 조건에 맞는 레코드 인출하기
-> last_name이 Smith인 레코드를 인출하시오.
*/
select * from employees where last_name='Smith';

/*
where절에 2개 이상의 조건이 필요할 때 and 혹은 or를 사용할 수 있다.
-> last_name이 Smith이면서 급여가 8000인 사원을 인출하시오.
*/
--컬럼이 문자형이면 싱글쿼테이션을 감싼다. 숫자라면 생략이 기본.
select * from employees where last_name='Smith' and salary=8000;
--문자형은 싱글을 생략할 수 없다. 따라서 에러 발생함
select * from employees where last_name=Smith and salary=8000;
--숫자형인 경우 생략이 기본이지만, 쓰더라도 에러가 나진 않음
select * from employees where last_name='Smith' and salary='8000';

/*
비교연산자를 통한 쿼리문 작성
: 이상, 이하와 같은 조건에 >, <=와 같은 비교연산자 사용 가능함
날짜인 경우 이전,이후와 같은 조건도 가능함
*/
--급여가 5000 미만인 사원의 정보를 인출하시오.
select * from employees where salary<5000;
--입사일이 04년1월1일 이후인 사원의 정보를 인출하시오.
select * from employees where hire_date>='04/01/01';

/*
in 연산자
: or 연산자와 같이 하나의 컬럼에 여러개의 값으로 조건을 걸고 싶을 때 사용
=> 급여가 4200, 6400, 8000인 사원의 정보를 추출하시오.
*/
--방법1: or를 사용한다. 이때 컬럼명을 반복적으로 기술해야 하므로 불편하다
select * from employees where salary=4200 or salary=6400 or salary=8000;
--방법2: in을 사용하면 컬럼명은 한번만 기술하면 되므로 편리하다.
select * from employees where salary in (4200, 6400, 8000);

/* 
not 연산자
: 해당 조건이 아닌 레코드를 인출한다.
-> 부서번호가 50이 아닌 사원정보를 인출하는 SQL문을 작성하시오.
*/
select * from employees where department_id<>50;
select * from employees where not (department_id=50);
select * from employees where department_id!=50;

/*
between and 연산자
: 컬럼의 구간을 정해 검색할 때 사용한다.
=> 급여가 4000~8000 사이의 사원을 인출하시오.
*/
select * from employees where salary>=4000 and salary<=8000;
select * from employees where salary between 4000 and 8000;

/*
distinct 연산자
: 컬럼에서 중복되는 레코드를 제거할때 사용한다.
특정조건으로 select했을 때 하나의 컬럼에서 중복되는 값이 있는 경우 
중복값을 제거한 후 결과를 출력할 수 있다.
-> 담당업무 아이디를 중복을 제거한 후 인출하시오.
*/
select job_id from employees;
select distinct job_id from employees; 

/*
like 연산자
:  특정 키워드를 통한 문자열을 검색할 때 사용한다.
형식] 컬럼명 like '%검색어%'
        와일드카드 사용법
        % : 모든 문자 혹은 문자열을 대체
            Ex) D로 시작하는 단어:  D% => Da, Dae, Daewoo
                Z로 끝나는 단어: %Z => aZ, abxZ
                C가 포함되는 단어: %C% => aCb, abCde, Vitamin-C 
        _ : 언더바는 하나의 문자를 대체
            Ex) D로 시작하는 3글자의 단어:  D_ => Dab, Ddd, Dxy
                A가 중간에 들어가는 3글자의 단어: _A_ -> aAa, xAy
*/
--first_name이 'D'로 시작하는 직원을 인출하시오.
select * from employees where first_name like 'D%';
--first_name의 세번째 문자가 a인 직원을 인출하시오.
select * from employees where first_name like '__a%';
--last_name에서 y로 끝나는 직원을 추출하시오.
select * from employees where last_name like '%y';
--전화번호에 1344가 포함된 직원 전체를 인출하시오.
select * from employees where phone_number like '%1344%';


/*
레코드 정렬하기(Sorting)
    오름차순 정렬: order by 컬럼명 asc(혹은 생략가능)
    내림차순 정렬: order by 컬럼명 desc
    2개 이상의 컬럼으로 정렬해야 할 경우 콤마로 구분해서 정렬한다.
    단, 이때 먼저 입력한 컬럼으로 정렬된 상태에서 두번째 컬럼이 정렬된다.
*/
/*
시나리오] 사원정보 테이블에서 급여가 낮은 순서에서 높은 순서로 인출되도록 정렬하여 인출하시오.
            (출력할 컬럼: 이름, 급여, 이메일, 전화번호)
*/
select first_name, salary, email, phone_number from employees order by salary asc;
select first_name, salary, email, phone_number from employees order by salary; --오름차순 정렬인 경우 asc 생략가능

/*
시나리오] 부서번호를 내림차순으로 정렬한 후 해당부서에서 낮은 급여를 받는 직원이 먼저 출력되도록 SQL문을 작성하시오.
            (출력할 컬럼: 사원번호, 이름, 성, 급여, 부서번호)
*/
select employee_id, first_name, last_name, salary, department_id 
from employees 
order by department_id desc, salary asc;


/*
is null 과 is not null 연산자
: 값이 null이거나 null이 아닌 레코드 인출하기.
컬럼 중 null값을 허용하는 경우 입력하지 않으면 null값이 되는데
이를 대상으로 select해야 할 때 사용한다.
*/
--보너스율이 없는 사원을 조회하시오
select * from employees where commission_pct is null;
--영업사원이면서 급여가 8000 이상인 사원을 조회하시오.
select * from employees where salary>=8000 and commission_pct is not null;


/*
select의 기본
#Or01SelectBasic.sql 파일 아래에 연결해서 아래 문제를 풀어주세요.

#과제전용 > 02Oracle > 연습문제1(select기본) 폴더하위에 본인이름으로 업로드 합니다.

#해당 문제는 scott계정에 생성된 EMP 테이블을 이용합니다. hr계정의 employees테이블과 유사한 형태의 테이블입니다. 

1. 덧셈 연산자를 이용하여 모든 사원에 대해서 $300의 급여인상을 계산한후 이름, 급여, 인상된 급여를 출력하시오.

2. 사원의 이름, 급여, 연봉을 수입이 많은것부터 작은순으로 출력하시오. 연봉은 월급에 12를 곱한후 $100을 더해서 계산하시오.

3. 급여가  2000을 넘는 사원의 이름과 급여를 내림차순으로 정렬하여 출력하시오

4. 사원번호가  7782인 사원의 이름과 부서번호를 출력하시오.

5. 급여가 2000에서 3000사이에 포함되지 않는 사원의 이름과 급여를 출력하시오.

6. 입사일이 81년2월20일 부터 81년5월1일 사이인 사원의 이름, 담당업무, 입사일을 출력하시오.



7. 부서번호가 20 및 30에 속한 사원의 이름과 부서번호를 출력하되 이름을 기준(내림차순)으로 출력하시오

8. 사원의 급여가 2000에서 3000사이에 포함되고 부서번호가 20 또는 30인 사원의 이름, 급여와 부서번호를 출력하되 이름순(오름차순)으로 출력하시오

9. 1981년도에 입사한 사원의 이름과 입사일을 출력하시오. (like 연산자와 와일드카드 사용)

10. 관리자가 없는 사원의 이름과 담당업무를 출력하시오. 

11. 커미션을 받을수 있는 자격이 되는 사원의 이름, 급여, 커미션을 출력하되 급여 및 커미션을 기준으로 내림차순으로 정렬하여 출력하시오.

12. 이름의 세번째 문자가 R인 사원의 이름을 표시하시오.

13. 이름에 A와 E를 모두 포함하고 있는 사원의 이름을 표시하시오.

14. 담당업무가 사무원(CLERK) 또는 영업사원(SALESMAN)이면서 급여가 $1600, $950, $1300 이 아닌 사원의 이름, 담당업무, 급여를 출력하시오. 

15. 커미션이 $500 이상인 사원의 이름과 급여 및 커미션을 출력하시오. 


*/