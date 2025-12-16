-- sales and inventery management system

CREATE DATABASE sales_inventory_db;
USE sales_inventory_db;


-- product table
create table products (
  product_id int primary key AUTO_INCREMENT,
  product_name Varchar(100),
  category Varchar(50),
  price Decimal(10,2),
  stock_quantity int,
  reorder_level int
);
Insert Into products 
(product_name, category, price, stock_quantity, reorder_level)
values
('Laptop','Electronics',60000,20,5),
('Mouse','Electronics',500,100,20),
('Keyboard','Electronics',1500,50,10);

select * from products;

#customers table

 CREATE TABLE customers (
  customer_id INT PRIMARY KEY AUTO_INCREMENT,
  customer_name VARCHAR(100),
  email VARCHAR(100),
  city VARCHAR(50)
);
INSERT INTO customers (customer_name, email, city)
VALUES
('Ravi','ravi@gmail.com','Hyderabad'),
('Anita','anita@gmail.com','Bangalore');

select * from customers;

-- orders table

create table orders (
  order_id int primary key auto_increment,
  customer_id int,
  order_date date,
  foreign key (customer_id) references customers(customer_id)
);
insert  into orders (customer_id, order_date)
values
(1,'2025-01-10'),
(2,'2025-01-11');
select * from orders;



-- order_items table

create table order_items (
  order_item_id int primary key auto_increment,
  order_id int,
  quantity int,
  foreign key (order_id) references orders(order_id),
  foreign key (product_id) references products(product_id)
);
insert into order_items (order_id, product_id, quantity)
values
(1,1,2),
(1,2,3),
(2,3,1);
select * from order_items;

-- customer orders 

select c.customer_name, o.order_id, o.order_date
from customers c
join orders o on c.customer_id = o.customer_id;

-- low  stock check 

select product_name, stock_quantity
from products
where stock_quantity < reorder_level;

-- sales analytics 
-- total sales per product

select p.product_name, sum(oi.quantity) as total_sold
from products p
join order_items oi on p.product_id = oi.product_id
group by p.product_name;

-- ranking 

select product_id,
SUM(quantity) as total_sold,
RANK() OVER (ORDER BY SUM(quantity) DESC) as sales_rank
from order_items
group by product_id;


-- trigger 
create trigger reduce_stock
after insert on order_items
for each row
update products
set stock_quantity = stock_quantity - new.quantity
where product_id = new.product_id;



SELECT product_name, stock_quantity FROM products;




























