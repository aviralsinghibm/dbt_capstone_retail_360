select *
from {{ source('retail_raw', 'nation') }}