/*
SAP
ERP (전사적 자원 관리)

DCL (데이터 제어어) (유저 만들고, 유저 권한 주고)
아직 안배움

DDL (데이터 정의어)
create, drop, alter, truncate

DML (데이터 조작어)
*/

-- DDL
CREATE DATABASE test2; -- ex) 엑셀파일
DROP database test2;

-- 데이터베이스 대소문자 의미없음
-- 데이터베이스는 전부 제약사항임
CREATE TABLE memberTBL ( -- ex) 시트하나
	memberID CHAR(8) NOT NULL PRIMARY KEY,
	memberName CHAR(5) NOT NULL,
	memberAddress CHAR(20) NULL
	
	CREATE TABLE memberTBL ( -- ex) 시트하나
	memberID CHAR(8) NOT NULL PRIMARY KEY,
	memberName CHAR(5) NOT NULL,
	memberAddress CHAR(20) NULL
	promary KEY (memberID)
	
-- Primary key (PK) : unique, not null, index
-- not null : 값을 입력할 때 무시할 수 없다
-- 틀 : 스키마 (noSQL 은 스키마가 없음)

DROP TABLE membertbl;

create TABLE productTBL ( -- 컬럼 5개
	productName CHAR(4) PRIMARY KEY,
	cost INT NOT NULL, -- INT : 정수형
	MAKEDATE DATE,
	company CHAR(5),
	amount INT NOT NULL
	);
	
/*정수형 signed 음수 사용o signed 음수사용x
-5~5 (11개)
0~10 (11개)
*/

-- CRUD, DML (데이터 조작어) (insert, select, update, delete)
-- Create (insert문)
/*
INSERT INTO 테이블명
(값을 넣고싶은 컬럼명)
values
(값들)
*/
INSERT INTO membertbl
(memberid, membername, memberaddress)
VALUES ('1','홍길동','서울시');

INSERT INTO membertbl
(memberid, membername, memberaddress)
VALUES ('1','홍길동','서울시'); -- duplicate 중복 (PK : unique)

INSERT INTO membertbl
(memberid, membername, memberaddress)
VALUES ('2','홍길동','서울시');

INSERT INTO membertbl
(memberid, membername)
VALUES ('3','홍길동'); -- 문자열 무조건 홑따옴표'로 감싸주기

INSERT INTO membertbl
(memberid, embername)
VALUES ('4'); -- membername은 not null 이기 때문에 에러가 발생

INSERT INTO membertbl
(memberid, membername)
VALUES
('5','신사임당'),
('6','유관순'),
('7','나이팅게일');

-- 컬럼명 생략하는 방법은 안 쓰는게 좋다. 에러가 날 수 있는 여지를 주지 말라
INSERT INTO membertbl
VALUES
('8','사나이','부산시');

INSERT INTO membertbl
(membername, memberid)
VALUES
('구구단','9');

INSERT INTO membertbl
(memberid, membername, memberaddress)
VALUES
('a','사나이','부산시');

-- Read (select문)
/* (문법) 순서 중요
select 보고싶은 컬럼명들 from 테이블명
[ join 테이블 연결 ]
[ where 보고싶은 조건 ]
[ group by 그룹으로 묶는 조건 ]
[ having 그룹으로 묶는 조건에서의 조건 ]
[ order by 레코드 순서 지정 ]
[ limit 보고싶은 레코드 수 ]
*/
SELECT memberid, membername, memberaddress FROM membertbl;
SELECT * FROM membertbl; -- * : 와일드카드 (전체)
SELECT memberid, membername FROM membertbl;
SELECT membername FROM membertbl;

SELECT * FROM membertbl
WHERE memberid = '1'; /* where 절에 pk가 있으면 나온다 혹은 안나온다*/

SELECT * FROM membertbl
WHERE membername = '홍길동'; -- =는 정확하게 똑같을때만 나옴

SELECT * FROM membertbl
WHERE memberaddress = '서울시';

SELECT * FROM membertbl
WHERE memberaddress IS NULL;

SELECT * FROM membertbl
WHERE memberaddress IS not NULL;

SELECT * FROM test.membertbl -- 다른 데이터베이스로도 접근 가능
WHERE memberaddress != '서울시' -- !는 not 이다. '반대'라는 뉘앙스로 기억.
OR memberaddress IS NULL;

-- != 는 <> 와 같음. <>는 db에서만 씀

-- 주소가 '부산시' 이면서 이름이 '사나이'인 레코드를 나타내게 하시오.
SELECT * FROM membertbl
WHERE memberaddress = '부산시'
and membername = '사나이';

-- LIKE문은 문자열 포함된 레코드를 찾을 때.
SELECT * FROM membertbl
WHERE membername = '나이팅게일'; -- 완벽히 똑같아야 함

