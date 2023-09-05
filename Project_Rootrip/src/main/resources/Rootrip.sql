CREATE TABLE USERS (
	u_mail	varchar2(50 char)		NOT NULL,
	u_pw	varchar2(64 char)		NOT NULL,
	u_nickname	varchar2(20 char)		NOT NULL,
	u_profile	varchar2(100 char)		NULL,
	u_type	number(1)		NOT NULL
);

COMMENT ON COLUMN USERS.u_mail IS 'id 대용으로 사용할 이메일';

COMMENT ON COLUMN USERS.u_pw IS 'Password';

COMMENT ON COLUMN USERS.u_nickname IS '회원 닉네임';

COMMENT ON COLUMN USERS.u_profile IS '사용자 프로필 사진';

COMMENT ON COLUMN USERS.u_type IS '사용자의 종류
(일반 유저 : 0,
관리자 : 1)';

CREATE TABLE CATEGORY (
	c_no	number(3)		NOT NULL,
	c_name	varchar2(20char)		NOT NULL
);

COMMENT ON COLUMN CATEGORY.c_no IS '장소의 분류 별 
고유 번호';

COMMENT ON COLUMN CATEGORY.c_name IS '해당 번호의 카테고리 이름';

CREATE TABLE SPOT (
	s_no	number(10)		NOT NULL,
	s_photo	varchar2(200 char)		NULL,
	s_name	varchar2(50 char)		NOT NULL,
	s_addr_jibun	varchar2(50 char)		NULL,
	s_addr_road	varchar2(50 char)		NULL,
	s_tel	varchar2(14char)		NULL,
	s_lat	number(9, 7)		NOT NULL,
	s_lon	number(10, 7)		NOT NULL,
	s_comment	varchar2(500 char)		NULL,
	c_no	number(3)		NOT NULL,
	l_no	number(4)		NOT NULL
);

COMMENT ON COLUMN SPOT.s_no IS '각 장소별 고유 번호';

COMMENT ON COLUMN SPOT.s_photo IS '장소에 대한 사진';

COMMENT ON COLUMN SPOT.s_name IS '장소의 이름';

COMMENT ON COLUMN SPOT.s_addr_jibun IS '장소의  지번 주소';

COMMENT ON COLUMN SPOT.s_addr_road IS '장소의 도로명 주소';

COMMENT ON COLUMN SPOT.s_tel IS '장소의 전화번호';

COMMENT ON COLUMN SPOT.s_lat IS '장소의 위도';

COMMENT ON COLUMN SPOT.s_lon IS '장소의 경도';

COMMENT ON COLUMN SPOT.s_comment IS '장소에 대한 설명';

COMMENT ON COLUMN SPOT.c_no IS '장소의 분류 별 
고유 번호';

COMMENT ON COLUMN SPOT.l_no IS '지역별 고유 번호';

CREATE TABLE LOCATION (
	l_no	number(4)		NOT NULL,
	l_name	varchar2(10char)		NOT NULL,
	l_photo	varchar2(2200char)		NULL,
	l_lat	number(9, 7)		NOT NULL,
	l_lon	number(10, 7)		NOT NULL
);

COMMENT ON COLUMN LOCATION.l_no IS '지역별 고유 번호';

COMMENT ON COLUMN LOCATION.l_name IS '지역의 이름';

COMMENT ON COLUMN LOCATION.l_photo IS '지역에 대한 사진';

COMMENT ON COLUMN LOCATION.l_lat IS '지역의 위도';

COMMENT ON COLUMN LOCATION.l_lon IS '지역의 경도';

CREATE TABLE COURSE (
	c_no	number(10)		NOT NULL,
	l_no	number(3)		NOT NULL,
	c_name	varchar2(10 char)		NOT NULL,
	c_days	number(2)		NOT NULL,
	c_comment	varchar2(500char)		NULL
);

COMMENT ON COLUMN COURSE.c_no IS 'DB에 저장될 코스 별 고유 번호';

COMMENT ON COLUMN COURSE.l_no IS '지역별 고유 번호';

COMMENT ON COLUMN COURSE.c_name IS '코스의 이름';

COMMENT ON COLUMN COURSE.c_days IS '코스의 기간';

COMMENT ON COLUMN COURSE.c_comment IS '코스에 대한 메모';

CREATE TABLE COURSE_DETAIL (
	c_date	date		NOT NULL,
	c_d_no	number(3)		NOT NULL,
	c_no	number(10)		NOT NULL,
	s_no	number(10)		NOT NULL
);

COMMENT ON COLUMN COURSE_DETAIL.c_date IS '해당 장소를 방문하는 날짜';

COMMENT ON COLUMN COURSE_DETAIL.c_d_no IS '해당 일정을 방문하는 순서';

COMMENT ON COLUMN COURSE_DETAIL.c_no IS 'DB에 저장될 코스 별 고유 번호';

COMMENT ON COLUMN COURSE_DETAIL.s_no IS '각 장소별 고유 번호';

CREATE TABLE FESTIVAL (
	s_no	number(10)		NOT NULL,
	f_s_date	date		NOT NULL,
	f_e_date	date		NOT NULL
);

COMMENT ON COLUMN FESTIVAL.s_no IS '각 장소별 고유 번호';

COMMENT ON COLUMN FESTIVAL.f_s_date IS '지역축제 시작일자';

COMMENT ON COLUMN FESTIVAL.f_e_date IS '지역 축제 종료일자';

CREATE TABLE MARKET (
	s_no	number(10)		NOT NULL,
	m_sort	number(1)		NOT NULL,
	m_day	number(4)		NULL
);

