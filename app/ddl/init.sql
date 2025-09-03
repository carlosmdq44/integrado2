-- ========= ESQUEMAS =========
CREATE SCHEMA IF NOT EXISTS raw;
CREATE SCHEMA IF NOT EXISTS staging;
CREATE SCHEMA IF NOT EXISTS core;
CREATE SCHEMA IF NOT EXISTS gold;

-- ========= TABLAS RAW =========
CREATE TABLE IF NOT EXISTS raw.customers (
    customer_id   TEXT PRIMARY KEY,
    customer_name TEXT,
    email         TEXT,
    created_at    TEXT
);

CREATE TABLE IF NOT EXISTS raw.products (
    product_id    TEXT PRIMARY KEY,
    product_name  TEXT,
    category_id   TEXT,
    price         TEXT
);

CREATE TABLE IF NOT EXISTS raw.categories (
    category_id   TEXT PRIMARY KEY,
    category_name TEXT
);

CREATE TABLE IF NOT EXISTS raw.orders (
    order_id      TEXT PRIMARY KEY,
    customer_id   TEXT,
    order_date    TEXT,
    status        TEXT
);

CREATE TABLE IF NOT EXISTS raw.order_items (
    order_item_id TEXT PRIMARY KEY,
    order_id      TEXT,
    product_id    TEXT,
    quantity      TEXT,
    item_price    TEXT
);

-- ========= CASTS / TIPOS =========
ALTER TABLE raw.customers
  ALTER COLUMN created_at TYPE TIMESTAMP USING NULLIF(created_at,'')::timestamp;

ALTER TABLE raw.products
  ALTER COLUMN price TYPE NUMERIC USING NULLIF(price,'')::numeric;

ALTER TABLE raw.orders
  ALTER COLUMN order_date TYPE DATE USING NULLIF(order_date,'')::date;

ALTER TABLE raw.order_items
  ALTER COLUMN quantity TYPE INTEGER USING NULLIF(quantity,'')::integer,
  ALTER COLUMN item_price TYPE NUMERIC USING NULLIF(item_price,'')::numeric;

-- ========= FKs =========
ALTER TABLE raw.products
  ADD CONSTRAINT fk_products_category
  FOREIGN KEY (category_id) REFERENCES raw.categories(category_id) ON DELETE SET NULL;

ALTER TABLE raw.orders
  ADD CONSTRAINT fk_orders_customer
  FOREIGN KEY (customer_id) REFERENCES raw.customers(customer_id) ON DELETE SET NULL;

ALTER TABLE raw.order_items
  ADD CONSTRAINT fk_oi_order
  FOREIGN KEY (order_id) REFERENCES raw.orders(order_id) ON DELETE CASCADE;

ALTER TABLE raw.order_items
  ADD CONSTRAINT fk_oi_product
  FOREIGN KEY (product_id) REFERENCES raw.products(product_id) ON DELETE SET NULL;

-- ========= ÍNDICES =========
CREATE INDEX IF NOT EXISTS idx_orders_order_date ON raw.orders(order_date);

-- ========= VISTAS / STAGING =========
-- staging de categorías (coincide con tu consulta de Streamlit)
CREATE OR REPLACE VIEW stg_categories AS
SELECT category_id, category_name
FROM raw.categories;

-- dimensión de productos simple
CREATE OR REPLACE VIEW dim_products AS
SELECT
  p.product_id,
  p.product_name,
  p.category_id,
  COALESCE(p.price, 0) AS price
FROM raw.products p;

-- ========= FACT TABLE (vista) =========
-- total_price = quantity * item_price
CREATE OR REPLACE VIEW fact_sales AS
SELECT
  oi.order_item_id,
  oi.order_id,
  oi.product_id,
  oi.quantity,
  oi.item_price,
  (oi.quantity * oi.item_price) AS total_price
FROM raw.order_items oi;
