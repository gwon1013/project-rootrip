insert into spot values 
	(spot_seq.nextval,
	null,
	'곤지암리조트',
	'경기 광주시 도척면 도웅리 534',
	'경기 광주시 도척면 도척윗로 278',
	'1661-8787',
	37.3380625,
	127.2941562,
	'곤지암리조트스키장',
	401,
	915);
insert into spot values 
	(spot_seq.nextval,
	null,
	'지산 포레스트 리조트',
	'경기 이천시 마장면 해월리 산 28-7',
	'경기 이천시 마장면 지산로267',
	'031-644-1200',
	37.3380625,
	127.2941562,
	'지산 포레스트리조트 스키장',
	401,
	921);
insert into spot values 
	(spot_seq.nextval,
	null,
	'용평 리조트',
	'강원특별자치도 평창군 대관령면 용산리 130',
	'강원 평창군 대관령면 올림픽로 715',
	'033-335-5757',
	37.3380625,
	127.2941562,
	'용평 리조트스키장',
	401,
	1011);
insert into spot values 
	(spot_seq.nextval,
	null,
	'휘닉스 평창 스노우파크',
	'강원특별자치도 평창군 봉평면 면온리 1095-1',
	'강원 평창군 봉평면 태기로 174',
	'1588-2828',
	37.3380625,
	127.2941562,
	'휘닉스 스노우파크',
	401,
	1011);
	
insert into spot values 
	(spot_seq.nextval,
	null,
	'곤지암리트',
	'경기 광주시 도척면 웅리 534',
	'경기 광주시 도척면 척윗로 278',
	'1661-8787',
	37.3380625,
	127.2941562,
	'곤지암리조트스키',
	402,
	100);
insert into spot values 
	(spot_seq.nextval,
	null,
	'지산 포레스리조트',
	'경기 이천시 마장 해월리 산 28-7',
	'경기 이천시 마장 지산로267',
	'031-644-1200',
	37.3380625,
	127.2941562,
	'지산 포스트리조트 스키장',
	402,
	1310);
	
insert into spot values 
	(spot_seq.nextval,
	null,
	'용평 리트',
	'강원특별자치도 평군 대관령면 용산리 130',
	'강원 평창군 대관면 올림픽로 715',
	'033-335-5757',
	37.3380625,
	127.2941562,
	'용평 리트스키장',
	403,
	300);
insert into spot values 
	(spot_seq.nextval,
	null,
	'휘닉스 평 스노우파크',
	'강원특별치도 평창군 봉평면 면온리 1095-1',
	'강원 평창군봉평면 태기로 174',
	'1588-2828',
	37.3380625,
	127.2941562,
	'휘닉스 스우파크',
	403,
	1001);

select * from spot;

select l_no from spot where c_no = 401 group by l_no;

select c_no from spot where l_no = 1011 and (c_no < 400) group by c_no order by c_no;

select * from CATEGORY

select * from LOCATION

select * from SPOT