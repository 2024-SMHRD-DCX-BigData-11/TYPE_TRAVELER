-- 테이블 순서는 관계를 고려하여 한 번에 실행해도 에러가 발생하지 않게 정렬되었습니다.

-- tb_region Table Create SQL
-- 테이블 생성 SQL - tb_region
CREATE TABLE tb_region
(
    region_id         NUMBER(18, 0)     NOT NULL, 
    region_title      VARCHAR2(1000)    NOT NULL, 
    region_info       CLOB              NULL, 
    region_address    VARCHAR2(1000)    NULL, 
    keyword           VARCHAR2(1500)    NULL, 
    region_img        VARCHAR2(255)     NULL, 
     PRIMARY KEY (region_id)
);

-- 테이블 Comment 설정 SQL - tb_region
COMMENT ON TABLE tb_region IS '지역 정보';

-- 컬럼 Comment 설정 SQL - tb_region.region_id
COMMENT ON COLUMN tb_region.region_id IS '지역 아이디';

-- 컬럼 Comment 설정 SQL - tb_region.region_title
COMMENT ON COLUMN tb_region.region_title IS '지역 명';

-- 컬럼 Comment 설정 SQL - tb_region.region_info
COMMENT ON COLUMN tb_region.region_info IS '지역 소개';

-- 컬럼 Comment 설정 SQL - tb_region.region_address
COMMENT ON COLUMN tb_region.region_address IS '지역 주소';

-- 컬럼 Comment 설정 SQL - tb_region.keyword
COMMENT ON COLUMN tb_region.keyword IS '태그';

-- 컬럼 Comment 설정 SQL - tb_region.region_img
COMMENT ON COLUMN tb_region.region_img IS '지역 이미지';


-- tb_user Table Create SQL
-- 테이블 생성 SQL - tb_user
CREATE TABLE tb_user
(
    user_email    VARCHAR2(50)    NOT NULL, 
    user_pw       VARCHAR2(50)    NOT NULL, 
    user_name     VARCHAR2(50)    NOT NULL, 
    user_mbti     VARCHAR2(4)     NOT NULL, 
    joined_at     DATE            DEFAULT SYSDATE NOT NULL, 
     PRIMARY KEY (user_email)
);

-- 테이블 Comment 설정 SQL - tb_user
COMMENT ON TABLE tb_user IS '회원';

-- 컬럼 Comment 설정 SQL - tb_user.user_email
COMMENT ON COLUMN tb_user.user_email IS '회원 이메일(아이디)';

-- 컬럼 Comment 설정 SQL - tb_user.user_pw
COMMENT ON COLUMN tb_user.user_pw IS '회원 비밀번호';

-- 컬럼 Comment 설정 SQL - tb_user.user_name
COMMENT ON COLUMN tb_user.user_name IS '회원 이름';

-- 컬럼 Comment 설정 SQL - tb_user.user_mbti
COMMENT ON COLUMN tb_user.user_mbti IS '회원 MBTI';

-- 컬럼 Comment 설정 SQL - tb_user.joined_at
COMMENT ON COLUMN tb_user.joined_at IS '회원 가입일자';

-- Index 설정 SQL - tb_user(user_name)
CREATE INDEX IX_tb_user_1
    ON tb_user(user_name);


-- tb_recruit_tm Table Create SQL
-- 테이블 생성 SQL - tb_recruit_tm
CREATE TABLE tb_recruit_tm
(
    recruit_id        NUMBER(18, 0)     NOT NULL, 
    user_email        VARCHAR2(50)      NOT NULL, 
    travel_title      VARCHAR2(1000)    NOT NULL, 
    travel_info       CLOB              NOT NULL, 
    travel_img1       VARCHAR2(1000)    NULL, 
    travel_img2       VARCHAR2(1000)    NULL, 
    travel_img3       VARCHAR2(1000)    NULL, 
    created_at        DATE              DEFAULT SYSDATE NOT NULL, 
    closed_at         DATE              NOT NULL, 
    recruit_status    CHAR(1)           DEFAULT 'N' NOT NULL, 
     PRIMARY KEY (recruit_id)
);

