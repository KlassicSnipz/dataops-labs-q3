{{ config(
    materialized='incremental',
    unique_key='order_item_id'
) }}
with stg_order_items as (
    select * from {{ ref('stg_order_items') }}
),

stg_orders as (
    select * from {{ ref('stg_orders') }}
),

stg_products as (
    select * from {{ ref('stg_products') }}
),

final as (

    select
        oi.order_item_id,
        oi.order_id,
        oi.product_id,
        o.customer_id,
        o.store_id,
        o.order_date,
        o.order_status,
        oi.quantity,
        oi.unit_price,
        oi.discount_pct,
        p.cost_price,
        oi.quantity * oi.unit_price as gross_amount,
        oi.quantity * oi.unit_price * oi.discount_pct / 100 as discount_amount,
        (oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)) as net_amount,
        (oi.quantity * p.cost_price) as total_cost,
        (oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100)) - (oi.quantity * p.cost_price) as margin

    from stg_order_items oi
    left join stg_orders o on oi.order_id = o.order_id
    left join stg_products p on oi.product_id = p.product_id

    {% if is_incremental() %}
    where oi.order_item_id > (select coalesce(max(order_item_id), 0) from {{ this }})
    {% endif %}

)

select * from final