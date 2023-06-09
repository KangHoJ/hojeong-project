# member 테이블 id,name column 조회
select memberId , memberName from member where memberName = '강호정';
select * from member;

# 테이블 생성 
create table `product` (name char);
drop table `my table`;

# my table id열에 index_mytable 인덱스 생성 
create index idx_mytidable on `my table`(id);
drop table `my table`;

# 뷰는 테이블중에서 특정 컬럼만 가져와서 만든것 
# 뷰 생성 (member 테이블의 membername , adress만 가져와 uv_memberTBL라는 이름의 view 생성)
create view uv_memberTBL as select memberName , Address from member;
# 뷰 조회
select * from uv_memberTBL;

# 스토어드 프로시저 만들기
DELIMITER //
create procedure myporc2()
begin
	select * from member where memberName ='강호정';
    select * from member where memberName ='박수현';
end //
DELIMITER ;

# 스토어디 프로시저 실행 (2개가 각각 따로 한번에 실행된다)
call myporc2();
# 프로시저 삭제
drop procedure myporc;


select * from member;
# 새로 추가
insert into member values ('kim','연아','경기 군포');
# 데이터 변경 (연아 이름의 주소를 변경해라)
update member set Address ='성남' where memberName ='연아';
# 데이터 삭제
delete from member where membername ='연아';


use employees;
select first_name as '이름' , gender '성별' , hire_date '회사 입사일' from employees;







