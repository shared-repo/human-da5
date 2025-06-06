-- 작업 데이터베이스 변경 (univDB)
use univDB;

-- [ 테이블 만들기 ]

-- 1. tbl_member

--    memberid 문자열 PK
--    passwd 문자열 NOT NULL
--    email 문자열 NOT NULL UNIQUE
--    usertype 문자열 NULL
--    regdate datetime
--    active BOOLEAN 
   
DROP TABLE IF EXISTS tbl_member;
CREATE TABLE tbl_member
(
   memberid VARCHAR(20) PRIMARY KEY,
   passwd VARCHAR(100) NOT NULL,
   email VARCHAR(50) NOT NULL UNIQUE,
   usertype VARCHAR(10) DEFAULT ('user'), -- ( 'user' or 'amdin' )
   regdate DATETIME DEFAULT ( NOW() ),
   active BOOLEAN DEFAULT (TRUE)
); 
DESC tbl_member;     

-- 2. tbl_board

--    boardno int PK 자동증가
--    writer 문자열 NOT NULL
--    title 문자열 NOT NULL
--    content 문자열 not null
--    writedate DATETIME
--    modifydate DATETIME
--    readcount int 
--    외래키 writer -> tbl_member(memberid)  

DROP TABLE IF EXISTS tbl_board;
CREATE TABLE tbl_board
(
   boardno INT PRIMARY KEY AUTO_INCREMENT,
   writer VARCHAR(20) NOT NULL,
   title VARCHAR(100) NOT NULL,
   content VARCHAR(10000) NOT NULL,
   writedate DATETIME DEFAULT ( NOW() ),
   modifydate DATETIME DEFAULT ( NOW() ),
   readcount INT DEFAULT (0), 
   CONSTRAINT fk_member_board FOREIGN KEY (writer) REFERENCES tbl_member(memberid) 
); 
DESC tbl_board;

-- 3. tbl_comment

--    commentno int pk 자동증가
--    writer 문자열 NOT NULL
--    boardno INT not null
--    content 문자열 not null
--    writedate DATETIME
--    modifydate DATETIME
--    외래키 boardno -> tbl_board(boardno)
--    외래키 writer -> tbl_member(memberid)

DROP TABLE IF EXISTS tbl_comment;
CREATE TABLE tbl_comment
(
   commentno INT PRIMARY KEY AUTO_INCREMENT,
   writer VARCHAR(20) NOT NULL,
   boardno INT NOT NULL,
   content VARCHAR(500) NOT NULL,
   writedate DATETIME DEFAULT ( NOW() ),
   modifydate DATETIME DEFAULT ( NOW() ),
   CONSTRAINT fk_board_comment FOREIGN KEY (boardno) REFERENCES tbl_board(boardno),
   CONSTRAINT fk_member_comment FOREIGN KEY (writer) REFERENCES tbl_member(memberid)
);
DESC tbl_comment;   

-- [ 테이블 수정 ]

-- 1. tbl_member 

--    usergrade int 컬럼 추가
--    regdate 컬럼 -> joindate 컬럼으로 변경

ALTER TABLE tbl_member
ADD COLUMN usergrade INT NULL,
CHANGE COLUMN regdate joindate DATETIME DEFAULT ( NOW() );

-- 2. tbl_board

--    category 문자열 not null 컬럼 추가

ALTER TABLE tbl_board
ADD COLUMN category VARCHAR (50) NOT NULL;

-- [ 데이터 추가 ]

-- 1. tbl_member 테이블 데이터 추가

--    'iamuserone', 'iamuserone', 'iamuserone@example.com', 'user', now(), true
--    'iamusertwo', 'iamusertwo', 'iamusertwo@example.com', 'user', now(), true
--    'iamuserthree', 'iamuserthree', 'iamuserthree@example.com', 'user', now(), true

--    'iamadminone', 'iamadminone', 'iamadminone@example.com', 'admin', now(), true

INSERT INTO tbl_member (memberid, passwd, email) -- 나머지 컬럼은 기본값 사용
VALUES ('iamuserone', 'iamuserone', 'iamuserone@example.com'),
	   ('iamusertwo', 'iamusertwo', 'iamusertwo@example.com'),
	   ('iamuserthree', 'iamuserthree', 'iamuserthree@example.com');
       
INSERT INTO tbl_member (memberid, passwd, email, usertype) -- 나머지 컬럼은 기본값 사용
VALUES ('iamadminone', 'iamadminone', 'iamadminone@example.com', 'admin');

SELECT * from tbl_member;

-- 2. tbl_board 테이블 데이터 추가

--    'iamuserone', '게시글 연습 1', '게시글 작성 연습입니다.', now(), now(), 0, 1 
--    'iamuserone', '게시글 연습 2', '게시글 작성 연습입니다.', now(), now(), 0, 1
--    'iamuserone', '게시글 연습 3', '게시글 작성 연습입니다.', now(), now(), 0, 1

INSERT INTO tbl_board (writer, title, content, category)
VALUES ('iamuserone', '게시글 연습 1', '게시글 작성 연습입니다.', 'free'),
	   ('iamuserone', '게시글 연습 2', '게시글 작성 연습입니다.', 'notice'),
	   ('iamuserone', '게시글 연습 3', '게시글 작성 연습입니다.', 'free');
       
SELECT * FROM tbl_board;
 
-- 3. tbl_comment 테이블 데이터 추가

--    - 아래 1, 2, 3은 글번호인데 2번에서 삽입된 글번호 사용

--    'iamusertwo', 1, '게시글 1에 대한 댓글', now(), now()
--    'iamusertwo', 2, '게시글 2에 대한 댓글', now(), now()
--    'iamusertwo', 3, '게시글 3에 대한 댓글', now(), now()

INSERT INTO tbl_comment (writer, boardno, content)
VALUES ('iamusertwo', 1, '게시글 1에 대한 댓글'),
	   ('iamusertwo', 2, '게시글 2에 대한 댓글'),
	   ('iamusertwo', 3, '게시글 3에 대한 댓글');
       
SELECT * FROM tbl_comment;

-- [ 데이터 수정 ]

-- iamuserone 사용자의 password는 'Pa$$word'로 이메일은 'iamuserone@naver.com'으로 변경

UPDATE tbl_member
SET passwd = 'Pa$$word',  email = 'iamuserone@naver.com'
WHERE memberid = 'iamuserone';

SELECT * FROM tbl_member;

-- 1번 게시글의 제목은 '수정된 게시글 1'로 modifydate는 now() 로 변경

UPDATE tbl_board
SET title = '수정된 게시글 1',  modifydate = now()
WHERE boardno = 1;

SELECT * FROM tbl_board;

-- [ 데이터 삭제 ]

-- iamuserthree 사용자 삭제

DELETE FROM tbl_member 
-- WHERE memberid = 'iamuserthree';
WHERE memberid = 'iamusertwo'; -- 이 데이터를 참조하고 있는 데이터가 있다면 삭제 불가능

UPDATE tbl_member 
SET active = FALSE
WHERE memberid = 'iamusertwo';

SELECT * FROM tbl_member;
   