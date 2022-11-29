
DROP TABLE BBS_COMM;
DROP TABLE BBS;

DROP TABLE SUMMERNOTE_IMAGE;
DROP TABLE LIKED;
DROP TABLE GALLERY_COMM;
DROP TABLE GALLERY;


DROP TABLE ATTACH;
DROP TABLE UPLOAD_COMM;
DROP TABLE UPLOAD;

DROP TABLE RETIRE_USERS;
DROP TABLE ACCESS_LOG;
DROP TABLE SLEEP_USERS;
DROP TABLE USERS;


CREATE TABLE USERS (
      ID   VARCHAR2(50 BYTE)      NOT NULL,
      USER_NO   NUMBER      NOT NULL ,
      PW   VARCHAR2(64 BYTE)      NOT NULL,
      NAME   VARCHAR2(20 BYTE)      NOT NULL,
      GENDER   VARCHAR2(2 BYTE)       NOT NULL,
      EMAIL   VARCHAR2(50 BYTE)      NOT NULL    UNIQUE,
      MOBILE   VARCHAR2(11 BYTE)      NOT NULL,
      BIRTHYEAR   VARCHAR2(4 BYTE)      NOT NULL,
      BIRTHDAY   VARCHAR2(4 BYTE)      NOT NULL,
      POSTCODE   VARCHAR2(5 BYTE)      NULL,
      ROAD_ADDRESS   VARCHAR2(100 BYTE)      NULL,
      JIBUN_ADDRESS   VARCHAR2(100 BYTE)      NULL,
      DETAIL_ADDRESS   VARCHAR2(100 BYTE)      NULL,
      EXTRA_ADDRESS   VARCHAR2(100 BYTE)      NULL,
      AGREE_CODE   NUMBER      NOT NULL,
      SNS_TYPE   VARCHAR2(10 BYTE)      NULL,
      JOIN_DATE   DATE      NOT NULL,
      PW_MODIFY_DATE   DATE      NULL,
      INFO_MODIFY_DATE   DATE      NULL,
      SESSION_ID   VARCHAR2(32 BYTE)      NULL,
      SESSION_LIMIT_DATE   DATE      NULL,
      USER_LEVEL   NUMBER      NOT NULL,
      POINT   NUMBER   DEFAULT 0   NOT NULL,
      CONSTRAINT PK_ID PRIMARY KEY(ID)
);


CREATE TABLE UPLOAD (
      UPLOAD_NO   NUMBER      NOT NULL,
      ID   VARCHAR2(50 BYTE),
      UPLOAD_TITLE   VARCHAR2(100 BYTE)      NOT NULL,
      UPLOAD_CONTENT   VARCHAR2(300 BYTE)      NULL,
      CREATE_DATE   DATE      NULL,
      MODIFY_DATE   DATE      NULL,
      HIT   NUMBER   DEFAULT 0   NOT NULL,
      UPLOAD_USER_IP   VARCHAR2(30 BYTE)      NULL,
      CONSTRAINT PK_UPLOAD_NO PRIMARY KEY(UPLOAD_NO),
      CONSTRAINT FK_UPLOAD_ID FOREIGN KEY(ID) REFERENCES USERS(ID) ON DELETE SET NULL
);


CREATE TABLE BBS (
      BBS_NO   NUMBER      NOT NULL,
      ID   VARCHAR2(50 BYTE),
      BBS_TITLE   VARCHAR2(100 BYTE)      NOT NULL,
      BBS_CONTENT   VARCHAR2(4000 BYTE)      NOT NULL,
      BBS_IP   VARCHAR2(30 BYTE)      NOT NULL,
      BBS_CREATE_DATE   DATE      NOT NULL,
      BBS_HIT NUMBER DEFAULT 0 NOT NULL,
      CONSTRAINT PK_BBS_NO PRIMARY KEY(BBS_NO),
      CONSTRAINT FK_BBS_ID FOREIGN KEY(ID) REFERENCES USERS(ID) ON DELETE SET NULL
);


CREATE TABLE ATTACH (
      ATTACH_NO   NUMBER      NOT NULL,
      UPLOAD_NO   NUMBER      NOT NULL,
      ID   VARCHAR2(50 BYTE),
      PATH   VARCHAR2(300 BYTE)      NULL,
      ORIGIN   VARCHAR2(300 BYTE)      NULL,
      FILESYSTEM   VARCHAR2(40 BYTE)      NULL,
      DOWNLOAD_CNT   NUMBER      NULL,
      CONSTRAINT PK_ATTACH_NO PRIMARY KEY(ATTACH_NO),
      CONSTRAINT FK_ATTACH_ID FOREIGN KEY(ID) REFERENCES USERS(ID)  ON DELETE SET NULL,
      CONSTRAINT FK_ATTACH_UPLOAD_NO FOREIGN KEY(UPLOAD_NO) REFERENCES UPLOAD(UPLOAD_NO)ON DELETE CASCADE
);


