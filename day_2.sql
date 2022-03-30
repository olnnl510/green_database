USE `employees`;

SELECT * FROM departments;
/*
department테이블에 값을 입력해주세요.
dept_no : d010
dept_name : 'business'
*/

INSERT into departments (dept_no, dept_name)
VALUES ('d010', 'business'); -- duplicate 에러 : 중복

SELECT * FROM employees;
/*
2. employees 테이블에 근로자 등록
emp_no: 500000
birth_date : 1999-10-10 문자열처럼 넣기
first_name : Gildong
last_name : Hong
gender : M
hire-date : 2022-03-29
*/

INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
VALUES (500000, '1999-10-10', 'Gildong', 'Hong', 'M', '2022-03-29');
-- 숫자에 '' 홑따옴표 안넣는게 맞음
-- ENUM 성별 M/F

SELECT * FROM employees
WHERE emp_no = 500000;

DELETE FROM employees
WHERE emp_no = 500000;

/*
employees 테이블에서 여자면서 last_name에 'ch'가 포함되어 있는 사람들 모두 select 하시오.
*/

SELECT * FROM employees
WHERE gender = 'f' and last_name like '%CH%' ;

SELECT * FROM employees
WHERE gender = 'm' AND first_name LIKE '%on%' ;

SELECT * FROM employees
WHERE birth_date LIKE '1952%' ;

/* 함수 사용 (left, right, mid), like 기능 언더바(자리차지) */
SELECT * FROM employees
where LEFT(birth_date, 4) = '1952' ;

SELECT * FROM employees
WHERE LEFT(birth_date, 4) >= '1960'; -- => 안됨

SELECT * from employees
where right(birth_date, 2);

select birth_date, RIGHT(birth_date, 2), MID(birth_date, 6, 2)
FROM employees;

select birth_date
-- cast (값 as 바꾸고 싶은 타입)
-- cast('1953' as int)
	  , CAST(LEFT(birth_date,4) AS INT) - 10
     , LEFT(birth_date,4) AS l4
     , RIGHT(birth_date, 2) m2
     , MID(birth_date, 6, 2) r2
	FROM employees;
-- mid 6번째부터 두칸 
-- 초록색 문자열 파랑색 숫자

SELECT * FROM employees WHERE emp_no = 500000;

/*
employees 테이블에서
emp_no : 500000 사원의 성별을 여성으로 바꾸고, hire_date는 2021-03-29로 바꾸고, first_name은 Jindong으로 변경
*/

/* 
-from 들어가는것
select form
delete from

insert into
*/
UPDATE employees
set gender = 'F',
hire_date = '2021-03-29',
first_name = 'Jindong'
WHERE emp_no = 500000 ;

SELECT * FROM employees
WHERE emp_no = 500000 ;

/* employees 테이블에서 고용일자가 2020년 이후인 사람들 삭제하는 쿼러문 */
DELETE FROM employees
WHERE LEFT(hire_date, 4) >= '2020';

-- delete 진짜 진짜 진짜 진짜 조심하자
-- update문, delete문 항상 where절과 함께!

SELECT * FROM employees;

SELECT 1+1 AS ddd; -- 컬럼명 셀렉트 할때만 잠시만 바꿈

SELECT A.emp_no AS my_no FROM employees A;

SELECT emp_no 'gender' FROM employees;

/* alias 붙이는법 테이블에는 as 안붙여도됨(오라클)
앞에는 as 붙여도 안붙여도 '' `` 다 가능
*/
-- 파랑색 부분 대문자로 쓰면 가독성 upup
/* emp_no = 499613인 근로자의 생년월일과 같은 사람을 찾자*/
DESC employees;

SELECT * FROM employees
WHERE birth_date = '1953-06-09';

SELECT birth_date FROM employees
WHERE emp_no = 499613;

SELECT * FROM employees
WHERE birth_date = (SELECT birth_date FROM employees
WHERE emp_no = 499613); -- 서브쿼리 먼저 선택실행

/* emp_no : 499619 사람과 같은 성별을 갖고있는 사람만 나타나도록 해주세요
(그리고 499619인 사람은 select 결과물에 안 나오도록 해주세요.) */

SELECT * FROM employees
WHERE gender = 'M';

SELECT * FROM employees
WHERE gender = (select gender from employees
WHERE emp_no = 499619);

SELECT * FROM employees
WHERE gender = (select gender from employees
WHERE emp_no = 499619) and emp_no != 499619;

/*스칼라 값: 행도 하나, 컬럼도 하나인것 ex) gender
= 쓸때 스칼라 값 1개 여야함
=과 서브쿼리를 사용할 때는 서브쿼리가 스칼라값이어야 한다.*/

-- some과 any는 동일하다.
-- 786,848 결과물
SELECT * FROM salaries
WHERE salary >= ANY ( SELECT salary FROM salaries
WHERE emp_no = 10010 );

-- 480,870 결과물
SELECT * FROM salaries
WHERE salary >= ALL ( SELECT salary FROM salaries
WHERE emp_no = 10010 );

SELECT * FROM salaries
WHERE salary = ANY ( SELECT salary FROM salaries
WHERE emp_no = 10010 );

/* any all(성능 떨어짐) 굳이 쓸필요 없이 대체 가능
서브쿼리 쓸때 스칼렛값 이면 =, >
서브쿼리 값이 여러개면 in
(where절 컬럼이 여러개면 안됨. 레코드가 여러개인것 상관없음)*/

SELECT * FROM salaries
WHERE salary in ( SELECT salary FROM salaries
WHERE emp_no = 10010 );

/*오름차순(위에서 아래로 값이 커진다)asc
내림차순(위에서 아래로 값이 작아진다)desc*/

DESC employees;

SELECT * FROM salaries
ORDER BY emp_no ASC; -- 기본값

SELECT * FROM salaries
ORDER BY emp_no desc;

SELECT * FROM salaries
WHERE emp_no IN (499988, 499987, 499986)
ORDER BY emp_no DESC, salary desc; -- asc자동

/*
employees 테이블에서 나이는 내림차순으로
성별은 여성이 위로, 남성이 아래로 나오게 select 하시오.
*/
SELECT * FROM employees
ORDER BY birth_date DESC, gender DESC;