set @myvar1 = 5;
set @myvar4 ='가수이름==>';
select @myvar4 , Name from usertbl where height >180;

select cast(avg(amount)  as signed integer) as '평균 구매 개수' from buytbl; # cast( , signed integer)을 통해 정수로 변환
select cast('2020$12$12' as date);
select num , concat(cast(price as char(10)) , '*' , cast(amount as char(4)) , '=') as '단가*수량' , price*amount as '구매액' from buytbl;
# 가격 , amount 문자열로 바꾼것을 concat으로 합치고 이름을 단가*수량 / 실제 계산된값 이름을 구매액 으로 하는 칼럼을 만듬

select '100' + '200'; # 숫자로 변형되어서 더해짐
select 1 > '2mega'; # 정수인 2로 변환되어서 비교
select 0 = 'mega2'; # 문자는 0으로 변환되어서 비교
select ascii('a'),char(65);

select if (100>200,'참','거짓'); 
select ifnull(null,'널이군요'),ifnull(100,'널이군요'); # null이면 2/ null이 아니면 1부분 출력
select nullif(100,100),nullif(200,100); # 수식이  같으면 0 반환 / 다르면 1 반환 


select case 10 
	when 1 then '일'
    when 5 then '오'
    when 10 then '십'
    else '모름'
end as 'case연습';  # case가 10 이기떼문에 십 출력 


select concat_ws('/','2025','01','01'); # 2025/01/01 출력

select elt(2,'하나','둘','셋'); # 2반환(2번째 위치 있는 값)
select find_in_set('둘','하나','둘','셋'); # 3반환(둘이 있는 위치)
select locate('둘','하나둘셋'); # 3반환
select format(123456.123456,4); # 1000단위마다 콤마(,) 표시

select insert('abcdefghi',3,4,'@@@@'); # 3번째부터 4글자 @로 수정
select mid('대한민국만세',3,2); # 시작위치부터 길이만큼 문자 반환(민국)
select replace ('이것이 mysql이다','이것이','This is') ; # 이것이를 this is로 대체
select left('abcdefghi',3) , right('abcdefghi',3);
select substring_index('cafe.naver.com','.',2); # cafe.naver 반환

select lower('Kang') , upper('Kang');
select RPAD('이것이',5,'##'); # 길이 5까지 늘리고 오른쪽에 ##채움
select trim(both 'ㅋ' from 'ㅋㅋㅋ재밌어요ㅋㅋ'); # ㅋ 양쪽으로 없애줌 both(양쪽),leading(앞),trailing(뒤)
select repeat('이것이',3); # 문자열 3번 반복
select concat('이것이','space(10)','mysql이다'); # 10만큼 공백이 만들어짐



# 수학 method
select conv(100,10,8); # 100 10진수를 8진수로 변경 
select pwo(2,3), sqrt(9) ; #2의 3제곱과 루트값
select sign(-100) , sign(10); # 양수,0,음수인지 반환
select adddate('2015-01-01' , interval 31 day) , subdate('2025-01-01',interval 31 day); # 2015-01-01보다 한달더하기 , 한달빼기
select addtime('2015-01-01 23:59:59' , '1:1:1'); # 1시간1분1초후 반환
select datediff('2025-01-01',now()); # 시간끼리 뺄샘
select dayofweek(curdate()) , monthname(curdate()) , dayofyear(curdate()) ; # 1년중 몇먼째 날인지 구함(6,june,160출력)





