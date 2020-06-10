with 
orders as (

    select
        order_id,
        customer_id,
        order_date,
        status
    from
        {{ ref('stg_orders') }}
),

payments AS (

    select
        order_id,
        SUM(amount) AS total_amount
    from
        {{ ref('stg_payments') }}
    where
        status = 'success'
    group by
        order_id
)

select
    orders.order_id,
    orders.customer_id,
    orders.order_date,
    orders.status,
    payments.total_amount AS amount
from
    orders
left join
    payments using (order_id)
