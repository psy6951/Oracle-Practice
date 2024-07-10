/*
JDBC 프로그래밍 실습을 위한 워크시트
*/
--JAVA에서 member 테이블에 CRUD기능 구현하기
--member테이블 생성
CREATE TABLE member(
    /* id, pass, name은 문자타입으로 선언. null값을 허용하지 않는 컬럼으로 정의함 . 
    즉 반드시 입력값이 있어야 insert 가능함.*/
    id VARCHAR2(30) NOT NULL,
    pass VARCHAR2(40) NOT NULL,
    name VARCHAR2(50) NOT NULL,
    /* 날짜타입으로 선언함. null을 허용하는 컬럼으로 정의. 
    만약 입력값이 없다면 현재각을 디폴트로 입력한다 */
    regidate DATE DEFAULT SYSDATE,
    /*아이디를 기본키로 지정함*/
    PRIMARY KEY (id)
);

--member테이블에 레코드(더미 데이터) 입력
insert into member (id, pass, name) values ('tjoeun01', '1234', '더조은IT');
insert into member (id, pass, name) values ('test5', '1234', '테스터5');

/*
    입력 후 commit을 실행하지 않으면 오라클 외부프로그램(JAVA, JSP)에서는 
    새롭게 입력한 레코드를 확인 할 수 없다.
    입력된 레코드를 적용하기 위해 반드시 commit을 실행해야 한다.
    
    Java를 통해 외부에서 입력되는 데이터는 자동으로 커밋되므로 별도의 처리는 필요하지 않다.
*/
select * from member;
commit;

--like를 이용한 데이터 검색 기능 구현하기
select * from member where name like '%조은%';
select * from member where regidate like '___07_01';



/*
JSP에서 JDBC 연동하기 실습
*/
--먼저 system 계정으로 접속한 후 새로운 계정을 생성합니다.
--c## 접두어 없이 계정을 생성하기 위한 세션 변경
alter session set "_ORACLE_SCRIPT"=true;
--새로운 사용자 계정 생성
create user musthave identified by 1234;
--2개의 Role(역할)과 테이블 스페이스까지 권한 부여
grant connect, resource to,  unlimited tablespace to  musthave;



/*
CMD환경에서 sqlplus를 통해 접속한 경우에는 다른 계정으로 전환시 
아래와 같이 conn(혹은 connect)명령어를 사용할 수 있다.
디벨로퍼에서는 좌측 접속창을 사용한다.
*/
conn musthave/1234;
show user;

--musthave 계정이 생성되면 접속창에 등록한 후 접속합니다.
--접속이 완료되면 member, board 테이블 생성 및 제약조건 설정을 진행합니다.



--테이블 목록 조회
select*from tab;
/* 테이블 및 시퀀스 생성을 위해 기존 생성된 객체가 있다면 삭제한 후 새롭게 생성한다.*/
drop table member;
drop table board;
drop sequence seq_board_num;

--회원테이블 생성
create table member (
        id varchar2(10) not null,
        pass varchar2(10) not null,
        name varchar2(30) not null,
        regidate date default sysdate not null,
        primary key(id) /*id컬럼을 기본키로*/
);

--모델1방식의 게시판 테이블 생성
create table board (
        num number primary key, /*일련번호*/
        title varchar2(200) not null, /*제목*/
       content varchar2(2000) not null, /*내용*/
        id varchar2(10) not null, /*회원제 게시판이므로 회원아이디 필요*/
        postdate date default sysdate not null, /*게시물의 작성일*/
        visitcount number(6) /*게시물의 조회수*/   
);

--외래키 설정
/*
자식테이블인 board가 부모테이블인 member를 참조하는 외래키를 설정한다.
board의 id 컬럼이 member의 기본키인 id컬럼을 참조하도록 제약조건을 설정.
*/
alter table board
    add constraint board_mem_fk foreign key(id)
    references member(id); --제약조건명까지 포함해서 외래키 생성함.
    
--시퀀스 생성
--board테이블에 중복되지 않는 일련번호를 부여한다.
create sequence seq_board_num
    /*증가치, 시작값, 최소값을 모두 1로 설정*/
    increment by 1
    start with 1
    minvalue 1
    /*최대값, 사이클, 캐시메모리 사용을 모두 no로 설정*/
    nomaxvalue
    nocycle
    nocache;
    
--더미 데이터 입력
/*
부모테이블인 member에 먼저 레코드를 삽입한 후 자식테이블인 board에 삽입해야 한다.
만약 자식테이블에 먼저 입력하면 부모키가 없다는 에러가 발생한다.
2개의 테이블은 서로 외래키(참조관계)가 설정되어 있으므로 참조무결성을 유지하기 위해 
순서대로 레코드를 삽입해야 한다.
*/
insert into member(id, pass, name) values('musthave', '1234', '머스트해브');
insert into board (num, title, content, id, postdate, visitcount)
    values (seq_board_num.nextval, '제목1입니다', '내용1입니다', 'musthave', sysdate, 0);

--커밋해서 실제 테이블에 적용
commit;

--본인이 주로 사용하는 아이디 추가입력하기
insert into member values ('sunny','1234','sun',sysdate);
select * from member;
--레코드 입력 후 커밋을 해야 외부 프로그램에서 사용 가능함. 반드시 커밋해서 실제 테이블에 적용해야 함.
commit;

