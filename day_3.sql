-- edpt_emp 테이블에서 dept_no 종류가 몇개 있는지?
SELECT dept_no FROM dept_emp;

SELECT distinct dept_no FROM dept_emp; -- 중복제거

-- 사원의 직무가 무엇이 있는지 select 해주시오.
SELECT DISTINCT title
FROM titles
ORDER BY title;

-- limit 인자값 하나만 주는 경우/둘 주는 경우
-- limit ? / limit ?, ?
-- 전체 명령어중 가장 마지막 순서로!
SELECT * FROM employees
LIMIT 30; -- 0, 30;

SELECT * FROM employees
LIMIT 10, 10; -- 0: index (번호)/ 갯수

/* 가장 많은 연봉을 받은 금액 3개만 나오도록*/
SELECT * FROM salaries
order BY salary DESC
LIMIT 3;

/*위의 결과에서 5위~10위만 나오도록 */
SELECT * FROM salaries
order BY salary DESC
LIMIT 4, 6; -- index로치면 0부터 시작, 6명

/*테이블 복사*/
-- 테이블 컬럼, 데이터타입, 레코드 복사. (제약조건, pk, fk, default, check, not null)

CREATE TABLE department_temp2 AS -- 이때는 alias 아니고 ~로써의 as
SELECT * FROM departments;

-- 테이블 스키마까지 전부 복사 (레코드 x)
CREATE table departments_temp3
like departments;

INSERT INTO departments_temp3
SELECT * FROM departments;

-- 그룹 함수 min, max, sum, avg, count

-- GROUP BY를 사용 안했을 때는 "전체"에서 값을 가져옴
SELECT MIN(salary), MAX(salary), SUM(salary), AVG(salary), COUNT(emp_no),
SUM(salary) / COUNT(*)
FROM salaries;

-- avg = SUM(salary) / COUNT(*) (null 값이 끼면 x)

SELECT emp_no, MIN(salary), MAX(salary), SUM(salary), AVG(salary), COUNT(salary)
FROM salaries
GROUP BY emp_no;

/*
distnct(중복제거)와 다름.
그룹끼리 묶음
그룹별로 min값 찾을 수 있음

group 함수 : 전체
group by 함수 : 그룹별

group by 에 적은 컬럼만! 함수에 나오게!
*/

SELECT dept_no, COUNT(*)
from dept_emp
GROUP BY dept_no;

/* 부서별 사원수, 부서별 사원수 20,000명 이상인 부서만 나오도록 한다.*/
SELECT dept_no, COUNT(*)
from dept_emp
GROUP BY dept_no
HAVING COUNT(*) >= 20000
ORDER BY COUNT(*) DESC; -- 결과값으로 정렬

-- having : group by 결과에서 조건식을 더 주고싶을 때 씀

-- (hell) 급여 가장 적은사람의 이름이 나오게
SELECT * FROM employees
WHERE emp_no = (
	SELECT emp_no FROM salaries
	WHERE salary = (SELECT MIN(salary) FROM salaries)); -- limit가 없어서 여러명인 경우도 나옴

SELECT * FROM employees
WHERE emp_no = 253406;
SELECT emp_no FROM salaries
WHERE salary = 38623;
SELECT MIN(salary) FROM salaries;

SELECT * FROM employees
WHERE emp_no = (
select emp_no
FROM employees.salaries
ORDER BY salary
LIMIT 1);

SELECT * FROM employees
WHERE emp_no = 253460 ;

SELECT emp_no, salary
FROM salaries
ORDER BY salary;

SELECT emp_no, salary
FROM salaries
ORDER BY salary
LIMIT 1;

-- auto_increment : pk, unique 여야만 한다
USE `test`;

CREATE TABLE t_hobbit(
	i_hobbit INT UNSIGNED AUTO_INCREMENT, -- insert 자동으로 값 생성, insert 에러 터지면 count되고 올라감ㅠㅠ
	nm VARCHAR(10) UNIQUE NOT NULL,
	PRIMARY KEY (i_hobbit)
);

-- pk 값은 주민번호와 같다. 죽었다고 주민번호 땡기지 않는다. 그 글의 정체성!
SELECT * FROM t_hobbit;

INSERT INTO t_hobbit (nm)
VALUES ('농구');

INSERT INTO t_hobbit (nm)
VALUES ('축구');

INSERT INTO t_hobbit (nm)
VALUES ('배구');

INSERT INTO t_hobbit (nm)
VALUES ('야구'),('탁구');

SELECT * FROM t_hobbit_2;

CREATE TABLE t_hobbit_2(
	hobbit_id INT UNSIGNED PRIMARY KEY,
	NAME VARCHAR(20) NOT NULL,
	created_at DATETIME DEFAULT NOW()
);

CREATE TABLE t_hobbit_2(
	hobbit_id INT UNSIGNED PRIMARY KEY,
	NAME VARCHAR(20) NOT NULL,
	created_at DATETIME DEFAULT NOW()
);

SELECT NOW(), CURRENT_DATE(), CURRENT_TIMESTAMP();

INSERT INTO t_hobbit_2
(hobbit_id, NAME)
VALUES
(1, '핸드볼');

INSERT INTO t_hobbit_2
(hobbit_id, NAME, created_at)
VALUES
(2, '등산', '2022-02-10');

INSERT INTO t_hobbit_2
(hobbit_id, NAME, created_at)
VALUES
(3, '독서', '2022-02-12 12:12:13');

SELECT * FROM t_hobbit;
SELECT * FROM t_hobbit_2;

INSERT INTO t_hobbit_2
(hobbit_id, NAME)
select i_hobbit + 3, nm FROM t_hobbit; -- pk 중복방지