-- Auto Increment를 위한 Sequence 추가 SQL - tb_recruit_tm.recruit_id
CREATE SEQUENCE tb_recruit_tm_SEQ
START WITH 1
INCREMENT BY 1;

-- Auto Increment를 위한 Trigger 추가 SQL - tb_recruit_tm.recruit_id
CREATE OR REPLACE TRIGGER tb_recruit_tm_AI_TRG
BEFORE INSERT ON tb_recruit_tm 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT tb_recruit_tm_SEQ.NEXTVAL
    INTO :NEW.recruit_id
    FROM DUAL;
END;

-- DROP TRIGGER tb_recruit_tm_AI_TRG; 

-- DROP SEQUENCE tb_recruit_tm_SEQ; 

-- 테이블 Comment 설정 SQL - tb_recruit_tm
COMMENT ON TABLE tb_recruit_tm IS '여행 동반자 찾기';

-- 컬럼 Comment 설정 SQL - tb_recruit_tm.recruit_id
COMMENT ON COLUMN tb_recruit_tm.recruit_id IS '동반자찾기 식별자';

-- 컬럼 Comment 설정 SQL - tb_recruit_tm.user_email
COMMENT ON COLUMN tb_recruit_tm.user_email IS '등록자 이메일(아이디)';

-- 컬럼 Comment 설정 SQL - tb_recruit_tm.travel_title
COMMENT ON COLUMN tb_recruit_tm.travel_title IS '여행 제목';

-- 컬럼 Comment 설정 SQL - tb_recruit_tm.travel_info
COMMENT ON COLUMN tb_recruit_tm.travel_info IS '여행 소개';

-- 컬럼 Comment 설정 SQL - tb_recruit_tm.travel_img1
COMMENT ON COLUMN tb_recruit_tm.travel_img1 IS '여행 사진1';

-- 컬럼 Comment 설정 SQL - tb_recruit_tm.travel_img2
COMMENT ON COLUMN tb_recruit_tm.travel_img2 IS '여행 사진2';

-- 컬럼 Comment 설정 SQL - tb_recruit_tm.travel_img3
COMMENT ON COLUMN tb_recruit_tm.travel_img3 IS '여행 사진3';

-- 컬럼 Comment 설정 SQL - tb_recruit_tm.created_at
COMMENT ON COLUMN tb_recruit_tm.created_at IS '등록 일자';

-- 컬럼 Comment 설정 SQL - tb_recruit_tm.closed_at
COMMENT ON COLUMN tb_recruit_tm.closed_at IS '마감일자';

-- 컬럼 Comment 설정 SQL - tb_recruit_tm.recruit_status
COMMENT ON COLUMN tb_recruit_tm.recruit_status IS '동반자찾기 상태';

-- Foreign Key 설정 SQL - tb_recruit_tm(user_email) -> tb_user(user_email)
ALTER TABLE tb_recruit_tm
    ADD CONSTRAINT FK_tb_recruit_tm_user_email_tb_user_user_email FOREIGN KEY (user_email)
        REFERENCES tb_user (user_email) ;

-- Foreign Key 삭제 SQL - tb_recruit_tm(user_email)
-- ALTER TABLE tb_recruit_tm
-- DROP CONSTRAINT FK_tb_recruit_tm_user_email_tb_user_user_email;


-- tb_category Table Create SQL
-- 테이블 생성 SQL - tb_category
CREATE TABLE tb_category
(
    region_id      NUMBER(18, 0)    NOT NULL, 
    category_no    NUMBER(18, 0)    NOT NULL, 
     PRIMARY KEY (region_id, category_no)
);

-- 테이블 Comment 설정 SQL - tb_category
COMMENT ON TABLE tb_category IS '카테고리 정보';

