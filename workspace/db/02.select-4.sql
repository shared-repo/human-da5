-- 1. univDB 데이터베이스 선택
USE univDB;

-- 2-1. 모든 학생 조회 
SELECT * FROM 학생;

-- 2-2. 남학생 / 여학생 조회
SELECT * FROM 학생 WHERE 성별 = '남';
SELECT * FROM 학생 WHERE 성별 = '여';

-- 2-3. 모든 학생 조회 2
SELECT * FROM 학생 WHERE 성별 = '남'
UNION
SELECT * FROM 학생 WHERE 성별 = '여';

-- 3-1. 1 ~ 3학년 / 2 ~ 4학년 조회
SELECT * FROM 학생 WHERE 학년 BETWEEN 1 AND 3 ORDER BY 학년;
SELECT * FROM 학생 WHERE 학년 BETWEEN 2 AND 4 ORDER BY 학년;

-- 3-2. 1 ~ 4학년 조회
(SELECT * FROM 학생 WHERE 학년 BETWEEN 1 AND 3 ORDER BY 학년)
UNION -- 자동 중복 제거
(SELECT * FROM 학생 WHERE 학년 BETWEEN 2 AND 4 ORDER BY 학년);

-- 3-3. 1 ~ 4학년 조회
(SELECT * FROM 학생 WHERE 학년 BETWEEN 1 AND 3 ORDER BY 학년)
UNION ALL -- 중복 제거 x
(SELECT * FROM 학생 WHERE 학년 BETWEEN 2 AND 4 ORDER BY 학년);






