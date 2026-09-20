select *
from {{ source('retail_raw', 'partsupp') }}