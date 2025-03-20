-- 1. 작업 데이터베이스 변경 (madang_db)
USE madang_db;

-- 2-1. 김연아 고객이 주문한 도서의 총 판매액을 구하시오. ( 2개의 SQL )
SELECT custid, name
FROM customer 
WHERE name = '김연아';

SELECT SUM(saleprice) 총판매액
FROM orders
WHERE custid = 2; -- 위 SQL을 통해 '김연아' 고객의 고객번호가 2인 것을 확인

-- 2-2. 김연아 고객이 주문한 도서의 총 판매액을 구하시오.
SELECT SUM(saleprice) 총판매액
FROM orders
WHERE custid = ( SELECT custid
				 FROM customer 
				 WHERE name = '김연아' );
                 
-- 3. 작업 데이터베이스 변경 (univDB)
USE univDB;

-- 4-1. 과목번호가 'c002'인 과목을 'B'학점으로 이수한 학생 조회
select * 
from 수강 
where 과목번호 = 'c002' and 평가학점 = 'B';

select * from 학생 where 학번 = 's003';

-- 4-2. 과목번호가 'c002'인 과목을 'B'학점으로 이수한 학생 조회
select * 
from 학생 
where 학번 = ( select 학번 
			  from 수강 
              where 과목번호 = 'c002' and 평가학점 = 'B' );
              
-- 5. 과목번호가 'c002'인 과목을 이수한 학생 조회
--    subquery의 결과가 여러 개일 때에는 in으로 비교
select * 
from 학생 
-- where 학번 IN ( 's001', 's003', 's004' )
where 학번 in ( select 학번 
			   from 수강 
               where 과목번호 = 'c002' );
               
               
-- 6. '정보보호' 과목을 수강한 학생 조회
select * from 과목;
select * from 수강; -- 수강 테이블에는 과목이름이 없음.

select 과목번호 from 과목 where 이름 = '정보보호';

select *
from 학생
where 학번 in (select 학번 
			  from 수강 
			  where 과목번호 = (select 과목번호
							  from 과목 
							  where 이름 = '정보보호'));
                              
                              
-- 7. 과목번호가 'c002'인 과목을 수강한 학생 조회
--    exists : subquery의 결과가 있으면 True, 없으면 False
select * 
from 학생 
where exists ( select *
			   from 수강 
			   where 학생.학번 = 수강.학번 AND 과목번호 = 'c002' );











                 
                 
                 