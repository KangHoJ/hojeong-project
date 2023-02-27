desc mysql.user; #    .은 테이블을 접근가능(user라는 테이블안에 field들 볼 수 있음)
show columns from mysql.user;        # my sql DB의 user 테이블 columns 확인
show full columns from mysql.user;   # my sql DB의 user 테이블 모든 columns 확인 
select user , host from mysql.user;  # my sql DB user,host columns 확인

#---------------------------------DDL->create(생성)----------------------------------------------
create user 'test'@'localhost'identified by '1234'; 
# host 열에 localhost(접근주소)추가하고,user열에 test추가하고 password 1234 인 테이블 만듬
create user 'anywhere'@'%'identified by '1234'; 
# 어디서든 접속가능한 사용자를 만듬
create user 'test2'@'192.168.0.%'identified by '1234';  
# 192.168.0 에만 접속가능한 사용자

create or replace user 'test'@'localhost' identified by '1234'; 
# 이미 존재하면 기존것을 삭제하고 다시 만듬 
create user if not exists 'test'@'localhost' identified by '1234';
# 존재하지 않을떄만 넣겠다


#-----------------------------------DDL->변경,삭제----------------------------------------------
rename user 'test2'@'192.168.0.%' to 'test3'@'%'; 
# test2@192.168.0 을 test3@% 로 번경한다.
SET PASSWORD FOR 'test3'@'%' = PASSWORD( '12345' );
# 'test3'@'%' 비밀번호를 12345로 변경

drop user 'test3'@'%';  
# 'test3'@'%' 사용자를 삭제함
drop user if exists'anywhere'@'%';
# 'anywhere'@'%' 사용자를 삭제함(존재할 경우에만 삭제)

#-----------------------------------DCL-> 권한-----------------------------------------------
grant all privileges on test.* tO'test'@'localhost' ;
flush privileges;
show grants for 'test'@'localhost' ;
# test라는 user에게 test DB 전체 권한을 부여

revoke all on test.* from'test'@'localhost';
flush privileges;
show grants for 'test'@'localhost';
# test라는 유저가 test DB 에 관한 권한 모두 제거 

#----------------------------------------DML -----------------------------------------------------
show databases;                        # DB 조회
create database `test.test`;           # DB 생성
drop database `test.test`;             # DB 삭제

create database python;                # python DB 생성
USE python;                            # 앞으로 python DB 안에만 찾을거다 (범위 축소)
select database();                     # 현재 사용중인 데이터베이스 확인



#----------------테이블 조작(생성,삭제,조회)-----------------------------
show tables;                           # 현재 사용중인 데이터베이스중 어떤 테이블이 있는지 조회
create Table table1(column1 varchar(100));
# 이름은 column1을열로 가지는 table1을 만들기 크기는 100
rename table table1 To table2;         # table1 -> table2 이름 변경
drop Table table2;                     # table2 삭제 


CREATE TABLE test_table (           
test_column1 INT,
test_column2 INT,
test_column3 INT
);                                     #column1 , column2 , column3 필드열을 가지는 test_table 만듬
DESC test_table;                       # test_table 테이블 필드 조회

alter Table test_table              
add (
test_column5 int,
test_column6 int,
test_column7 int
);   							       # columns5,6,7 추가   					

alter Table test_table               
drop test_column1;                     # test_column1 삭제


#----------------------<테이블 조작(위치)>-----------------------------
alter Table test_table
modify test_column7 int
first;                                   # column7 을 가장 앞으로 보내준다 

alter Table test_table
modify test_column7 int
after test_column6;                      # column7 을 column6 뒤로 보내준다 

#---------------------<테이블 조작(변경)>------------------------------
alter Table test_table
change test_column2 test_column0 int ;   #colum2 이름을 column0으로 바꾼다

ALTER TABLE test_table
CHANGE test_column0 test_column0 VARCHAR(10); # column 타입을 변경 
desc test_table;

alter table test_table
change test_column0 test_column2 int;      # 이름 , 타입 둘다 변경 
desc test_table;

#-----------------------자동 생성 ----------------------------
CREATE TABLE test ( id INT AUTO_INCREMENT PRIMARY KEY );
INSERT INTO test VALUES ();            # insert into '(필드)''테이블' values ('값')
# id라는 column 밖에 없어서 test 앞에 column 쓰는건 생략 가능하고 , AUTO_INCREMENT 되어 있으므로 값은 알아서 생성

