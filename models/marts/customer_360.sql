select
    c.customer_key,
    c.customer_name,
    c.market_segment,
    n.nation_name,
    n.region_name,
    c.total_orders,
    c.total_spend,
    c.first_order_date,
    c.last_order_date,
    c.completed_orders,
    c.open_orders,
    c.pending_orders,
    c.loyalty_tier
from {{ ref('dim_customers') }} c
left join {{ ref('dim_nation') }} n
    on c.nation_key = n.nation_key