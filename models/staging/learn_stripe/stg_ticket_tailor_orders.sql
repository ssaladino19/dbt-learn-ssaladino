with source as (

    select * from {{ source('ticket_tailor', 'orders') }}

),

renamed as (

    select
        order_id::int as order_id,
        CASE
            WHEN order_cancelled = 1 THEN TRUE
            WHEN order_cancelled = 0 THEN FALSE
            ELSE NULL
            end as order_cancelled,
        event_id::int as event_id,
        event_name,
        event_start,
        event_end,
        order_items,
        tax_amount::number(38,2) as tax_amount,
        tickets_checked_in,
        tickets_purchased::int as tickets_purchased,
        total_paid::number(38,2) as total_paid,
        transaction_id as charge_id,
        transaction_type,
        order_date

    from source

)

select * from renamed
