with
orders as (

    select
        order_id,
        order_cancelled,
        event_id,
        event_name,
        event_start,
        event_end,
        order_items,
        tax_amount,
        tickets_checked_in,
        tickets_purchased,
        total_paid,
        charge_id,
        transaction_type,
        order_date
    from
        {{ ref('stg_ticket_tailor_orders') }}
),

charges as (

    select
        charge_id,
        captured,
        created,
        currency,
        description,
        failure_code,
        failure_message,
        fraud_details,
        livemode,
        object,
        paid,
        refunded,
        status
    from
        {{ ref('stg_ticket_tailor_charges') }}
),

refunds as (

    select
        refund_id,
        charge_id,
        currency,
        created,
        status
    from
        {{ ref('stg_ticket_tailor_refunds') }}
)

select
    orders.order_id,
    orders.order_date,
    orders.event_name,
    orders.order_items,
    orders.tickets_purchased,
    orders.tax_amount,
    orders.total_paid,
    orders.order_cancelled,
    charges.charge_id,
    charges.captured as charge_captured,
    charges.status as charge_status,
    refunds.refund_id,
    refunds.status as refund_status
from
    orders
left join
    charges using (charge_id)
left join
    refunds using (charge_id)
