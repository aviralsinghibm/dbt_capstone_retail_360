select
    p.p_partkey as product_key,
    p.p_name as product_name,
    p.p_type as product_type,
    p.p_size as product_size,
    p.p_container as container,
    p.p_retailprice as retail_price,
    p.p_comment as comment,
    pm.total_order_lines,
    pm.total_quantity_sold,
    pm.gross_revenue,
    pm.net_revenue,
    pm.avg_discount,
    im.total_available_qty,
    im.supplier_count,
    im.is_low_stock,
    im.is_high_demand
from {{ ref('stg_part') }} p
left join {{ ref('int_product_metrics') }} pm
    on p.p_partkey = pm.p_partkey
left join {{ ref('int_inventory_metrics') }} im
    on p.p_partkey = im.p_partkey