CREATE TABLE GALLERY (
   	GALLERY_NO   NUMBER      NOT NULL,
   	GALLERY_TITLE   VARCHAR2(100 BYTE)      NOT NULL,
   	GALLERY_CONTENT   VARCHAR2(4000 BYTE)      NULL,
   	CREATE_DATE  DATE      NULL,
   	MODIFY_DATE   DATE      NULL,
   	HIT   NUMBER   DEFAULT 0   NOT NULL,
   	WRITER_IP   VARCHAR2(30 BYTE)      NULL,
   	ID   VARCHAR2(50 BYTE),
    CONSTRAINT PK_GALLERY_NO PRIMARY KEY(GALLERY_NO),
    CONSTRAINT FK_GALLERY_ID FOREIGN KEY(ID) REFERENCES USERS(ID) ON DELETE SET NULL
);


CREATE TABLE BBS_COMM (
      BBS_COMM_NO   NUMBER      NOT NULL,
      BBS_NO   NUMBER      NOT NULL,
      ID   VARCHAR2(50 BYTE),
      COMM_CONTENT   VARCHAR2(1000 BYTE)      NOT NULL,
      COMM_CREATE_DATE   DATE      NOT NULL,
      STATE   NUMBER(1)      NOT NULL,
      DEPTH   NUMBER(2)      NOT NULL,
      GROUP_NO   NUMBER      NOT NULL,
      CONSTRAINT PK_BBS_COMM_NO PRIMARY KEY(BBS_COMM_NO),
      CONSTRAINT FK_BBS_COMM_ID FOREIGN KEY(ID) REFERENCES USERS(ID) ON DELETE SET NULL,
      CONSTRAINT FK_BBS_COMM_BBS_NO FOREIGN KEY(BBS_NO) REFERENCES BBS(BBS_NO) ON DELETE CASCADE
);


CREATE TABLE RETIRE_USERS (
      USER_NO   NUMBER      NOT NULL,
      ID   VARCHAR2(50 BYTE)   NOT NULL    UNIQUE,
      JOIN_DATE   DATE      NULL,
      RETIRE_DATE   DATE      NULL
);


CREATE TABLE SLEEP_USERS (
      USER_NO   NUMBER      NOT NULL,
      ID VARCHAR2(30 BYTE)       NOT NULL    UNIQUE,
      PW   VARCHAR2(64 BYTE)      NOT NULL,
      NAME   VARCHAR2(20 BYTE)      NOT NULL,
      GENDER   VARCHAR2(2 BYTE)       NOT NULL,
      EMAIL   VARCHAR2(50 BYTE)      NOT NULL    UNIQUE,
      MOBILE   VARCHAR2(11 BYTE)      NOT NULL,
      BIRTHYEAR   VARCHAR2(4 BYTE)      NOT NULL,
      BIRTHDAY   VARCHAR2(4 BYTE)      NOT NULL,
      POSTCODE   VARCHAR2(5 BYTE)      NULL,
      ROAD_ADDRESS   VARCHAR2(100 BYTE)      NULL,
      JIBUN_ADDRESS   VARCHAR2(100 BYTE)      NULL,
      DETAIL_ADDRESS   VARCHAR2(100 BYTE)      NULL,
      EXTRA_ADDRESS   VARCHAR2(100 BYTE)      NULL,
      AGREE_CODE   NUMBER      NOT NULL,
      SNS_TYPE   VARCHAR2(10 BYTE)      NULL,
      JOIN_DATE   DATE      NOT NULL,
      LAST_LOGIN_DATE   DATE      NULL,
      SLEEP_DATE   DATE      NULL,
      USER_LEVEL   NUMBER      NOT NULL,
      POINT   NUMBER   DEFAULT 0   NOT NULL,
      CONSTRAINT PK_USER_NO PRIMARY KEY(USER_NO)
);


CREATE TABLE UPLOAD_COMM (
      UPLOAD_COMM_NO   NUMBER              NOT NULL,
      UPLOAD_NO        NUMBER              NOT NULL,
      ID   VARCHAR2(50 BYTE),
      COMM_CONTENT     VARCHAR2(3000 BYTE) NOT NULL,
      COMM_DATE        DATE                NOT NULL,
      STATE            NUMBER              NOT NULL,      -- 정상 1, 삭제 -1
      DEPTH            NUMBER              NOT NULL, 
      GROUP_NO         NUMBER              NOT NULL,
      CONSTRAINT PK_UPLOAD_COMM_NO PRIMARY KEY(UPLOAD_COMM_NO),
      CONSTRAINT FK_UPLOAD_COMM_ID FOREIGN KEY(ID) REFERENCES USERS(ID) ON DELETE SET NULL,
      CONSTRAINT FK_UPLOAD_COMM_UPLOAD_NO FOREIGN KEY(UPLOAD_NO) REFERENCES UPLOAD(UPLOAD_NO) ON DELETE CASCADE
);