desc test;                             # test 테이블 조회
SELECT * FROM test;                    # 데이터 조회(*은 모든 필드를 조회한다는뜻)
show table status                      # 테이블의 상태를 보여줌 

INSERT INTO test VALUES (15);          # 이미 있는값을 뺴고는 지정해서 추가도 가능하다 
delete from test where id = 101;       # test 테이블에서 id 가 101 인 것만 삭제(where을 안쓰면 전체 다 삭제)

alter table test AUTO_INCREMENT = 1 ;  # AUTO_INCREMENT에 대해 초기화 또는 시작번호 지정

set @count=0;
update test set id=@count:=@count+1;   # 데이터가 난잡한거 보기좋게 1부터 순서대로 정렬(거의 안씀)


#----------------------------table만들기-----------------------------------------------
create table table1(                   # 테이블 만들기
	column1 varchar(100),
	column2 varchar(100),
	column3 varchar(100)
);

insert into table1 (column1 , column2 , column3)values('a','aa','aaa');
# 테이블에 값 넣기
insert into table1 values('a','aa','aaa');                     # 모두 다 같은것으로 넣기
insert into table1 ( column1, column2 ) values ( 'b', 'bb' );  # 하나는 null로 채워짐

update table1 set column1 = 'z';                               # column1 값 수정(전체)
update table1 set column1 = 'x' where column2 ='aa';           #column2 가 aa인것만 colum1 x로 바꿔라 
update table1 set column1 ='y' , column2='yy' where column3 = 'aaa';

delete from table1 where column1 ='y';

# -----------------------------실습--------------------------------------
create table if not exists hojeong(
ipaddress varchar(16) NOT NULL,        # NOT NULL을 사용하면 NULL값이 올 수 없다 
iptime_first datetime,
before_url varchar(250),
device_info varchar(40),
os_info varchar(40),
session_id varchar(80));


insert into hojeong(ipaddress,iptime_first,before_url,device_info)
values ( 'asdf','2023-02-23 11:33:29','localhost','pc'),
	   ( 'asdf','2023-02-23 11:33:29','localhost','iphone');

desc hojeong;

insert into hojeong(ipaddress,iptime_first,before_url,device_info)
values ( 'aaaaaaaaaaaaaaaaa','2023-02-23 11:33:29','localhost','pc');
 # 17개이면 16개 길이보다 길어서 못들어감 


insert into python.hojeong(session_id) values('12345.567890');
insert into python.hojeong(session_id) values('125.567890');
insert into python.hojeong(session_id) values('12345.590');
insert into python.hojeong(session_id) values('12345.56789');
select * from hojeong


DROP TABLE IF EXISTS day_visitor_realtime;
CREATE TABLE day_visitor_realtime (
  id INT,
  ipaddress varchar(16),
  iptime_first datetime,
  before_url varchar(250),
  device_info varchar(40),
  os_info varchar(40),
  session_id varchar(80),
  PRIMARY KEY(id)                        #primary key를 설정하면 중복된 값 , null값 가질 수 없음(테이블에 딱 하나)
  
);




CREATE TABLE orders (
 order_id INT,
 customer_id INT,
 order_date DATETIME,
 PRIMARY KEY(order_id)
);


insert into orders values(1,1,now());
insert into orders values(2,1,now());
insert into orders values(3,1,now());
select * from orders;


CREATE TABLE order_detail (
 order_id INT,
 product_id INT,
 product_name VARCHAR(200),
 order_date DATETIME,
 CONSTRAINT FK_ORDERS_ORDERID FOREIGN KEY (order_id) REFERENCES
orders(order_id),
 PRIMARY KEY(order_id, product_id)
);

insert into order_detail (order_id,product_id,product_name) 
values (3,101,'iphone') ,(2,101,'ipad');                    # 1,2,3 은 추가 가능  


insert into order_detail (order_id,product_id,product_name) # 3이 넘어가면 추가가 불가능 하다(foreign key떄문)
values (4,100,'iphone') ,(4,101,'ipad');                    # orders 에 있는 값만 추가 가능하다 따라서 불가 






CREATE TABLE `users` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `email` varchar(255) COLLATE utf8_bin NOT NULL,
    `password` varchar(255) COLLATE utf8_bin NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin
AUTO_INCREMENT=1 ;  

## users라는 테이블을 만든다

select * from users   # jupyter 코드에서 만드는거 실행 하면 새로 생기는거 확인 가능