COMMENT ON COLUMN MARKET.s_no IS '각 장소별 고유 번호';

COMMENT ON COLUMN MARKET.m_sort IS '0 : 상설시장
1: 정기시장
2 : 상설 + 정기 시장';

COMMENT ON COLUMN MARKET.m_day IS '시장의 장날
16
27
등의 숫자가 들어감';

CREATE TABLE FOLLOW (
	from_mail	varchar2(50char)		NOT NULL,
	to_mail	varchar2(50char)		NOT NULL
);

COMMENT ON COLUMN FOLLOW.from_mail IS '팔로우를 한 사용자 이메일';

COMMENT ON COLUMN FOLLOW.to_mail IS '팔로우 당한 사용자 이메일';

CREATE TABLE CATE_BY_LOC (
	c_no	number(3)		NOT NULL,
	l_no	number(4)		NOT NULL
);

COMMENT ON COLUMN CATE_BY_LOC.c_no IS '장소의 분류 별 
고유 번호';

COMMENT ON COLUMN CATE_BY_LOC.l_no IS '지역별 고유 번호';

CREATE TABLE TOUR (
	s_no	number(10)		NOT NULL
);

COMMENT ON COLUMN TOUR.s_no IS '각 장소별 고유 번호';

CREATE TABLE WELLNESS (
	s_no	number(10)		NOT NULL
);

COMMENT ON COLUMN WELLNESS.s_no IS '각 장소별 고유 번호';

CREATE TABLE RESTAURANT (
	s_no	number(10)		NOT NULL
);

COMMENT ON COLUMN RESTAURANT.s_no IS '각 장소별 고유 번호';

CREATE TABLE ACCOMMODATION (
	s_no	number(10)		NOT NULL,
	a_price	number(10)		NULL
);

COMMENT ON COLUMN ACCOMMODATION.s_no IS '각 장소별 고유 번호';

COMMENT ON COLUMN ACCOMMODATION.a_price IS '숙소의 최저가';

CREATE TABLE COURSE_USER (
	c_no	number(10)		NOT NULL,
	u_mail	varchar2(50char)		NOT NULL
);

COMMENT ON COLUMN COURSE_USER.c_no IS 'DB에 저장될 코스 별 고유 번호';

COMMENT ON COLUMN COURSE_USER.u_mail IS 'id 대용으로 사용할 이메일';

CREATE TABLE ACTIVITY (
	s_no	number(10)		NOT NULL
);

COMMENT ON COLUMN ACTIVITY.s_no IS '각 장소별 고유 번호';

ALTER TABLE USERS ADD CONSTRAINT PK_USERS PRIMARY KEY (
	u_mail
);

ALTER TABLE CATEGORY ADD CONSTRAINT PK_CATEGORY PRIMARY KEY (
	c_no
);

ALTER TABLE SPOT ADD CONSTRAINT PK_SPOT PRIMARY KEY (
	s_no
);

ALTER TABLE LOCATION ADD CONSTRAINT PK_LOCATION PRIMARY KEY (
	l_no
);

ALTER TABLE COURSE ADD CONSTRAINT PK_COURSE PRIMARY KEY (
	c_no
);

ALTER TABLE FESTIVAL ADD CONSTRAINT PK_FESTIVAL PRIMARY KEY (
	s_no
);

ALTER TABLE MARKET ADD CONSTRAINT PK_MARKET PRIMARY KEY (
	s_no
);

ALTER TABLE TOUR ADD CONSTRAINT PK_TOUR PRIMARY KEY (
	s_no
);

ALTER TABLE WELLNESS ADD CONSTRAINT PK_WELLNESS PRIMARY KEY (
	s_no
);

ALTER TABLE RESTAURANT ADD CONSTRAINT PK_RESTAURANT PRIMARY KEY (
	s_no
);

ALTER TABLE ACCOMMODATION ADD CONSTRAINT PK_ACCOMMODATION PRIMARY KEY (
	s_no
);

ALTER TABLE ACTIVITY ADD CONSTRAINT PK_ACTIVITY PRIMARY KEY (
	s_no
);

ALTER TABLE FESTIVAL ADD CONSTRAINT FK_SPOT_TO_FESTIVAL_1 FOREIGN KEY (
	s_no
)
REFERENCES SPOT (
	s_no
);

ALTER TABLE MARKET ADD CONSTRAINT FK_SPOT_TO_MARKET_1 FOREIGN KEY (
	s_no
)
REFERENCES SPOT (
	s_no
);

ALTER TABLE TOUR ADD CONSTRAINT FK_SPOT_TO_TOUR_1 FOREIGN KEY (
	s_no
)
REFERENCES SPOT (
	s_no
);

ALTER TABLE WELLNESS ADD CONSTRAINT FK_SPOT_TO_WELLNESS_1 FOREIGN KEY (
	s_no
)
REFERENCES SPOT (
	s_no
);

ALTER TABLE RESTAURANT ADD CONSTRAINT FK_SPOT_TO_RESTAURANT_1 FOREIGN KEY (
	s_no
)
REFERENCES SPOT (
	s_no
);

ALTER TABLE ACCOMMODATION ADD CONSTRAINT FK_SPOT_TO_ACCOMMODATION_1 FOREIGN KEY (
	s_no
)
REFERENCES SPOT (
	s_no
);

ALTER TABLE ACTIVITY ADD CONSTRAINT FK_SPOT_TO_ACTIVITY_1 FOREIGN KEY (
	s_no
)
REFERENCES SPOT (
	s_no
);

