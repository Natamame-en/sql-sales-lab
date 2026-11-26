-- 販売データ分析アプリ スキーマ
-- ※ 意図的に主キー以外の索引は作っていない（チューニング学習のビフォー計測用）
CREATE TABLE customers (
  customer_id  SERIAL PRIMARY KEY,
  name         TEXT NOT NULL,
  email        TEXT NOT NULL,
  region       TEXT NOT NULL,
  created_at   DATE NOT NULL
);

CREATE TABLE products (
  product_id   SERIAL PRIMARY KEY,
  name         TEXT NOT NULL,
  category     TEXT NOT NULL,
  price        INT NOT NULL
);

CREATE TABLE orders (
  order_id     SERIAL PRIMARY KEY,
  customer_id  INT NOT NULL REFERENCES customers(customer_id),
  order_date   DATE NOT NULL,
  status       TEXT NOT NULL,
  total_amount INT NOT NULL DEFAULT 0
);

CREATE TABLE order_items (
  item_id      SERIAL PRIMARY KEY,
  order_id     INT NOT NULL REFERENCES orders(order_id),
  product_id   INT NOT NULL REFERENCES products(product_id),
  quantity     INT NOT NULL,
  unit_price   INT NOT NULL
);
