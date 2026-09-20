select
    n.n_nationkey as nation_key,
    n.n_name as nation_name,
    n.n_regionkey as region_key,
    r.r_name as region_name,
    n.n_comment as comment
from {{ ref('stg_nation') }} n
left join {{ ref('stg_region') }} r
    on n.n_regionkey = r.r_regionkey