SELECT * FROM membertbl
WHERE membername LIKE '%팅%'; -- 팅이 어디있든 상관없음

SELECT * FROM membertbl
WHERE membername LIKE '사%'; -- 사가 무조건 제일 앞에있을때만 적용

SELECT * FROM membertbl
WHERE membername LIKE '나%';

SELECT * FROM membertbl
WHERE membername LIKE '%다'; -- 다가 무조건 제일 끝에있을때만

-- Update (update문 수정문)
/*
update 테이블명
set 수정하고 싶은 컬럼명 = 변경하고 싶은 값
where 레코드 선택
*/
select * FROM membertbl
WHERE memberid = '0';

UPDATE membertbl
SET membername = '게일' -- 로 변경
WHERE memberid = '7'; -- 누구만(조건식) : 빠지면 모든레코드.. 위험한상황

UPDATE membertbl
SET membername = 'gugu' -- ' 없으면 명령어로 취급
,memberaddress = '강원도'
-- 컬럼명 = 바꿀값
WHERE memberid = '9';

UPDATE membertbl
SET membername = '111'
, memberaddress = '222'
WHERE memberid = '0'; -- UPDATE 절에 WHERE 없으면 정말 위험하다

/*
my name is hong

camel case : MynameisHong
pascal case : MyNameIsHong
snake case : my_name_is_hong
cabob case (케밥) : my-name-is-hong
*/

-- Delete (delete문)
/* DELEte from 테이블명 where 절 */

-- 주소가 null 레코드 전부 삭제
DELETE FROM membertbl
WHERE memberaddress IS NULL;

DELETE FROM membertbl
WHERE memberid = '12';

DELETE FROM membertbl
WHERE memberid = '0';

/*
질문 : 혹시 where을 1~10 사이에 있는 칼럼중에 서울시민만 선택하고 싶다 이렇게 구체적인것도 되나요?
*/
SELECT * FROM test.membertbl
WHERE memberid BETWEEN '1' AND '9'
AND memberaddress = '서울시';

SELECT *, convert(memberid, INT), CAST(memberid AS INT) -- 형 변화
FROM test.membertbl; -- 문자열 있으면 문자 0으로 바뀜

SELECT '1' + '11' AS num;

SELECT CONCAT('1',' ','11','안녕'); -- mySQL 이 편함
SELECT CONCAT('1', CONCAT(' ', CONCAT('11','안녕'))); -- 오라클은 중복 안됨
/*
함수 make call(호출)
() : arguments (함수 값을 부르는 부분)
오라클은 argument 2개밖에 못부른다

-순서
select concat('1', concat(' ', concat('11', 안녕)));
select concat('1', concat(' ', '11안녕');
select concat('1', ' 11안녕');
select concat'1', ' 11안녕';
*/

/*
A < B : A는 B미만
A <= B : A는 B이하
A > B : A는 B초과
A >= B : A는 B이상
*/

SELECT * FROM employees
WHERE emp_no >= 10010 AND emp_no <= 10020;

SELECT * FROM employees
WHERE emp_no > 10010 AND emp_no < 10020;

SELECT * FROM employees
WHERE emp_no >= 10010 AND emp_no <= 10020 AND gender = 'F';

SELECT * FROM employees
WHERE emp_no BETWEEN 10010 AND 10020; -- 포함 사이

SELECT * FROM membertbl
WHERE membername BETWEEN '홍길동' AND '홍길딩'; -- 문자 속도 느리니 웬만하면  정수로!

/*
문자도 가능
ㄱㄴㄷㄹ순
ㅏㅑㅓㅕ순
가 기 순*/

-- d001, d003, d005
SELECT * FROM employees.departments
WHERE dept_no = 'd001'
OR dept_no ='d003'
or dept_no = 'd005';

SELECT * FROM departments
WHERE dept_no IN ('d001', 'd003', 'd005');

/*홀수 짝수*/
SELECT * FROM employees
WHERE emp_no % 2 = 1; -- 홀수 % mod 사칙연산 외 나머지값

SELECT * FROM employees
WHERE emp_no % 2 = 0; -- 짝수

SELECT 10002 / 2;

SELECT 10002 % 2; -- % 나머지값

SELECT 10003 % 2;

SELECT * FROM departments
WHERE CONVERT (substr(dept_no, 2), INT) % 2 = 0; -- 짝수만

SELECT * FROM departments
WHERE CONVERT (substr(dept_no, 2), INT) % 2 = 1; -- 홀수만

SELECT @rownun:=@rownum+1, A.*
FROM employees A
WHERE (@rownum:=0)=0;

SET @rownum:=0;
SELECT
B.myno, B.*
FROM (
	SELECT (@rownum:=@rownum+1) AS myno, A.*
	FROM employees A
) B
WHERE B.myno % 2 = 0; -- 같이실행