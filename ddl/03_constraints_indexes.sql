-- Llaves primarias, foráneas e índices
ALTER TABLE raw.customers
    ADD PRIMARY KEY (customer_id);

ALTER TABLE raw.products
    ADD PRIMARY KEY (product_id),
    ADD FOREIGN KEY (category_id) REFERENCES raw.categories(category_id);

ALTER TABLE raw.categories
    ADD PRIMARY KEY (category_id);

ALTER TABLE raw.orders
    ADD PRIMARY KEY (order_id),
    ADD FOREIGN KEY (customer_id) REFERENCES raw.customers(customer_id);

ALTER TABLE raw.order_items
    ADD PRIMARY KEY (order_item_id),
    ADD FOREIGN KEY (order_id) REFERENCES raw.orders(order_id),
    ADD FOREIGN KEY (product_id) REFERENCES raw.products(product_id);

CREATE INDEX idx_orders_order_date ON raw.orders(order_date);
