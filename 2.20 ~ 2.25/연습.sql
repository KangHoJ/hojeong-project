desc mysql.user; #.은 테이블을 접근가능(user라는 table안에 field들 볼 수 있음)
show columns from mysql.user;

show full columns from mysql.user; 

select Host , User from mysql.user;  # mysql안에 user,host 테이블 확인

create user 'test'@'localhost'identified by '1234'; 
# host 테이블에 localhost(접근주소)추가,user테이블에 test이고 password 1234 인 테이블 만듬

create user 'anywhere'@'%'identified by '1234'; 
#어디서든 접속가능한 사용자를 만듬
select User, host FROM mysql.user;

create user 'test2'@'192.168.0.%'identified by '1234';  
# 192.168.0 에만 접속가능한 사용자
select user,host from mysql.user; 

create or replace user 'test'@'localhost' identified by '1234'; 
# 이미 존재하면 기존 삭제하고 다시 만듬 대체 하고싶을떄
select user,host from mysql.user;

create user if not exists 'test'@'localhost' identified by '1234';
# 존재하지 않을떄만 넣겠다
select user,host from mysql.user;

rename user 'test2'@'192.168.0.%' to 'test3'@'%'; 
# test2@192.168.0 을 test3@% 로 번경한다.
select user,host from mysql.user;

SET PASSWORD FOR 'test3'@'%' = PASSWORD( '12345' );
# 'test3'@'%' 비밀번호를 12345로 변경


drop user 'test3'@'%';  
# 'test3'@'%' 사용자를 삭제함
select user,host from mysql.user;

drop user if exists'anywhere'@'%';
# 'anywhere'@'%' 사용자를 삭제함(존재할 경우에만 삭제)

############# 변환 #######################
create database test;


grant all privileges on test.* tO'test'@'localhost' ;
flush privileges;
show grants for 'test'@'localhost' ;
# test라는 유저에게 test DB 전체 권한을 부여

revoke all on test.* from'test'@'localhost';
flush privileges;
show grants for 'test'@'localhost';
# test라는 유저가 test DB 에 관한 권한 모두 제거 

##########------------------------------------#########3333

create database `test.test`;

drop database `test.test`;

create database python;
USE python; # 앞으로 python 데이터 베이스 안에만 찾을거다 (범위 축소)

create Table table1(column1 varchar(100));
# 이름은 column1을열로 가지는 table1을 만들었는데 크기 100

select database();    # 현재 사용중인 데이터베이스 확인
show tables;          # 현재 사용중인 데이터베이스중 어떤 테이블이 있는지 조회

rename Table table1 To table2; # table1 -> table2 이름 변경
show tables;                   # 조회

drop Table table2;     # table2 삭제 


######################## 테이블 디테일 ########################
CREATE TABLE test_table (
test_column1 INT,
test_column2 INT,
test_column3 INT
);
DESC test_table;         # 테이블 조회


alter Table test_table
add (
test_column5 int,
test_column6 int,
test_column7 int
);   # columns4 추가
DESC test_table;         # 조회

alter Table test_table
drop test_column1;
desc test_table;


alter Table test_table
modify test_column7 int
first;  # column7 을 가장 앞으로 보내준다 
desc test_table;


alter Table test_table
modify test_column7 int
after test_column6;  # column7 을 column6 뒤로 보내준다 
desc test_table;

alter Table test_table
change test_column2 test_column0 int ;  #colum2 이름을 column0으로 바꾼다
desc test_table;


ALTER TABLE test_table
CHANGE test_column0 test_column0 VARCHAR(10); # column 타입을 변경 
desc test_table;


alter table test_table
change test_column0 test_column2 int;  # 이름 , 타입 둘다 변경 
desc test_table;











