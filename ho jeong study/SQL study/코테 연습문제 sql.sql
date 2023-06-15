select m.member_name , r.review_text , date_format(r.REVIEW_DATE, "%Y-%m-%d")
from member_profile m
join (
	select review_text , review_date , member_id
    from rest_review
    where member_id =(
        select member_id
        from rest_review
        group by member_id
        order by count(*) desc
        limit 1)) r
on r.member_id = m.member_id
order by r.reviwe_date , r.review_text;