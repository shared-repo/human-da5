-- 1. 작업 데이터베이스 선택 (univDB)
USE univDB;

-- 2. cross join
select *
from 학생, 수강
order by 학생.학번;

select *
from 학생 cross join 수강
order by 학생.학번;

-- 3. 학생의 수강정보 조회 ( 학생의 이름 포함 )
select * from 수강; -- 학생 이름 정보 없음
select * from 학생; -- 학생 이름 정보 포함

select *
from 학생 s, 수강 a
where s.학번 = a.학번;

select *
from 학생 s inner join 수강 a
on s.학번 = a.학번;

-- 4. 'c002' 과목을 수강한 학생의 학번, 이름 , 과목번호, 중간성적 조회
select s.학번, s.이름, a.과목번호, a.중간성적
from 학생 s, 수강 a
where s.학번 = a.학번 and a.과목번호 = 'c002';

select s.학번, s.이름, a.과목번호, a.중간성적
from 학생 s inner join 수강 a
on s.학번 = a.학번
where a.과목번호 = 'c002';

-- 5. '정보보호' 과목을 수강한 학생의 학번, 이름, 과목번호 조회
select s.학번, s.이름, l.과목번호
from 학생 s, 수강 a, 과목 l
where s.학번 = a.학번 
	  and a.과목번호 = l.과목번호 
      and l.이름 = '정보보호';
      
select s.학번, s.이름, l.과목번호
from 학생 s
inner join 수강 a
on s.학번 = a.학번
inner join 과목 l
on a.과목번호 = l.과목번호
where l.이름 = '정보보호';








