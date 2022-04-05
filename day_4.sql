CREATE TABLE t_member_hobbit (
	memberID CHAR(8) NOT NULL ,
	hobbit_id INT(10) UNSIGNED NOT NULL ,
	PRIMARY KEY (memberID, hobbit_id), -- PK 여러개 줄때는 항상 이 방법
	FOREIGN KEY (memberID) REFERENCES membertbl (memberID),
	FOREIGN KEY (hobbit_id) REFERENCES t_hobbit_2 (hobbit_id)
);
-- FK 걸려있으면 참조한 데이터 안지워진다

SELECT * FROM t_member_hobbit;

-- 툴 이용) 테이블 탭 외래키 확인 (fk 연결됐는지 확인)

-- fk 걸려있는 값만 들어감
INSERT INTO t_member_hobbit
( memberid, hobbit_id )
VALUES
( '1', 1 );

INSERT INTO t_member_hobbit
( memberid, hobbit_id )
VALUES
( '1', 2 );

INSERT INTO t_member_hobbit
( memberid, hobbit_id )
VALUES
( '2', 3 ), ( '2 ', 7 ), ( '2' , 8 );

INSERT INTO t_member_hobbit
( memberid, hobbit_id )
VALUES
( '8', 6 );

-- join 걸어보자
SELECT B.*, A.*
FROM t_member_hobbit A
INNER JOIN membertbl B
ON A.memberID = B.memberID ;

SELECT B.*, A.*, C.*
FROM t_member_hobbit A
INNER JOIN membertbl B
ON A.memberID = B.memberID
INNER JOIN t_hobbit_2 C
ON A.hobbit_id = C.hobbit_id;

-- 문제 사원번호, 사원명, 직책, 부서이름

USE `employees`;

SELECT * from employees;

SELECT A.emp_no, A.first_name, A.last_name, B.title
FROM employees A
INNER JOIN titles B
ON A.emp_no = B.emp_no;

SELECT A.emp_no, A.first_name, A.last_name, B.title, D.dept_name
FROM employees A
INNER JOIN titles B
ON A.emp_no = B.emp_no
INNER JOIN dept_manager C
ON A.emp_no = C.emp_no
INNER JOIN departments D
ON C.dept_no = D.dept_no;

/* 야호 부서이름까지 해냈다!!!!!!!!!!
employees.emp_no = dept_manager.emp_no
dept_manager.dept_no = departments.dept_no
select departments.dept_name
*/
-- fk 걸려있지 않아도 join 걸린다!

-- 남녀 사원의 평균 연봉
SELECT A.gender, AVG(salary) AS avg_salary
FROM employees A
INNER JOIN salaries B
ON A.emp_no = B.emp_no
GROUP BY A.gender ; -- gender 앞에 A 붙이는게좋다. 에러가 날 건덕지 자체를 주지 마라!

-- 가장 높은 평균 연봉 값을 가진 개인이 속한 부서는?

SELECT C.dept_name, MAX(a.salary) AVG(a.salary)
FROM salaries A
INNER JOIN dept_emp B
ON A.emp_no = B.emp_no
INNER JOIN departments C
ON B.dept_no = C.dept_no; -- 망함

SELECT C.dept_no, max(avg(salary))
FROM employees A
INNER JOIN salaries B
ON A.emp_no = B.emp_no
INNER JOIN dept_emp C
ON B.emp_no = C.emp_no
GROUP BY C.dept_no; -- 망함

-- 부서별 부서이름  연봉 평균값, max값, min값
SELECT C.dept_no, C.dept_name, AVG(A.salary), MAX(A.salary), MIN(A.salary)
FROM salaries A
INNER JOIN dept_emp B
ON A.emp_no = B.emp_no
INNER JOIN departments C
ON B.dept_no = C.dept_no
GROUP BY C.dept_no, C.dept_name;

SELECT D.dept_name, AVG(B.salary), MAX(B.salary), MIN(B.salary) 
FROM employees A
INNER JOIN salaries B
ON A.emp_no = B.emp_no 
INNER JOIN dept_emp C
ON B.emp_no = C.emp_no
INNER JOIN departments D
ON C.dept_no = D.dept_no
GROUP BY D.dept_name;

SELECT B.title, AVG(A.salary)
FROM salaries A
INNER JOIN titles B
ON A.emp_no = B.emp_no
GROUP BY B.title; -- ?

-- 전체 "개인" 평균 연봉 중에서 가장 높은 연봉 받는 사람의 부서 찾아내는거

SELECT C.dept_name, AVG(A.salary)
FROM salaries A
INNER JOIN dept_emp B
ON A.emp_no = B.emp_no
INNER JOIN departments C
ON B.dept_no = C.dept_no
GROUP BY A.emp_no -- ""
ORDER BY AVG(A.salary) DESC
LIMIT 1 ;