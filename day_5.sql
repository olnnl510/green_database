-- 형 변환
SELECT '10'; -- 초록색 문자열
SELECT 10; -- 보라색 정수

SELECT '10';
SELECT CONVERT('10', INT) + CONVERT('10', INT); -- 강제 형변환 -- 문자열->정수

SELECT '10' + '10';
/*
일단 사칙연산 (프로그래밍 : 1010)
데이터베이스 : 숫자우선
프로그래밍 : 문자우선
*/

SELECT 10;
SELECT CONVERT (10, CHAR); -- 정수-> 문자열

SELECT CONVERT('10.1', FLOAT); -- 실수값

-- 형변환 case
SELECT CAST('10' AS INT); -- 문자열-> 정수

SELECT 1 > '2mega'; -- 0 false
SELECT 4 > '2mega'; -- 1 true

-- 문자열 합치기 (프로그래밍언어 +) concat
SELECT 'A1' + 'B22';
SELECT CONCAT('A1', '2B2');
SELECT CONCAT('A1', '2B2', '가나다');

-- IF true:앞에꺼 false:뒤에꺼 나옴
SELECT if(100>200, '100은 200보다 크다', '100은 200보다 적다');

USE `employees`;

-- employees 테이블에 gender값이 'M'이면 남자, 'F'이면 여자가 뜨도록.
SELECT gender, if(gender = 'M', '남자', '여자')
FROM employees;

SELECT gender, if(gender = 'F', '여자', '남자')
FROM employees;

-- 응용 M남자 F여자 A외계인
SELECT if('M' = 'M', '남자', if('M' = 'F', '여자', '외계인'));

SELECT if('M' = 'M', '남자', if('M' = 'F', '여자', '외계인'));

-- 응용2 농구 배구 축구
-- 농구 > basketball
-- 배구 > valleyball
-- 축구 > football
SELECT nm, if('농구' = '농구', 'basketball', if('농구' = '배구', 'valleyball', 'football'))
FROM t_hobbit;

SELECT nm, if('농구' = '농구', 'basketball', if(nm = '배구', 'valleyball', 'football')) 'eng'
FROM t_hobbit;

SELECT nm, if('농구' = '농구', 'basketball', if (nm = '배구', 'valleyball', 'football')) 'eng'
from t_hobbit;

-- 익명 제보
SELECT
if(nm = '농구',
	CONCAT(nm, 'basketball'),
	if(nm = '배구',
		CONCAT(nm, 'valleyball'),
		CONCAT(nm, 'football')
	)
)
FROM t_hobbit;

-- if null
INSERT INTO membertbl
(memberid, membername)
VALUES ('3', '윤정인');

INSERT INTO membertbl
(memberid, membername)
VALUES ('4', '김좌훈');

INSERT INTO membertbl
(memberid, membername)
VALUES ('5', '김재훈');

-- ifnull (오라클 : nvl, SQL-Server : isnull)
SELECT *, IFNULL(memberaddress, '주소없음')
FROM membertbl;

-- nullif
SELECT NULLIF('안녕', '안녕'); -- 양쪽값이 같으면 null, 다르면 첫번째 적용
SELECT NULLIF('안녕1', '안녕2');

-- case 값 when 비교값 then
-- 농구 > basketball
-- 배구 > valleyball
-- 축구 > football
SELECT
	nm,
	CASE nm WHEN '농구' THEN 'basketball'
				WHEN '배구' THEN 'valleyball'
				WHEN '축구' THEN 'football'
				ELSE '없음'
	END
FROM t_hobbit;

-- case when 조건식 then
SELECT
	nm,
	CASE WHEN nm = '농구' THEN 'basketball'
			WHEN nm = '배구' THEN 'valleyball'
			WHEN nm = '축구' THEN 'football'
			ELSE '없음'
	END
FROM t_hobbit;

-- 아스키코드
SELECT ASCII('A'), CHAR(65);

-- 문자열 합치기 concat, concat_ws
SELECT CONCAT('A', '_', 'B', '_', 'C');
SELECT CONCAT_WS('_', 'A', 'B', 'C'); -- 구분자

-- 천단위 콤마, 실수 몇자리까지 나타낼지 선택
SELECT FORMAT(11112222.123456, 3);

-- INSERT 
SELECT
	INSERT('abcdefghi', 3, 4, '@@@@') -- 3에서부터 4개지우고 삽입
	, INSERT('abcdefghi', 3, 0, '@@@@'); -- 3번째자리에 추가만

-- upper, lower
SELECT 'aBc', 'AbC', 'aBc' = 'AbC', UPPER('aBc'), UPPER('AbC')
, UPPER('aBc') = UPPER('AbC');

-- 양쪽 공백 지워줌
SELECT '     abc     ', LTRIM('     abc     '), TRIM('     abc     ');
SELECT TRIM(BOTH 'ㅋ' FROM 'ㅋㅋㅋㅋㅋabcㅋㅋㅋ');
SELECT TRIM(LEADING 'ㅋ' FROM 'ㅋㅋㅋㅋㅋabcㅋㅋㅋ');
SELECT TRIM(TRAILING 'ㅋ' FROM 'ㅋㅋㅋㅋㅋabcㅋㅋㅋ');

-- date_format
USE `test`;

SELECT *, DATE_FORMAT(created_at, '%y/%m/%d %r') FROM t_hobbit_2; -- 소문자, 대문자
SELECT *, DATE_FORMAT(created_at, '%Y/%m/%d %p %h:%i') FROM t_hobbit_2;

