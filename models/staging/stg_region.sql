select *
from {{ source('retail_raw', 'region') }}