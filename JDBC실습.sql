/*
JDBC 프로그래밍 실습을 위한 워크시트
*/
--JAVA에서 member 테이블에 CRUD기능 구현하기
--member테이블 생성
CREATE TABLE member(
    /* id, pass, name은 문자타입으로 선언. null값을 허용하지 ㅇ낳는 컬럼으로 정의함 . 
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

