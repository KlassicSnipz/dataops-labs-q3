-- models/stage/stg_products.sql
-- Staging model for products: cleans, casts, and standardizes raw_products

with source as (

    select * from {{ ref('raw_products') }}

),

cleaned as (

    select
        trim(product_id)::text                         as product_id,
        trim(product_name)::text                       as product_name,
        trim(category)::text                            as product_category,
        trim(subcategory)::text                          as product_subcategory,
        cost_price::numeric(12,2)                        as cost_price,
        list_price::numeric(12,2)                        as list_price,
        launch_date::date                                as launch_date,
        is_active::boolean                               as is_active

    from source

)

select * from cleaned