-- 컬럼 Comment 설정 SQL - tb_category.region_id
COMMENT ON COLUMN tb_category.region_id IS '지역 아이디';

-- 컬럼 Comment 설정 SQL - tb_category.category_no
COMMENT ON COLUMN tb_category.category_no IS '카테고리 아이디';

-- Foreign Key 설정 SQL - tb_category(region_id) -> tb_region(region_id)
ALTER TABLE tb_category
    ADD CONSTRAINT FK_tb_category_region_id_tb_region_region_id FOREIGN KEY (region_id)
        REFERENCES tb_region (region_id) ;

-- Foreign Key 삭제 SQL - tb_category(region_id)
-- ALTER TABLE tb_category
-- DROP CONSTRAINT FK_tb_category_region_id_tb_region_region_id;


-- tb_mbti Table Create SQL
-- 테이블 생성 SQL - tb_mbti
CREATE TABLE tb_mbti
(
    mbti    NUMBER(18, 0)    NOT NULL, 
     PRIMARY KEY (mbti)
);

-- 컬럼 Comment 설정 SQL - tb_mbti.mbti
COMMENT ON COLUMN tb_mbti.mbti IS 'mbti';


-- tb_travel_log Table Create SQL
-- 테이블 생성 SQL - tb_travel_log
CREATE TABLE tb_travel_log
(
    tlog_id         NUMBER(18, 0)     NOT NULL, 
    tlog_title      VARCHAR2(500)     NOT NULL, 
    tlog_content    CLOB              NOT NULL, 
    tlog_img        VARCHAR2(1000)    NOT NULL, 
    user_email      VARCHAR2(50)      NOT NULL, 
    created_at      DATE              DEFAULT SYSDATE NOT NULL, 
     PRIMARY KEY (tlog_id)
);

-- Auto Increment를 위한 Sequence 추가 SQL - tb_travel_log.tlog_id
CREATE SEQUENCE tb_travel_log_SEQ
START WITH 1
INCREMENT BY 1;

-- Auto Increment를 위한 Trigger 추가 SQL - tb_travel_log.tlog_id
CREATE OR REPLACE TRIGGER tb_travel_log_AI_TRG
BEFORE INSERT ON tb_travel_log 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT tb_travel_log_SEQ.NEXTVAL
    INTO :NEW.tlog_id
    FROM DUAL;
END;

-- DROP TRIGGER tb_travel_log_AI_TRG; 

-- DROP SEQUENCE tb_travel_log_SEQ; 

-- 테이블 Comment 설정 SQL - tb_travel_log
COMMENT ON TABLE tb_travel_log IS '여행 기록';

-- 컬럼 Comment 설정 SQL - tb_travel_log.tlog_id
COMMENT ON COLUMN tb_travel_log.tlog_id IS '기록 식별자';

-- 컬럼 Comment 설정 SQL - tb_travel_log.tlog_title
COMMENT ON COLUMN tb_travel_log.tlog_title IS '여행 제목';

-- 컬럼 Comment 설정 SQL - tb_travel_log.tlog_content
COMMENT ON COLUMN tb_travel_log.tlog_content IS '여행기록 내용';

-- 컬럼 Comment 설정 SQL - tb_travel_log.tlog_img
COMMENT ON COLUMN tb_travel_log.tlog_img IS '여행 사진';

-- 컬럼 Comment 설정 SQL - tb_travel_log.user_email
COMMENT ON COLUMN tb_travel_log.user_email IS '작성자 이메일(아이디)';

-- 컬럼 Comment 설정 SQL - tb_travel_log.created_at
COMMENT ON COLUMN tb_travel_log.created_at IS '작성 일시';

-- Foreign Key 설정 SQL - tb_travel_log(user_email) -> tb_user(user_email)
ALTER TABLE tb_travel_log
    ADD CONSTRAINT FK_tb_travel_log_user_email_tb FOREIGN KEY (user_email)
        REFERENCES tb_user (user_email) ;

