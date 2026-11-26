-- 大量データ生成（顧客1万・商品5千・注文100万・明細300万）
SELECT setseed(0.42);

INSERT INTO customers (name, email, region, created_at)
SELECT '顧客' || g,
       'user' || g || '@example.com',
       (ARRAY['北海道','東北','関東','中部','近畿','中国','四国','九州'])[1 + g % 8],
       DATE '2020-01-01' + (g % 1500)
FROM generate_series(1, 10000) g;

INSERT INTO products (name, category, price)
SELECT '商品' || g,
       (ARRAY['食品','家電','日用品','衣料','文具'])[1 + g % 5],
       (random() * 20000)::INT + 100
FROM generate_series(1, 5000) g;

INSERT INTO orders (customer_id, order_date, status)
SELECT 1 + floor(random() * 10000)::INT,
       DATE '2023-01-01' + (random() * 700)::INT,
       (ARRAY['完了','出荷済','処理中','キャンセル'])[1 + floor(random() * 4)::INT]
FROM generate_series(1, 1000000) g;

INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT 1 + floor(random() * 1000000)::INT,
       1 + floor(random() * 5000)::INT,
       1 + floor(random() * 5)::INT,
       (random() * 20000)::INT + 100
FROM generate_series(1, 3000000) g;

UPDATE orders o
SET total_amount = s.sum_amount
FROM (SELECT order_id, SUM(quantity * unit_price) AS sum_amount
      FROM order_items GROUP BY order_id) s
WHERE o.order_id = s.order_id;
