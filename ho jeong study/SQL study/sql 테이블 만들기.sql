################## testtbl1만들기 ###############
create table testtbl1 (id int , username char(3) , age int);
insert into testtbl1 values(1,'홍길동',25); # 특정 값에 맞게 입력
insert into testtbl1(id,username) values(2,'설현'); # 특정 부분 데이터만 입력할때
insert into tesstbl1(username, age , id) values ('하니',26,3); # 열 배열도 바꿈



#################### testttbl3 테이블 만들기 ###########
create table testtble3
	(id int auto_increment primary key,
    username char(3),
    age int);
alter table testtble3 auto_increment=1000;
set @@auto_increment_increment=3;        # id부분을 3씩 증가시키는 코드
insert into testtble3 values (null,'나연',20);
insert into testtble3 values (null,'정연',18);
insert into testtble3 values (null,'모모',19);
select * from testtbl3;

################testtbl4 테이블 만들기 ##################3333
create table testtbl4 (id int,fname varchar(50) , lname varchar(50));
insert into testtbl4
	select emp_no,first_name,last_name
		from employees.employees;
