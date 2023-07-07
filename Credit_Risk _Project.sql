create table deriv_cusip_unique as
select distinct id_cusip
from bond_jan_2020
where id_cusip is not null
  and id_cusip <> ''
;


create table deriv_rating as
select
      a.*,
      b.ig as ig_moody,
      c.ig as ig_sp,
      d.ig as ig_dbrs,
      e.ig as ig_fitch,
      (
         case when b.ig is null then 0 else 1 end
       + case when c.ig is null then 0 else 1 end
       + case when d.ig is null then 0 else 1 end
       + case when e.ig is null then 0 else 1 end
      ) as avail_rtg_num
from bond_jan_2020 a
left join lt_rating_to_ig b on a.rtg_moody = b.rtg_moody
left join lt_rating_to_ig c on a.rtg_sp    = c.rtg_sp
left join lt_rating_to_ig d on a.rtg_dbrs  = d.rtg_dbrs
left join lt_rating_to_ig e on a.rtg_fitch = e.rtg_fitch
;


create table deriv_rating_1 as
select id_cusip, ig_moody as val from deriv_rating
union 
select id_cusip, ig_sp from deriv_rating
union
select id_cusip, ig_dbrs from deriv_rating
union
select id_cusip, ig_fitch from deriv_rating
order by id_cusip, val desc
;

create table deriv_rating_2 as
select *
from deriv_rating_1
where val is not null
;


create table deriv_rating_3 as
select 
      a.*,
      b.rownow
from deriv_rating_2 a
inner join (
    select id_cusip, count(*) as rownow
    from deriv_rating_2 
    group by id_cusip
) b
on a.id_cusip = b.id_cusip
;


create table deriv_rating_3_1 as
select 
      a.*,
      (select count(*)
       from deriv_rating_2 b 
       where b.id_cusip = a.id_cusip
       --group by b.id_cusip
      ) as rownum
from deriv_rating_2 a
;


create table deriv_rating_4 as
select 
      a.id_cusip,
      (
       select val
       from deriv_rating_3 b
       where b.id_cusip = a.id_cusip
         and rownow >= 2
       limit 1,1
      ) as final_val
from deriv_cusip_unique a
where final_val is not null
union
select id_cusip,
       val
from deriv_rating_3
where rownow = 1
;


create table deriv_rating_5 as
select 
      a.*,
      b.final_val as final_ig
from deriv_rating a
left join deriv_rating_4 b
on a.id_cusip = b.id_cusip
;


create table deriv_rating_6 as
select
      a.*,
      coalesce(b.rtg_final, 'N/A') as rtg_final
from deriv_rating_5 a
left join ig_to_rating b
on a.final_ig = b.ig
;


create table deriv_rating_report as
select 
      *,
      case
          when cntry_of_incorporation in ('US', 'CA') 
           and rtg_final = 'N/A'
           and industry_sector = 'Government'
           then 'AAA'
          when cntry_of_incorporation not in ('US', 'CA') 
           and rtg_final = 'N/A'
           and industry_sector = 'Government'
           then 'A'
          else rtg_final
      end as rtg_final_adj
from deriv_rating_6
;












