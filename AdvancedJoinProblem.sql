--from hackerrank
-- https://www.hackerrank.com/challenges/interviews/problem?isFullScreen=true

SET NOCOUNT ON;


with Submission_sums as(
    select c.challenge_id
        , sum(s.total_submissions) as total_submissions
        , sum(s.total_accepted_submissions) as total_accepted_submissions
    from Challenges as c
        join Submission_stats as s on s.challenge_id = c.challenge_id
    group by c.challenge_id
)
, View_sums as (
    select c.challenge_id
        , sum(vw.total_views) as total_views
        , sum(vw.total_unique_views) as total_unique_views
    from Challenges as c
        join View_Stats as vw on vw.challenge_id = c.challenge_id
    group by c.challenge_id
), Contest_data as (
    select con.contest_id
        , con.hacker_id
        , con.name
        , col.college_id
        , cha.challenge_id
    from Contests as con
        join Colleges as col on col.contest_id = con.contest_id
        join Challenges as cha on cha.college_id = col.college_id
)
select contest_id
    , hacker_id
    , name
    , sum( coalesce(total_submissions, 0) )
    , sum( coalesce(total_accepted_submissions, 0) )
    , sum( coalesce(total_views,0) )
    , sum( coalesce(total_unique_views,0) )
from Contest_data as cdata
    left join View_sums as vws on vws.challenge_id = cdata.challenge_id
    left join Submission_sums as sss on sss.challenge_id = cdata.challenge_id
group by contest_id, hacker_id, name
having sum(total_submissions) + sum(total_accepted_submissions) + sum(total_views) + sum(total_unique_views) > 0
order by contest_id
;

go