use e_commerce_db;

show tables;

CREATE TABLE customers (
    ID INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    country VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);
 create table orders(
    order_id int primary key,
    customer_id int,
	order_date date,
	foreign key (customer_id) references customer(ID));
    
create table order_items(
order_items_id int primary key,
order_id int,
product_id int,
quintity int,
unit_price decimal(10,2),
foreign key (order_id) references orders(order_id),
foreign key (product_id) references products(product_ID));

create table payments(
payment_id int primary key,
order_id int,
payment_method varchar(50),
amount decimal(10,2),
status varchar(20),
foreign key (order_id) references orders(order_id)
);

INSERT INTO customer (ID, name, email, country) VALUES
(1, 'Alice Johnson', 'alice@example.com', 'USA'),
(2, 'Bob Smith', 'bob@example.com', 'Canada'),
(3, 'Carlos Diaz', 'carlos@example.com', 'Mexico'),
(4, 'Deepa Patel', 'deepa@example.com', 'India'),
(5, 'Emma Brown', 'emma@example.com', 'UK');

INSERT INTO products (product_id, name, category, price) VALUES
(101, 'Wireless Mouse', 'Electronics', 25.99),
(102, 'Bluetooth Headphones', 'Electronics', 59.99),
(103, 'Yoga Mat', 'Fitness', 20.00),
(104, 'Running Shoes', 'Footwear', 85.50),
(105, 'Desk Lamp', 'Home & Living', 30.00);

INSERT INTO orders (order_id, customer_id, order_date) VALUES
(1001, 1, '2024-01-15'),
(1002, 3, '2024-01-20'),
(1003, 2, '2024-02-05'),
(1004, 4, '2024-02-25'),
(1005, 1, '2024-03-01');

INSERT INTO order_items (order_items_id, order_id, product_id, quantity, unit_price) VALUES
(1, 1001, 101, 2, 25.99),
(2, 1001, 105, 1, 30.00),
(3, 1002, 103, 3, 20.00),
(4, 1003, 102, 1, 59.99),
(5, 1004, 104, 1, 85.50),
(6, 1005, 101, 1, 25.99),
(7, 1005, 102, 2, 59.99);

INSERT INTO payments (payment_id, order_id, payment_method, amount, status) VALUES
(201, 1001, 'Credit Card', 81.98, 'Completed'),
(202, 1002, 'PayPal', 60.00, 'Completed'),
(203, 1003, 'Credit Card', 59.99, 'Pending'),
(204, 1004, 'Debit Card', 85.50, 'Completed'),
(205, 1005, 'Credit Card', 145.97, 'Completed');

# Total_Revenue
select sum(quantity*unit_price) as Total_Revenue from order_items;

select * from products;
select * from order_items;

# Top 3 best-selling products
select
 p.name, sum(oi.quantity) as total_sold 
 from products as p 
 join 
 order_items as oi 
on 
p.product_ID=oi.product_id
group by p.name
order by 
sum(oi.quantity) desc 
limit 3;


# for top 3 best product by revenue
select
 p.name, sum(oi.quantity* unit_price) as total_Revenue 
 from products as p 
 join 
 order_items as oi 
on 
p.product_ID=oi.product_id
group by p.name
order by 
sum(oi.quantity* unit_price) desc 
limit 3;

#  Monthly sales trend
select 
month(order_date),sum(quantity*unit_price) as taotalrevenue_by_months
from orders as o join order_items as oi 
on o.order_id=oi.order_id 
group by month(order_date);

