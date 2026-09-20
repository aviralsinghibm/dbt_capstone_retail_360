select *
from {{ source('retail_raw', 'part') }}