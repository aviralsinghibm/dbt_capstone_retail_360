select *
from {{ source('retail_raw', 'lineitem') }}