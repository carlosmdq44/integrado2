-- Llaves foráneas
ALTER TABLE raw.products
    ADD FOREIGN KEY (category_id) REFERENCES raw.categories(category_id);

ALTER TABLE raw.orders
    ADD FOREIGN KEY (customer_id) REFERENCES raw.customers(customer_id);

ALTER TABLE raw.order_items
    ADD FOREIGN KEY (order_id) REFERENCES raw.orders(order_id),
    ADD FOREIGN KEY (product_id) REFERENCES raw.products(product_id);

-- Índice
CREATE INDEX idx_orders_order_date ON raw.orders(order_date);