/***********************************
모델1 방식의 회원제 게시판 제작하기
***********************************/
insert into board (num, title, content, id, postdate, visitcount)
    values (seq_board_num.nextval, '지금은 봄입니다', '봄의왈츠', 'musthave', sysdate, 0);
insert into board (num, title, content, id, postdate, visitcount)
    values (seq_board_num.nextval, '지금은 여름입니다', '여름향기', 'musthave', sysdate, 0);
insert into board (num, title, content, id, postdate, visitcount)
    values (seq_board_num.nextval, '지금은 가을입니다', '가을동화', 'musthave', sysdate, 0);
insert into board (num, title, content, id, postdate, visitcount)
    values (seq_board_num.nextval, '지금은 겨울입니다', '겨울연가', 'musthave', sysdate, 0);

select * from board;

--DAO의 selectCount()메서드: board테이블의 게시물 개수 카운트
select count(*) from board;
select count(*) from board where title like '%겨울%';
select count(*) from board where title like '%서유기%';
--조건에 따라 0 혹은 그 이상의 정수값이 결과로 인출된다.

--selectList() 메서드: 게시판 목록에 출력할 레코드를 정렬해서 인출
select * from board order by num desc;
select * from board where title like '%봄%' order by num desc;
select * from board where content like '%내용%' order by num desc;
select * from board where title like '%삼국지%' order by num desc;
--조건에 따라 인출되는 레코드가 아예 없을 수도 있다.

commit;


--selectView() 메서드 : 게시물의 내용 상세보기
/*  board테이블에는 id만 저장되어 있으므로 이름까지 출력하기 위해 
    member테이블과 join을 걸어서 쿼리문을 구성한다. */
select *
    from board B inner join member M
        on B.id=M.id
where num=4 ; /* 2개 테이블의 모든 컬럼을 가져와서 인출한다. */

/* 내용보기에서 출력할 내용만 가져오면 되므로 아래와 같이 별칭을 이용해서 
인출할 컬럼을 지정한다.*/
select B.*, M.name
    from board B inner join member M
        on B.id=M.id
where num=5 ;

--Join을 위한 참조컬럼명이 동일하므로 using으로 간단하게 표현할 수 있다.
select *
    from board inner join member using(id)
where num=5 ;


--updateVisitCount() 메서드 : 게시물 조회시 visitcount 컬럼에 1을 증가시키는 작업
update board set visitcount = visitcount + 1 where num=2;
select * from board;

commit;

--updateEdit() 메서드 : 게시물 수정을 위한 쿼리문
update board 
    set title='수정테스트', content='update문으로 게시물을 수정해봅니다.'
    where num=6 ;
select * from board;
commit;


/*
모델1 게시판의 페이징 기능 추가를 위한 서브쿼리문
*/
--1. board 테이블의 게시물을 내림차순으로 정렬한다.
select * from board order by num desc;

--2. 내림차순으로 정렬된 상태에서 rownum을 통해 순차적인 번호를 부여한다.
select tb.*, rownum from (
    select*from board order by num desc) tb;

--3. rownum을 통해 각 페이지에서 출력할 게시물의 구간을 결정한다.
select*from 
    (select tb.*, rownum rNum from 
        (select*from board order by num desc) tb
)
/*where  rNum>=1 and rNum<=10;*/
where  rNum>=11 and rNum<=20;
/*where  rNum>=11 and rNum<=20;*/
/*where rNum between 21 and 30*/

--4. 검색어가 있는 경우에는 where절이 동적으로 추가된다. 
  --  like절은 가장 안쪽의 쿼리문에 추가하면 된다.
  -- 검색조건에 맞는 게시물을 인출한 후 rownum을 부여한다.

select*from 
    (select tb.*, rownum rNum from 
        (select*from board 
        where title like '%9번째%'
        order by num desc) tb
)
where  rNum>=1 and rNum<=10;




--모델2 방식의 파일첨부형 게시판 테이블 생성
create table mvcboard (
    idx number primary key, /*일련번호*/
    name varchar2(50) not null, /*작성자 이름*/
    title varchar2(200) not null, /*제목*/
    content varchar2(2000) not null,/*내용*/
    postdate date default sysdate not null,/*작성일*/
    ofile varchar2(200),/*원본파일명*/
    sfile varchar2(30),/*서버에 저장된 파일명*/
    downcount number(5) default 0 not null,/*파일다운로드 횟수*/
    pass varchar2(50) not  null,/*패스워드*/
    visitcount number default 0 not null/*게시물 조회수*/
);

--더미 데이터 입력
insert into mvcboard (idx, name, title, content, pass)
    values (seq_board_num.nextval, '김유신', '자료실 제목1 입니다.','내용','1234');
insert into mvcboard (idx, name, title, content, pass)
    values (seq_board_num.nextval, '장보고', '자료실 제목2 입니다.','내용','1234');
insert into mvcboard (idx, name, title, content, pass)
    values (seq_board_num.nextval, '이순신', '자료실 제목3 입니다.','내용','1234');
insert into mvcboard (idx, name, title, content, pass)
    values (seq_board_num.nextval, '강감찬', '자료실 제목4 입니다.','내용','1234');
insert into mvcboard (idx, name, title, content, pass)
    values (seq_board_num.nextval, '대조영', '자료실 제목5 입니다.','내용','1234');


commit;
select * from mvcboard;































































