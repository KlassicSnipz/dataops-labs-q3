-- models/dev/dim_stores.sql
-- Store dimension: descriptive attributes built from stg_stores

with stg_stores as (

    select * from {{ ref('stg_stores') }}

),

final as (

    select
        store_id,
        store_name,
        store_city                                                 as city,
        store_country                                              as country,
        store_region                                               as region,
        store_opened_date                                          as opened_date

    from stg_stores

)

select * from final