-- Foreign Key 삭제 SQL - tb_travel_log(user_email)
-- ALTER TABLE tb_travel_log
-- DROP CONSTRAINT FK_tb_travel_log_user_email_tb;


-- tb_comment Table Create SQL
-- 테이블 생성 SQL - tb_comment
CREATE TABLE tb_comment
(
    cmt_id         NUMBER(18, 0)    NOT NULL, 
    recruit_id     NUMBER(18, 0)    NOT NULL, 
    cmt_content    VARCHAR2(300)    NOT NULL, 
    created_at     DATE             NOT NULL, 
    user_email     VARCHAR2(50)     NOT NULL, 
     PRIMARY KEY (cmt_id)
);

-- Auto Increment를 위한 Sequence 추가 SQL - tb_comment.cmt_id
CREATE SEQUENCE tb_comment_SEQ
START WITH 1
INCREMENT BY 1;

-- Auto Increment를 위한 Trigger 추가 SQL - tb_comment.cmt_id
CREATE OR REPLACE TRIGGER tb_comment_AI_TRG
BEFORE INSERT ON tb_comment 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT tb_comment_SEQ.NEXTVAL
    INTO :NEW.cmt_id
    FROM DUAL;
END;

-- DROP TRIGGER tb_comment_AI_TRG; 

-- DROP SEQUENCE tb_comment_SEQ; 

-- 테이블 Comment 설정 SQL - tb_comment
COMMENT ON TABLE tb_comment IS '댓글';

-- 컬럼 Comment 설정 SQL - tb_comment.cmt_id
COMMENT ON COLUMN tb_comment.cmt_id IS '댓글 아이디';

-- 컬럼 Comment 설정 SQL - tb_comment.recruit_id
COMMENT ON COLUMN tb_comment.recruit_id IS '동반자찾기 식별자';

-- 컬럼 Comment 설정 SQL - tb_comment.cmt_content
COMMENT ON COLUMN tb_comment.cmt_content IS '댓글 내용';

-- 컬럼 Comment 설정 SQL - tb_comment.created_at
COMMENT ON COLUMN tb_comment.created_at IS '댓글 작성일자';

-- 컬럼 Comment 설정 SQL - tb_comment.user_email
COMMENT ON COLUMN tb_comment.user_email IS '댓글 이메일(아이디)';

-- Foreign Key 설정 SQL - tb_comment(recruit_id) -> tb_recruit_tm(recruit_id)
ALTER TABLE tb_comment
    ADD CONSTRAINT FK_tb_comment_recruit_id_tb_recruit_tm_recruit_id FOREIGN KEY (recruit_id)
        REFERENCES tb_recruit_tm (recruit_id) ;

-- Foreign Key 삭제 SQL - tb_comment(recruit_id)
-- ALTER TABLE tb_comment
-- DROP CONSTRAINT FK_tb_comment_recruit_id_tb_recruit_tm_recruit_id;

-- Foreign Key 설정 SQL - tb_comment(user_email) -> tb_user(user_email)
ALTER TABLE tb_comment
    ADD CONSTRAINT FK_tb_comment_user_email_tb_us FOREIGN KEY (user_email)
        REFERENCES tb_user (user_email) ;

-- Foreign Key 삭제 SQL - tb_comment(user_email)
-- ALTER TABLE tb_comment
-- DROP CONSTRAINT FK_tb_comment_user_email_tb_us;


-- tb_apply Table Create SQL
-- 테이블 생성 SQL - tb_apply
CREATE TABLE tb_apply
(
    apply_id      NUMBER(18, 0)    NOT NULL, 
    user_email    VARCHAR2(50)     NOT NULL, 
    recruit_id    NUMBER(18, 0)    NOT NULL, 
    applied_at    DATE             DEFAULT SYSDATE NOT NULL, 
    choice_yn     CHAR(1)          DEFAULT 'N' NOT NULL, 
     PRIMARY KEY (apply_id)
);

