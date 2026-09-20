select *
from {{ source('retail_raw', 'supplier') }}