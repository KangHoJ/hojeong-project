use sqldb2;
create table pivottest
	(uname char(3),
     season char(2),
     amount int);
     
insert into pivotTest values
	('김범수','겨울',10) , ('윤종신','여름','15'),('김범수','가을',25),('김범수','봄',3),('김범수','봄',37),('윤종신','겨울',40),
    ('김범수','겨울',22),('윤종신','여름',64); #pivot 테이블에 값 넣음 
select * from pivotTest;
	
create table stdtbl
( stdname varchar(10) not null primary key,
	addr char(4) not null);
create table clubtbl
( clubname varchar(10) not null primary key,
	roomno char(4) not null);
create table stdclubtbl
( num int auto_increment not null primary key,
  stdname varchar(10) not null,
  clubname varchar(10) not null,
  foreign key(stdname) references stdtbl(stdname),
  foreign key(clubname) references clubtbl(clubname));
 
insert into stdtbl values ('김범수','경남'),('성시경','서울'),('조용필','경기'),('은지원','경북'),('바비킴','서울');
insert into clubtbl values ('수영','101호'),('바둑','102호'),('축구','103호'),('봉사','104호');
insert into stdclubtbl values (null,'김범수','바둑'),(null,'김범수','축구'),(null,'조용필','축구'),
(null,'은지원','축구'),(null,'은지원','봉사'),(null,'바비킴','봉사');
 
 
############## join 관련 ################################
select uName,
	sum(if(season='봄',amount,0)) as '봄',
    sum(if(season='여름',amount,0)) as '여름',
    sum(if(season='겨울',amount,0)) as '가을',
    sum(if(season='겨울',amount,0)) as '겨울',
    sum(amount) as '합계' from pivottest group by uname ;
    
    
select json_object('name',name,'height',height) as 'json 변환 값' from usertbl where height >=180;

select U.userId , U.name , B.prodname , U.addr , concat(u.mobile1,u.mobile2) as '연락처'
	from usertbl  U
		inner join buytbl B
         on U.userid = B.userid
	order by U.userid;

select distinct u.userid , u.name , u.addr
	from usertbl u
		inner join buytbl b
			on u.userid = b.userid
		order by u.userid;
        
        
select C.clubname , C.roomno , S.stdname , S.addr # clubname기준으로 병합하는 방법
	from stdtbl S # 학생 테이블에 
		inner join stdclubtbl SC # 학생,club정보를 병합한다 
			on SC.stdname = S.stdname  # 이름을 기준으로 
		inner join clubtbl C # 거기에 club정보만 병합한다
			on sc.clubname = C.clubname # 클럽이름을 기준으로 
	order by C.clubname; # 마지막으로 클럽 이름을 기준으로 정렬 
    
    
    select u.userID , u.name , b.prodName , u.addr , concat(u.mobile1,u.mobile2) as '연락처'
		from usertbl u
			left outer join buytbl b
				on u.userID = b.userID
		where b.prodname is null   # 구매기록이 없는 회원만 뽑기 위한 조건 
		order by u.userID;
        
	#############################################실습 활용 ###########################3
    # 동아리에 가입하지 않은 학생도 출력 (left outer join이용)
    select s.stdname , s.addr, c.clubname,c.roomno
		from stdtbl s
			left outer join stdclubtbl sc
				on s.stdname = sc.stdname
			left outer join clubtbl c
				on sc.clubname = c.clubname
		order by s.stdname;
        
	# 가입학생이 하나도 없는 동아리도 출력
    select c.clubname , c.roomno , s.stdname , s.addr
		from stdtbl s 
			left outer join stdclubtbl sc
				on sc.stdname = s.stdname
			right outer join clubtbl c
			    on sc.clubname = c.clubname
		order by c.clubname;
        

# 동아리 가입하지 않은 학생 + 학생이 한명도 없는 동아리 둘다 출력 
select s.stdname , s.addr, c.clubname,c.roomno
	from stdtbl s
		left outer join stdclubtbl sc
			on s.stdname = sc.stdname
		left outer join clubtbl c
			on sc.clubname = c.clubname
union  # union all 은 중복까지 모두 출력 
select c.clubname , c.roomno , s.stdname , s.addr
		from stdtbl s 
			left outer join stdclubtbl sc
				on sc.stdname = s.stdname
			right outer join clubtbl c
			    on sc.clubname = c.clubname
		order by c.clubname;


## self join ( 조직도 관계에서 자주 사용)
create table emptbl(emp char(3), manager char(3),emptel varchar(8));
insert into emptbl values('나사장',null,'0000');
insert into emptbl values('김재무','나사장','2222');
insert into emptbl values('김부장','김재무','2222-1');
insert into emptbl values('이부장','김재무','2222-1');
insert into emptbl values('우대리','이부장','2222-2-1');
insert into emptbl values('지사원','이부장','2222-2-2');

select a.emp as '부하직원' , b.emp as '직속상관' , b.emptel as '직속상관연락처'
	from emptbl a
		inner join emptbl b
			on a.manager = b.emp
	where a.emp = '우대리';
    
# not in / in
select name , concat(mobile1 , mobile2) as '전화번호' from usertbl
	where name not in (select name from usertbl where mobile1 is null);
# 전화가 없는 사람을 제외 할떄 

select name , concat(mobil1,mobile2) as '전화번호' from usertbl
	where name in (select name from usertbl where mobile1 is null);



## 고객의 분류를 하는 실습을 프로시저를 통해 구현
select u.userid , u.name, sum(price*amount) as '총구매액',
	case 
		when (sum(price*amount)>=1500) then '최우수 고객'
		when (sum(price*amount)>=1000) then '우수고객'
		when (sum(price*amount)>=1) then '일반고객'
		else '유령고객'
	end as '고객등급'
from buytbl b
	right outer join usertbl u
		on b.userid = u.userid
group by u.userid , u.name
order by sum(price*amount) desc;


    