-- Auto Increment를 위한 Sequence 추가 SQL - tb_apply.apply_id
CREATE SEQUENCE tb_apply_SEQ
START WITH 1
INCREMENT BY 1;

-- Auto Increment를 위한 Trigger 추가 SQL - tb_apply.apply_id
CREATE OR REPLACE TRIGGER tb_apply_AI_TRG
BEFORE INSERT ON tb_apply 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT tb_apply_SEQ.NEXTVAL
    INTO :NEW.apply_id
    FROM DUAL;
END;

-- DROP TRIGGER tb_apply_AI_TRG; 

-- DROP SEQUENCE tb_apply_SEQ; 

-- 테이블 Comment 설정 SQL - tb_apply
COMMENT ON TABLE tb_apply IS '동반자 찾기 지원자';

-- 컬럼 Comment 설정 SQL - tb_apply.apply_id
COMMENT ON COLUMN tb_apply.apply_id IS '지원 아이디';

-- 컬럼 Comment 설정 SQL - tb_apply.user_email
COMMENT ON COLUMN tb_apply.user_email IS '지원자 이메일(아이디)';

-- 컬럼 Comment 설정 SQL - tb_apply.recruit_id
COMMENT ON COLUMN tb_apply.recruit_id IS '동반자찾기 식별자';

-- 컬럼 Comment 설정 SQL - tb_apply.applied_at
COMMENT ON COLUMN tb_apply.applied_at IS '지원 날짜';

-- 컬럼 Comment 설정 SQL - tb_apply.choice_yn
COMMENT ON COLUMN tb_apply.choice_yn IS '선택 여부';

-- Foreign Key 설정 SQL - tb_apply(recruit_id) -> tb_recruit_tm(recruit_id)
ALTER TABLE tb_apply
    ADD CONSTRAINT FK_tb_apply_recruit_id_tb_recruit_tm_recruit_id FOREIGN KEY (recruit_id)
        REFERENCES tb_recruit_tm (recruit_id) ;

-- Foreign Key 삭제 SQL - tb_apply(recruit_id)
-- ALTER TABLE tb_apply
-- DROP CONSTRAINT FK_tb_apply_recruit_id_tb_recruit_tm_recruit_id;

-- Foreign Key 설정 SQL - tb_apply(user_email) -> tb_user(user_email)
ALTER TABLE tb_apply
    ADD CONSTRAINT FK_tb_apply_user_email_tb_user FOREIGN KEY (user_email)
        REFERENCES tb_user (user_email) ;

-- Foreign Key 삭제 SQL - tb_apply(user_email)
-- ALTER TABLE tb_apply
-- DROP CONSTRAINT FK_tb_apply_user_email_tb_user;


-- tb_schedule Table Create SQL
-- 테이블 생성 SQL - tb_schedule
CREATE TABLE tb_schedule
(
    schedule_id    NUMBER           NOT NULL, 
    user_email     VARCHAR2(50)     NOT NULL, 
    title          VARCHAR2(100)    NOT NULL, 
    start_date     DATE             NOT NULL, 
    end_date       DATE             NOT NULL, 
    CONSTRAINT pk_user_schedule PRIMARY KEY (schedule_id)
);

-- Auto Increment를 위한 Sequence 추가 SQL - tb_schedule.schedule_id
CREATE SEQUENCE tb_schedule_SEQ
START WITH 1
INCREMENT BY 1;

-- Auto Increment를 위한 Trigger 추가 SQL - tb_schedule.schedule_id
CREATE OR REPLACE TRIGGER tb_schedule_AI_TRG
BEFORE INSERT ON tb_schedule 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT tb_schedule_SEQ.NEXTVAL
    INTO :NEW.schedule_id
    FROM DUAL;
END;

