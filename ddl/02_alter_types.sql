-- Conversión de tipos y normalización
ALTER TABLE raw.customers
    ALTER COLUMN created_at TYPE TIMESTAMP USING created_at::timestamp;

ALTER TABLE raw.products
    ALTER COLUMN price TYPE NUMERIC USING price::numeric;

ALTER TABLE raw.orders
    ALTER COLUMN order_date TYPE DATE USING order_date::date;

ALTER TABLE raw.order_items
    ALTER COLUMN quantity TYPE INTEGER USING quantity::integer,
    ALTER COLUMN item_price TYPE NUMERIC USING item_price::numeric;