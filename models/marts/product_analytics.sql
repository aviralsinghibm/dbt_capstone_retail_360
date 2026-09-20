select
    product_key,
    product_name,
    product_type,
    retail_price,
    total_order_lines,
    total_quantity_sold,
    gross_revenue,
    net_revenue,
    avg_discount,
    total_available_qty,
    supplier_count,
    is_low_stock,
    is_high_demand
from {{ ref('dim_products') }}