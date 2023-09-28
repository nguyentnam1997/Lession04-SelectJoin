use sakila;

create table Categories
(
    category_id   int primary key not null,
    category_name varchar(50)     not null
);
create table Products
(
    product_id   int primary key not null,
    product_name varchar(50)     not null,
    category_id  int             not null,
    price        decimal         not null,
    foreign key (category_id) references Categories (category_id)
);
create table Customers
(
    customer_id   int primary key not null,
    customer_name varchar(50)     not null,
    email         varchar(50)
);
create table Orders
(
    order_id    int primary key not null,
    customer_id int             not null,
    order_date  date            not null,
    foreign key (customer_id) references Customers (customer_id)
);
create table OrderDetails
(
    order_detail_id int primary key not null,
    order_id        int             not null,
    product_id      int             not null,
    quantity        int             not null,
    foreign key (order_id) references Orders (order_id),
    foreign key (product_id) references Products (product_id)
);
-- 1. Lấy thông tin tất cả các sản phẩm đã được đặt trong một đơn đặt hàng cụ thể.
select Products.*
from Products
         join OrderDetails on Products.product_id = OrderDetails.product_id
where OrderDetails.order_id = 1;

-- 2. Tính tổng số tiền trong một đơn đặt hàng cụ thể.
select order_id, SUM(price) as 'total_price'
from Products
         join OrderDetails on Products.product_id = OrderDetails.product_id
where order_id = 2;

-- 3. Lấy danh sách các sản phẩm chưa có trong bất kỳ đơn đặt hàng nào.
select Products.product_id, product_name, count(OrderDetails.product_id) as 'count_product'
from Products
         left join OrderDetails on Products.product_id = OrderDetails.product_id
group by Products.product_id
having count_product = 0;

-- 4. Đếm số lượng sản phẩm trong mỗi danh mục. (category_name, total_products)
select category_name, count(product_id) as 'total_products'
from Categories
         join Products P on Categories.category_id = P.category_id
group by Categories.category_id;

-- 5. Tính tổng số lượng sản phẩm đã đặt bởi mỗi khách hàng (customer_name, total_ordered)
select customer_name, SUM(OrderDetails.quantity) as 'total_ordered'
from Customers
         left join Orders on Customers.customer_id = Orders.customer_id
         left join OrderDetails on Orders.order_id = OrderDetails.order_id
group by Customers.customer_id;

-- 6. Lấy thông tin danh mục có nhiều sản phẩm nhất (category_name, product_count)
-- cách 1
select category_name, count(product_id) as 'product_count'
from Categories
         join Products on Categories.category_id = Products.category_id
group by Categories.category_id
having product_count = (select max(product_id)
                        from Categories
                                 join Products P on Categories.category_id = P.category_id
                        group by Categories.category_id);
-- cách 2
select category_name, count(product_id) as 'product_count'
from Categories
         join Products on Categories.category_id = Products.category_id
group by Categories.category_id
order by product_count desc
limit 1;

-- 7. Tính tổng số sản phẩm đã được đặt cho mỗi danh mục (category_name, total_ordered)
select category_name, count(OD.product_id) as 'total_ordered'
from Categories
         join Products P on Categories.category_id = P.category_id
         left join OrderDetails OD on P.product_id = OD.product_id
group by Categories.category_id;

-- 8. Lấy thông tin về top 3 khách hàng có số lượng sản phẩm đặt hàng lớn nhất (customer_id, customer_name, total_ordered)
select Customers.customer_id, customer_name, SUM(OrderDetails.quantity) as 'total_ordered'
from Customers
         left join Orders on Customers.customer_id = Orders.customer_id
         left join OrderDetails on Orders.order_id = OrderDetails.order_id
group by Customers.customer_id
order by total_ordered desc
limit 3;

-- 9. Lấy thông tin về khách hàng đã đặt hàng nhiều hơn một lần trong khoảng thời gian cụ thể từ ngày A -> ngày B
-- (customer_id, customer_name, total_orders)
select Customers.customer_id, Customers.customer_name, count(Orders.order_id) as 'total_orders'
from Customers
         join Orders
              on Customers.customer_id = Orders.customer_id
where Orders.order_date between 'Ngày A' and 'Ngày B'
group by Customers.customer_id
having total_orders > 1;

-- 10. Lấy thông tin về các sản phẩm đã được đặt hàng nhiều lần nhất và số lượng đơn đặt hàng tương ứng
-- (product_id, product_name, total_ordered)
select Products.product_id, Products.product_name, SUM(OrderDetails.quantity) as 'total_ordered'
from Products
         join OrderDetails on Products.product_id = OrderDetails.product_id
         join Orders on OrderDetails.order_id = Orders.order_id
group by Products.product_id
order by total_ordered desc
limit 1;