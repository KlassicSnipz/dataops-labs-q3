
with source as (
    select * from {{ ref('raw_customers') }}

),

cleaned as (

    select
    lower(customer_id)::text as customer_id,
    lower(first_name)::text as customer_first_name,
    lower(last_name)::text as customer_last_name,
    lower(email)::text as customer_email,
    replace(split_part(phone, '-', 1), '+', '')::text as customer_phone_country_code,
    split_part(phone, '-', 2)::text as customer_phone_number,
    signup_date::date as customer_signup_date,
    upper(country)::text as customer_country,
    upper(city)::text as customer_city
    from source

)

select * from cleaned
