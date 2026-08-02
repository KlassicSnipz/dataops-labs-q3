-- models/stage/stg_stores.sql
-- Staging model for stores: cleans, casts, and standardizes raw_store_locations

with source as (

    select * from {{ ref('raw_store_locations') }}

),

cleaned as (

    select
        trim(store_id)::text                             as store_id,
        trim(store_name)::text                           as store_name,
        trim(city)::text                                 as store_city,
        trim(country)::text                              as store_country,
        upper(trim(region))::text                         as store_region,
        opened_date::date                                as store_opened_date

    from source

)

select * from cleaned