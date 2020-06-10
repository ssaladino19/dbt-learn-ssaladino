select
    id,
    orderid as order_id,
    paymentmethod,
    status,
    ROUND(amount/100,2) as amount,
    created,
    _batched_at
from
    raw.stripe.payment