-- 각 직업별로 평균 급여를 보고 싶으면 어떻게 하면 될까요?
-- 아직 join 배우지 않은 상태
USE `employees`;

SELECT title, AVG(salary) AS avg_salary
FROM titles A
INNER JOIN salaries B
ON A.emp_no = B.emp_no
GROUP BY a.title;

-- emp_no: 10001의 모든 salary를 1,000씩 올리고 싶다
UPDATE salaries
SET salary = salary + 1000
WHERE emp_no = 10001;

SELECT * FROM salaries
WHERE emp_no = 10001;

-- insert ignore
SELECT * from t_hobbit_2;

INSERT ignore INTO t_hobbit_2 (hobbit_id, NAME) VALUES (7,'탁구');
INSERT ignore INTO t_hobbit_2 (hobbit_id, NAME) VALUES (8,'스키');

INSERT INTO t_hobbit_2 ( hobbit_id, NAME) VALUES (7,'탁구')
ON DUPLICATE KEY UPDATE NAME = '수영';

INSERT INTO t_hobbit_2 ( hobbit_id, NAME) VALUES (8,'산책')
ON DUPLICATE KEY UPDATE NAME = '달리기';

CREATE TABLE t_board (
i_board INT UNSIGNED PRIMARY KEY,
hits INT UNSIGNED DEFAULT 0
);

SELECT * FROM t_board;

INSERT INTO t_board (i_board, hits) VALUES (1,0)
ON DUPLICATE KEY UPDATE hits = hits + 1;

DROP TABLE department_temp;

CREATE TABLE t_board (
i_board INT UNSIGNED PRIMARY KEY,
title VARCHAR(20) UNIQUE NOT NULL,
hits INT UNSIGNED DEFAULT 0
);

INSERT INTO t_board (i_board, title, hits) VALUES (1,'안녕',0)
ON DUPLICATE KEY UPDATE hits = hits + 1;

-- 재귀 : 자기가 자기를 다시 호출하는것 임시테이블
WITH dept_emp_d001(emp_no, from_date, to_date)
AS ( 
	SELECT emp_no, from_date, to_date
	FROM dept_emp
	where dept_no = 'd001'
	)
SELECT A.* FROM dept_emp_d001 AS A;

SELECT * FROM -- Alias 서브쿼리 ?? 결과물들의 부모처럼 실행이 된다
(
	SELECT emp_no, from_date, to_date
	FROM dept_emp
	where dept_no = 'd001'
) A; --끝에 Alias를 꼭 줘야함
-- ()employees 결과물을 임시로 A라고 이름을 준거임

/*사람별 평균 급여에의 평균값보다 큰 사람들의 이름이 나오게 해주세요.*/

SELECT FROM salaries
WHERE emp_no IN(
select emp_no
FROM salaries
GROUP BY emp_no
having AVG(salary) >= ( ;

CREATE TABLE t_order (
	o_no INT PRIMARY KEY,
	cus_no INT,
	o_date DATETIME DEFAULT NOW(),
	o_price INT
	);

DROP TABLE t_order;

CREATE TABLE t_order(
o_no INT UNSIGNED PRIMARY KEY,
cus_no INT UNSIGNED,
o_date DATE DEFAULT CURRENT_TIMESTAMP,
o_price INT DEFAULT 0
);

CREATE TABLE T_CUSTOMER (
	cus_no INT PRIMARY KEY,
	nm CHAR(10) NOT NULL
);

DROP TABLE t_customer;

CREATE TABLE t_customer (
	cus_no INT UNSIGNED,
	nm VARCHAR(10) NOT NULL,
	PRIMARY KEY (cus_no)
);

-- char 용량차지 많음 varchar

SELECT * FROM t_order;

SELECT * FROM t_customer;

-- fk (fk 안걸려있어도 join 걸 수 있음)
-- fk값 : 내가 참조한 테이블에 있는 값만 넣을수 있도록 해준다.
-- 제약조건 : 잘못된 값이 들어가지 않도록 거는것!

CREATE TABLE t_customer (
	cus_no INT UNSIGNED,
	nm VARCHAR(10) NOT NULL,
	PRIMARY KEY (cus_no)
);

CREATE TABLE t_order(
	o_no INT UNSIGNED PRIMARY KEY,
	cus_no INT UNSIGNED,
	o_date DATE DEFAULT CURRENT_TIME,
	o_price INT DEFAULT 0,
	FOREIGN KEY (cus_no) REFERENCES t_customer(cus_no) -- fk
);

/*
constraint jkjkjkjk FOREIGN KEY (cus_no) REFERENCES t_customer(cus_no)

constraint 제약조건 이름
fk 컬럼명 달라도 상관없음.
int 등 속성은 맞춰야함.
*/

INSERT INTO t_customer
(cus_no, nm)
VALUES
(3, '홍길동');

INSERT INTO t_customer
(cus_no, nm)
VALUES
(5, '이순신');

INSERT INTO t_order
(o_no, cus_no, o_price)
VALUES
(1,3,55000);

INSERT INTO t_order
(o_no, cus_no, o_price)
VALUES
(2,5,70000);

INSERT INTO t_order
(o_no, cus_no, o_price)
VALUES
(3,3,60000);

SELECT * FROM t_order;

SELECT * FROM t_customer;

UPDATE t_customer
SET nm = '장보고'
WHERE cus_no = 5;

DELETE FROM t_order
WHERE o_no = 2;

SELECT * FROM t_order;

SELECT * FROM t_order
WHERE cus_no = 3;

SELECT o_no, o_price FROM t_order;

-- fk 3,5만 들어가짐