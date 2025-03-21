-- 1. 작업 데이터베이스 선택 (univDB)
use univDB;

-- 2-1. 테이블 만들기 (컬럼명, 자료형)
SELECT * FROM  과목;
CREATE TABLE 과목2
(
	-- 컬럼이름 자료형 제약조건1, 제약조건2, ...
    과목번호 CHAR(4),
    이름 VARCHAR(20),
    강의실 SMALLINT,
    개설학과 VARCHAR(20),
    시수 SMALLINT
);

-- 2-2. 테이블 만들기 (기본키 지정 1)
CREATE TABLE 과목3
(
	-- 컬럼이름 자료형 제약조건1, 제약조건2, ...
    과목번호 CHAR(4) PRIMARY KEY,
    이름 VARCHAR(20),
    강의실 SMALLINT,
    개설학과 VARCHAR(20),
    시수 SMALLINT
);

-- 2-3. 테이블 만들기 (기본키 지정 2)
CREATE TABLE 과목4
(
	-- 컬럼이름 자료형 제약조건1, 제약조건2, ...
    과목번호 CHAR(4),
    이름 VARCHAR(20),
    강의실 SMALLINT,
    개설학과 VARCHAR(20),
    시수 SMALLINT,
    -- PRIMARY KEY (과목번호)
    CONSTRAINT PK_과목4 PRIMARY KEY (과목번호)
);

-- 2-4. 테이블 만들기 (제약조건 - NULL 허용 여부)
CREATE TABLE 과목5
(
	-- 컬럼이름 자료형 제약조건1, 제약조건2, ...
	과목번호 CHAR(4) NOT NULL,
    이름 VARCHAR(20) NOT NULL,
    강의실 SMALLINT NULL,
    개설학과 VARCHAR(20) NOT NULL,
    시수 SMALLINT NOT NULL,
    -- PRIMARY KEY (과목번호)
    CONSTRAINT PK_과목5 PRIMARY KEY (과목번호)
);

-- 2-5. 테이블 만들기 (제약조건 - DEFAULT)
CREATE TABLE 과목6
(
	-- 컬럼이름 자료형 제약조건1, 제약조건2, ...
	과목번호 CHAR(4) NOT NULL,
    이름 VARCHAR(20) NOT NULL,
    강의실 SMALLINT NULL,
    개설학과 VARCHAR(20) NOT NULL,
    시수 SMALLINT DEFAULT (3), -- 값이 지정된지 않으면 3을 사용
    -- PRIMARY KEY (과목번호)
    CONSTRAINT PK_과목6 PRIMARY KEY (과목번호)
);

-- 2-6. 테이블 만들기 (제약조건 - CHECK 제약 조건)
CREATE TABLE 과목7
(
	-- 컬럼이름 자료형 제약조건1, 제약조건2, ...
	과목번호 CHAR(4) NOT NULL,
    이름 VARCHAR(20) NOT NULL,
    강의실 SMALLINT NULL,
    개설학과 VARCHAR(20) NOT NULL,
    시수 SMALLINT DEFAULT(3) CHECK(시수 > 0),
    -- PRIMARY KEY (과목번호)
    CONSTRAINT PK_과목7 PRIMARY KEY (과목번호)
    -- , CONSTRAINT CHK_시수 CHECK(시수>0)
);

INSERT INTO 과목7
VALUES ('C001', '테스트1', 1, '테스트1', -1);


-- 2-7. 테이블 만들기 (자동증가컬럼)
CREATE TABLE 과목8
(
	-- 컬럼이름 자료형 제약조건1, 제약조건2, ...
	과목번호 INT NOT NULL AUTO_INCREMENT, --  이 컬럼의 값은 INSERT 할 때마다 1, 2, 3, ... 순서로 자동 저장
    이름 VARCHAR(20) NOT NULL,
    강의실 SMALLINT NULL,
    개설학과 VARCHAR(20) NOT NULL,
    시수 SMALLINT DEFAULT(3) CHECK(시수 > 0),
    -- PRIMARY KEY (과목번호)
    CONSTRAINT PK_과목8 PRIMARY KEY (과목번호)
    -- , CONSTRAINT CHK_시수 CHECK(시수>0)
);

INSERT INTO 과목8 (이름, 강의실, 개설학과)
VALUES ('테스트1', 1, '테스트1');

INSERT INTO 과목8 (이름, 강의실, 개설학과)
VALUES ('테스트2', 2, '테스트2');

-- 2-8. 테이블 만들기 ( 관계 만들기 - Foreign Key )








