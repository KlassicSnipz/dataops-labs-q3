-- models/dev/dim_customers.sql
-- Customer dimension: descriptive attributes built from stg_customers

with stg_customers as (

    select * from {{ ref('stg_customers') }}

),

final as (

    select
        customer_id,
        customer_first_name || ' ' || customer_last_name          as full_name,
        customer_email                                             as email,
        '+' || customer_phone_country_code || '-' ||
            customer_phone_number                                  as phone,
        customer_country                                           as country,
        customer_city                                              as city,
        customer_signup_date                                       as signup_date

    from stg_customers

)

select * from final