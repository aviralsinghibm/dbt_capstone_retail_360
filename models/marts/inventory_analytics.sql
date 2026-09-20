select
    p_partkey as product_key,
    p_name as product_name,
    p_type as product_type,
    total_available_qty,
    total_quantity_sold,
    supplier_count,
    is_low_stock,
    is_high_demand
from {{ ref('int_inventory_metrics') }}