-- DROP TRIGGER tb_schedule_AI_TRG; 

-- DROP SEQUENCE tb_schedule_SEQ; 

-- 테이블 Comment 설정 SQL - tb_schedule
COMMENT ON TABLE tb_schedule IS '일정 관리. 일정 관리';

-- 컬럼 Comment 설정 SQL - tb_schedule.schedule_id
COMMENT ON COLUMN tb_schedule.schedule_id IS '일정 식별자. 일정 식별자';

-- 컬럼 Comment 설정 SQL - tb_schedule.user_email
COMMENT ON COLUMN tb_schedule.user_email IS '회원 이메일(아이디). 회원 이메일(아이디)';

-- 컬럼 Comment 설정 SQL - tb_schedule.title
COMMENT ON COLUMN tb_schedule.title IS '일정 제목. 일정 제목';

-- 컬럼 Comment 설정 SQL - tb_schedule.start_date
COMMENT ON COLUMN tb_schedule.start_date IS '시작 날짜. 시작날짜';

-- 컬럼 Comment 설정 SQL - tb_schedule.end_date
COMMENT ON COLUMN tb_schedule.end_date IS '종료 날짜. 종료날짜';

-- Foreign Key 설정 SQL - tb_schedule(user_email) -> tb_user(user_email)
ALTER TABLE tb_schedule
    ADD CONSTRAINT fk_user_email FOREIGN KEY (user_email)
        REFERENCES tb_user (user_email) ;

-- Foreign Key 삭제 SQL - tb_schedule(user_email)
-- ALTER TABLE tb_schedule
-- DROP CONSTRAINT fk_user_email;

-- Foreign Key 설정 SQL - tb_schedule(user_email) -> tb_user(user_email)
ALTER TABLE tb_schedule
    ADD CONSTRAINT FK_tb_schedule_user_email FOREIGN KEY (user_email)
        REFERENCES tb_user (user_email) ;

-- Foreign Key 삭제 SQL - tb_schedule(user_email)
-- ALTER TABLE tb_schedule
-- DROP CONSTRAINT FK_tb_schedule_user_email;


-- tb_mbti_detail Table Create SQL
-- 테이블 생성 SQL - tb_mbti_detail
CREATE TABLE tb_mbti_detail
(
    category_no    NUMBER(18, 0)    NOT NULL, 
    mbti           VARCHAR2(4)      NOT NULL, 
     PRIMARY KEY (category_no)
);

-- 컬럼 Comment 설정 SQL - tb_mbti_detail.category_no
COMMENT ON COLUMN tb_mbti_detail.category_no IS '카테고리 아이디';

-- 컬럼 Comment 설정 SQL - tb_mbti_detail.mbti
COMMENT ON COLUMN tb_mbti_detail.mbti IS 'mbti';

-- Foreign Key 설정 SQL - tb_mbti_detail(mbti) -> tb_mbti(mbti)
ALTER TABLE tb_mbti_detail
    ADD CONSTRAINT FK_tb_mbti_detail_mbti_tb_mbti_mbti FOREIGN KEY (mbti)
        REFERENCES tb_mbti (mbti) ;

-- Foreign Key 삭제 SQL - tb_mbti_detail(mbti)
-- ALTER TABLE tb_mbti_detail
-- DROP CONSTRAINT FK_tb_mbti_detail_mbti_tb_mbti_mbti;

-- Foreign Key 설정 SQL - tb_mbti_detail(category_no) -> tb_category(category_no)
ALTER TABLE tb_mbti_detail
    ADD CONSTRAINT FK_tb_mbti_detail_category_no_tb_category_category_no FOREIGN KEY (category_no)
        REFERENCES tb_category (category_no) ;

-- Foreign Key 삭제 SQL - tb_mbti_detail(category_no)
-- ALTER TABLE tb_mbti_detail
-- DROP CONSTRAINT FK_tb_mbti_detail_category_no_tb_category_category_no;


