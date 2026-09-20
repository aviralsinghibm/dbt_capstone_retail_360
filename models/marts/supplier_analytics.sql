select
    supplier_key,
    supplier_name,
    nation_key,
    products_supplied,
    total_available_qty,
    total_orders,
    total_quantity_sold,
    total_revenue
from {{ ref('int_supplier_metrics') }}