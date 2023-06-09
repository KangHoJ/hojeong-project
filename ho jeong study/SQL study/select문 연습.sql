######## 조건에 따른 출력 ###############
select userId, name from usertbl where birthYear >=1970 or height >=182;
select name , height from usertbl where height >=180 and height >=182;
select name , height from usertbl where name like '김%'; # 김으로 시작하는 사람 조회
select name , height from usertbl where name like '_종신';

select name , height from usertbl where height > 177; # 김경호 키를 직접 입력해서 177이상 조회 
select name , height from usertbl where height > (select height from usertbl where name ='김경호'); # 서브쿼리를 통해 177이상 조회
select name , height from usertbl where height >= any(select height from usertbl where addr = '경남'); 
# 두가지 조건(>173,>170) 이므로 any를 넣어서 더 넓은 범위 170보다 크거나 같은 사람들만 출력하도록 한다 
select name , height from usertbl where height >= all(select height from usertbl where addr = '경남'); 
# 두가지 조건(>173,>170) 이므로 all를 넣어서 둘다 만족하는 173보다 큰 사람들만 출력하도록 한다


select name , mdate from usertbl order by mDate; # mdate 기준으로 정렬(정렬은 항상 가장 뒤에 와야함)
select name , height from usertbl order by height desc , name asc; # 두가지 기준으로 정렬
select distinct addr from usertbl; # 중복된걸 제거하고 출력해줌

use employees;
select emp_no , hire_date from employees order by hire_date asc limit 0 , 5;
# hire_date기준으로 정렬하고 0~5번째까지 출력

use sqldb2;
create table buytbl3 (select userID,prodName from buytbl); # buytbl에서 userid,prodname열만 복사해서 새로운 테이블 만듬

select userID,sum(amount) from buytbl group by userID; # userID 기준으로 amount 수 
select userID as '사용자 아이디',sum(price*amount) as '총 구매액' from buytbl group by userID;
# sum 이외에 쓰는 것들 -> avg , min , max , count , count(distinct) , stdev , var_samp
select name , max(height),min(height) from usertbl group by name; 
select name, height from usertbl 
where height = (select max(height) from usertbl) or height = (select min(height) from usertbl);
# 최대 최소를 select 문으로 추출해 그 중에서 name , height 를 selecet 문으로 추출 


select userID as '사용자',sum(price*amount) as '총구매액' 
	from buytbl 
	group by userID
    having sum(price*amount) > 1000
    order by sum(price*amount);
# 집계함수에 대한 조건을 사용할때 having절을 사용해서 한다 

select num ,groupname ,sum(price*amount) as '비용'
	from buytbl
    group by groupname , num
    with rollup;
# 그룹분류별로 중간 합계가 필요하면 with rollup구문 활용 


create table testtbl1 (id int , username char(3) , age int);
insert into testtbl1 values(1,'홍길동',25); # 특정 값에 맞게 입력
insert into testtbl1(id,username) values(2,'설현'); # 특정 부분 데이터만 입력할때
insert into tesstbl1(username, age , id) values ('하니',26,3); # 열 배열도 바꿈



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


create table testtbl4 (id int,fname varchar(50) , lname varchar(50));
insert into testtbl4
	select emp_no,first_name,last_name
		from employees.employees;


update testtbl4 set lname='없음' where fname = 'kyoichi'; # fname kyoichi값에서  lename값 없음으로 변경
update buytbl set price = price * 1.5;
delete from testtbl4 where fname = 'aamer' limit 5 ;           
truncate table testtbl4; # drop은 네이블 자체를 삭제하는거고 테이블 구조 남겨놓고 싶으면 truncate


with abc(userid,total)
as (select userid,sum(price*amount) from buytbl group by userid) select * from abc order by total desc;
# with 구절로 abc를 만들어서 price*amount = total 로 할당하고 그것을 기준으로 정렬 기준으로 정렬 

with cte_usertbl(addr,maxheight,minheight)
as (select addr , max(height) , min(height) from usertbl group by addr) select avg(maxheight*1.0) as '각지역별 최고 평균' from cte_usertbl;
# 1.0을 곱하는 부분은 실수로 만들기 위해서 


with abc(userid,total)
as (select userid,sum(price*amount) from buybl group by userid) select * from abc order by total desc;











