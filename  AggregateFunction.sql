-- 1. Tính số lượng bản ghi ở bảng actor
select count(actor_id) as 'Count actor' from actor;

-- 2. Xác định thời lượng dài nhất và ngắn nhất của các bộ phim trong bảng film
select film_id, title, length from film where length = (select min(length) from film)
or length = (select max(length) from film)
order by length asc ;

select min(length), max(length) from film;

-- 3. Có bao nhiêu bộ phim có rating = R ?
select count(film_id) from film where rating = 'R';

-- 4. Trung bình rental_rate của các bộ phim dài hơn 60 phút ?
select avg(rental_rate) from film where length > 60;



-- 1. Tìm địa chỉ có chứa từ ‘San’ .
select address from address where address like '%San%';

-- 2. Tìm địa chỉ bắt đầu bằng ‘1’ và kết thúc bằng ‘y’
select address from address where address like '1%y';

-- 3. Tìm địa chỉ chứa chữ ‘a’ vị trí thứ 3
select address from address where address like '__a%';

-- 4. Tìm tên khách hàng có địa chỉ bằng có kết thúc chữ ‘o’
select customer.first_name, customer.last_name, address.address from customer
    join address on customer.address_id = address.address_id
where address.address like '%o';

-- 5. Tìm tên bộ phim có chứa category = ‘Games’;
select film.title, category.name from film join film_category on film.film_id = film_category.film_id
join category on film_category.category_id = category.category_id
where category.name like 'Games';


