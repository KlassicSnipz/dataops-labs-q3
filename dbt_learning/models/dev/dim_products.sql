-- models/dev/dim_products.sql
-- Product dimension: descriptive attributes plus computed unit_margin

with stg_products as (

    select * from {{ ref('stg_products') }}

),

final as (

    select
        product_id,
        product_name,
        product_category                                           as category,
        product_subcategory                                        as subcategory,
        cost_price,
        list_price,
        list_price - cost_price                                    as unit_margin,
        launch_date,
        is_active

    from stg_products

)

select * from final