CREATE TABLE ACCESS_LOG (
      ACCESS_LOG_NO   NUMBER      NOT NULL,
      ID   VARCHAR2(50 BYTE)      NOT NULL    UNIQUE,
      LAST_LOGIN_DATE   DATE      NULL,
      CONSTRAINT PK_ACCESS_LOG_NO PRIMARY KEY(ACCESS_LOG_NO),
      CONSTRAINT FK_ACCESS_LOG_ID FOREIGN KEY(ID) REFERENCES USERS(ID) ON DELETE CASCADE
);


CREATE TABLE LIKED (
      GALLERY_NO   NUMBER      NOT NULL,
      IS_LIKED   NUMBER(1)   DEFAULT 0   NOT NULL,
      ID   VARCHAR2(50 BYTE),
      CONSTRAINT FK_LIKED_ID FOREIGN KEY(ID) REFERENCES USERS(ID)  ON DELETE SET NULL,
      CONSTRAINT FK_LIKED_GALLERY_NO FOREIGN KEY(GALLERY_NO) REFERENCES GALLERY(GALLERY_NO) ON DELETE CASCADE
);


CREATE TABLE GALLERY_COMM (
    GALLERY_COMM_NO   NUMBER      NOT NULL,
    GALLERY_NO   NUMBER      NOT NULL,
    ID   VARCHAR2(50 BYTE),
    COMM_CONTENT   VARCHAR2(3000 BYTE)      NULL,
    COMM_STATE NUMBER NOT NULL,
    COMM_DEPTH NUMBER NOT NULL,
    COMM_GROUP_NO NUMBER NOT NULL,
    COMM_DATE   DATE      NOT NULL,
    CONSTRAINT PK_GALLERY_COMM_NO PRIMARY KEY(GALLERY_COMM_NO),
    CONSTRAINT FK_GALLERY_COMM_GALLERY_NO FOREIGN KEY(GALLERY_NO) REFERENCES GALLERY(GALLERY_NO) ON DELETE CASCADE,
    CONSTRAINT FK_GALLERY_COMM_ID FOREIGN KEY(ID) REFERENCES USERS(ID)  ON DELETE SET NULL
);


CREATE TABLE SUMMERNOTE_IMAGE
(
    GALLERY_NO NUMBER,
    FILESYSTEM VARCHAR2(40 BYTE),
    CONSTRAINT FK_SUMMERNOTE_BLOG FOREIGN KEY(GALLERY_NO) REFERENCES GALLERY(GALLERY_NO) ON DELETE CASCADE
);

-- SEQUENCE

-- USERS SEQUENCE
DROP SEQUENCE USERS_SEQ;
DROP SEQUENCE ACCESS_LOG_SEQ;
DROP SEQUENCE SLEEP_USER_SEQ;
DROP SEQUENCE RETIRE_USER_SEQ;
CREATE SEQUENCE USERS_SEQ NOCACHE;
CREATE SEQUENCE ACCESS_LOG_SEQ NOCACHE;
CREATE SEQUENCE SLEEP_USER_SEQ NOCACHE;
CREATE SEQUENCE RETIRE_USER_SEQ NOCACHE;

-- GALLERY SEQUENCE
DROP SEQUENCE GALLERY_SEQ;
DROP SEQUENCE GALLERY_COMM_SEQ;
CREATE SEQUENCE GALLERY_SEQ NOCACHE;
CREATE SEQUENCE GALLERY_COMM_SEQ NOCACHE;

-- BBS SEQUENCE
DROP SEQUENCE BBS_SEQ;
DROP SEQUENCE BBS_COMM_SEQ;
CREATE SEQUENCE BBS_COMM_SEQ NOCACHE;
CREATE SEQUENCE BBS_SEQ NOCACHE;

-- UPLOAD SEQUENCE
DROP SEQUENCE UPLOAD_SEQ;
DROP SEQUENCE ATTACH_SEQ;
DROP SEQUENCE UPLOAD_COMM_SEQ;
CREATE SEQUENCE UPLOAD_SEQ NOCACHE;
CREATE SEQUENCE ATTACH_SEQ NOCACHE;
CREATE SEQUENCE UPLOAD_COMM_SEQ NOCACHE;

-- ADMIN

INSERT INTO USERS
    (ID, USER_NO, PW, NAME, GENDER, EMAIL, MOBILE, BIRTHYEAR, BIRTHDAY, POSTCODE, ROAD_ADDRESS, JIBUN_ADDRESS, DETAIL_ADDRESS, EXTRA_ADDRESS, AGREE_CODE, SNS_TYPE, JOIN_DATE, PW_MODIFY_DATE, INFO_MODIFY_DATE, SESSION_ID, SESSION_LIMIT_DATE, USER_LEVEL, POINT)
