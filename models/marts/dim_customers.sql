select
    c.c_custkey as customer_key,
    c.c_name as customer_name,
    c.c_address as address,
    c.c_nationkey as nation_key,
    c.c_phone as phone,
    c.c_acctbal as account_balance,
    c.c_mktsegment as market_segment,
    m.total_orders,
    m.total_spend,
    m.first_order_date,
    m.last_order_date,
    m.completed_orders,
    m.open_orders,
    m.pending_orders,
    case
        when m.total_spend >= 100000 then 'platinum'
        when m.total_spend >= 50000 then 'gold'
        when m.total_spend >= 10000 then 'silver'
        else 'standard'
    end as loyalty_tier
from {{ ref('stg_customer') }} c
left join {{ ref('int_customer_metrics') }} m
    on c.c_custkey = m.c_custkey