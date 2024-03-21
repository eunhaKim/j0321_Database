show tables;

-- 기본키(primary key) : 테이블을 대표하는 키, 중복을 허용하지 않는다. 기본키는 여러개 올 수 있다.
create table test1(
	idx int not null auto_increment primary key,
	name varchar(20) not null,
	age int default 20,
	address varchar(50)
);

desc test1;
drop table test1;
insert into test1 value (default , '홍길동', default, '서울');
insert into test1 value (default , '김말숙', 25, '청주');
insert into test1 value (1 , '소나무', 55, '제주'); -- X
select * from test1;

create table test2(
	idx int not null auto_increment primary key,
	name varchar(20) not null,
	age int default 20,
	test2Code varchar(10) not null
	/* primary key (idx, test2Code) 조합이 중복되지 않아야 한다. idx, test2Code는 중복될수도 있다 */
);

desc test2;
drop table test2;
select * from test2;
insert into test2 values (default, '소나무', 13, 'ddd');
insert into test2 values (default, '대나무', 43, 'eee');

-- UNIQUE KEY : 중복 불허를 위해 설정하는 키(PRIMARY KEY를 대신해서 중복을 불허시키고자 할때 사용한다.)
create table test3(
	idx int not null auto_increment,
	name varchar(20) not null,
	age int default 20,
	job 			varchar(10) not null,
	address 	varchar(20) not null,
	test3Code varchar(10) not null,
	primary key (idx),
	unique key(test3Code)
);



desc test3;
drop table test3;
insert into test3 values (default, '소나무', 13,'학생','서울', 'ccc');
insert into test3 values (default, '대나무', 43,'회사원','청주', 'eee');
insert into test3 values (default, '감나무', 27,'군인','대전', 'ggg');
select * from test3;



/* 외래키(Foreign key)
  하나의 테이블에서 다른 테이블의 정보를 찾기위해 연결해주는 역할을 할때 지정하는 키이다..........
  조건, 현재 테이블의 필드에 외래키로 설정하려면, 반드시 상대쪽 테이블의 해당필드는 primary key 이거나 unique key로 등록되어 있어야 한다.
  또한, 외래키로 지정하려는 필드는 상대쪽 테이블의 해당 필드속성과 같아야 한다. 
*/
create table test4(
	idx 			int not null auto_increment primary key,
	gender 		char(2)	default '남자',
	test2Idx 	int not null,
	test3Code varchar(10) not null,	
	foreign key (test2Idx) references test2 (idx),
	foreign key (test3Code) references test3 (test3Code)
);

desc test4;
drop table test4;
insert into test4 values (default, default, 1 , 'ggg');
insert into test4 values (default, default, 1 , 'ccc');
select * from test4;

-- select 핃드명 from 테이블병 where 조건식 옵션;
select *,gender from test3, test4;
select test3.*,gender from test3, test4;
select test4.idx,gender from test3, test4;
select t3.idx, t4.gender from test3 t3, test4 t4;
select t3.idx as 고유번호, t4.gender as 성별 from test3 t3, test4 t4;

select t3.*, t4.gender from test3 t3, test4 t4 where t3.test3Code = t4.test3Code;