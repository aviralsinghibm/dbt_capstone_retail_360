select
    order_key,
    customer_key,
    order_status,
    total_price,
    order_date,
    order_priority,
    total_line_items,
    total_quantity
from {{ ref('fct_orders') }}