VALUES
    ('admin', USERS_SEQ.NEXTVAL,'0FFE1ABD1A08215353C233D6E009613E95EEC4253832A761AF28FF37AC5A150C', 'ADMIN', 'N', 'admin@gmail.com', '01011111111', '1958', '0101', '11111', 'ROAD1', 'JIBUN1', 'DETAIL1','EXTRA1', 0, NULL, TO_DATE('20221111', 'YYYYMMDD'), NULL, NULL, NULL, NULL, 100, 0);
INSERT INTO USERS
    (ID, USER_NO, PW, NAME, GENDER, EMAIL, MOBILE, BIRTHYEAR, BIRTHDAY, POSTCODE, ROAD_ADDRESS, JIBUN_ADDRESS, DETAIL_ADDRESS, EXTRA_ADDRESS, AGREE_CODE, SNS_TYPE, JOIN_DATE, PW_MODIFY_DATE, INFO_MODIFY_DATE, SESSION_ID, SESSION_LIMIT_DATE, USER_LEVEL, POINT)
VALUES
    ('user01', USERS_SEQ.NEXTVAL,'0FFE1ABD1A08215353C233D6E009613E95EEC4253832A761AF28FF37AC5A150C', '이정행', 'M', 'user1@gmail.com', '01011112222', '1978', '0407', '32453', 'ROAD234', 'JIBUN113', 'DETAIL123','EXTRA165', 0, NULL, TO_DATE('20221123', 'YYYYMMDD'), NULL, NULL, NULL, NULL, 3, 0);
INSERT INTO USERS
    (ID, USER_NO, PW, NAME, GENDER, EMAIL, MOBILE, BIRTHYEAR, BIRTHDAY, POSTCODE, ROAD_ADDRESS, JIBUN_ADDRESS, DETAIL_ADDRESS, EXTRA_ADDRESS, AGREE_CODE, SNS_TYPE, JOIN_DATE, PW_MODIFY_DATE, INFO_MODIFY_DATE, SESSION_ID, SESSION_LIMIT_DATE, USER_LEVEL, POINT)
VALUES
    ('user02', USERS_SEQ.NEXTVAL,'EDEE29F882543B956620B26D0EE0E7E950399B1C4222F5DE05E06425B4C995E9', '신준호', 'F', 'user2@gmail.com', '01022222222', '1998', '0707', '46723', 'ROAD323', 'JIBUN134', 'DETAIL323','EXTRA857', 0, NULL, TO_DATE('20221124', 'YYYYMMDD'), NULL, NULL, NULL, NULL, 5, 0);
INSERT INTO USERS
    (ID, USER_NO, PW, NAME, GENDER, EMAIL, MOBILE, BIRTHYEAR, BIRTHDAY, POSTCODE, ROAD_ADDRESS, JIBUN_ADDRESS, DETAIL_ADDRESS, EXTRA_ADDRESS, AGREE_CODE, SNS_TYPE, JOIN_DATE, PW_MODIFY_DATE, INFO_MODIFY_DATE, SESSION_ID, SESSION_LIMIT_DATE, USER_LEVEL, POINT)
VALUES
    ('user03', USERS_SEQ.NEXTVAL,'318AEE3FED8C9D040D35A7FC1FA776FB31303833AA2DE885354DDF3D44D8FB69', '김나영', 'M', 'user3@gmail.com', '01033333333', '1936', '0207', '23453', 'ROAD824', 'JIBUN238', 'DETAIL156','EXTRA255', 0, NULL, TO_DATE('20221124', 'YYYYMMDD'), NULL, NULL, NULL, NULL, 7, 0);
INSERT INTO USERS
    (ID, USER_NO, PW, NAME, GENDER, EMAIL, MOBILE, BIRTHYEAR, BIRTHDAY, POSTCODE, ROAD_ADDRESS, JIBUN_ADDRESS, DETAIL_ADDRESS, EXTRA_ADDRESS, AGREE_CODE, SNS_TYPE, JOIN_DATE, PW_MODIFY_DATE, INFO_MODIFY_DATE, SESSION_ID, SESSION_LIMIT_DATE, USER_LEVEL, POINT)
VALUES
    ('user04', USERS_SEQ.NEXTVAL,'318AEE3FED8C9D040D35A7FC1FA776FB31303833AA2DE885354DDF3D44D8FB69', '박지원', 'F', 'user4@gmail.com', '01044444444', '1989', '1007', '34573', 'ROAD267', 'JIBUN568', 'DETAIL9456','EXTRA355', 0, NULL, TO_DATE('20221124', 'YYYYMMDD'), NULL, NULL, NULL, NULL, 2, 0);
COMMIT;