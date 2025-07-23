-- Tablas iniciales en el esquema raw
CREATE SCHEMA IF NOT EXISTS raw;

CREATE TABLE raw.customers (
    customer_id   TEXT PRIMARY KEY,
    customer_name TEXT,
    email         TEXT,
    created_at    TEXT
);

CREATE TABLE raw.products (
    product_id    TEXT PRIMARY KEY,
    product_name  TEXT,
    category_id   TEXT,
    price         TEXT
);

CREATE TABLE raw.categories (
    category_id   TEXT PRIMARY KEY,
    category_name TEXT
);

CREATE TABLE raw.orders (
    order_id      TEXT PRIMARY KEY,
    customer_id   TEXT,
    order_date    TEXT,
    status        TEXT
);

CREATE TABLE raw.order_items (
    order_item_id TEXT PRIMARY KEY,
    order_id      TEXT,
    product_id    TEXT,
    quantity      TEXT,
    item_price    TEXT
);