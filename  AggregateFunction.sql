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

-- Bài tập về nhà
-- 1. Lấy danh sách tên các diễn viên (actors) có họ bắt đầu bằng chữ “S”.
select first_name, last_name from actor where first_name like 'S%';

-- 2. Lấy danh sách các bộ phim (films) được phát hành trong khoảng từ năm 2000 đến năm 2010.
select * from film where release_year between 2000 and 2010;

-- 3. Lấy danh sách các bộ phim (films) có rating là “PG” hoặc “PG-13”.
select * from film where rating = 'PG' or rating = 'PG-13';

-- 4. Lấy danh sách diễn viên (actors) và số lượng bộ phim (films) mà họ tham gia, sắp xếp theo số lượng bộ phim giảm dần.
select actor.last_name, count(film_actor.film_id) as count from actor left join film_actor on actor.actor_id = film_actor.actor_id
left join film on film_actor.film_id = film.film_id group by actor.actor_id
order by count desc ;

-- 5. Lấy danh sách các bộ phim (films) và thể loại (categories) của chúng.
select film.title, category.name from film join film_category on film.film_id = film_category.film_id
join category on film_category.category_id = category.category_id;

-- 6. Lấy danh sách các bộ phim (films) và tổng số diễn viên (actors) tham gia trong mỗi bộ phim, sắp xếp theo tổng số diễn viên giảm dần.
select film.title, count(fa.actor_id) as 'count_actor' from film left join sakila.film_actor fa on film.film_id = fa.film_id
left join actor on fa.actor_id = actor.actor_id
group by film.film_id
order by count_actor desc;

-- 7. Lấy danh sách các diễn viên (actors) có số lượng bộ phim (films) tham gia lớn hơn 30.
select actor.last_name, count(film.film_id) as 'count_film' from actor left join film_actor on actor.actor_id = film_actor.actor_id
left join film on film_actor.film_id = film.film_id group by actor.actor_id
having count_film > 30;

-- 8. Lấy danh sách các diễn viên (actors) không tham gia trong bất kỳ bộ phim nào.
select actor.last_name, count(film.film_id) as 'count_film' from actor left join film_actor on actor.actor_id = film_actor.actor_id
left join film on film_actor.film_id = film.film_id group by actor.actor_id
having count_film = 0;

-- 9. Lấy danh sách bộ phim (films) và tổng doanh thu (revenue) của từng bộ phim, sắp xếp theo tổng doanh thu giảm dần.
select title, (rental_duration * rental_rate) as 'revenue'  from film
order by revenue desc ;

-- 10. Lấy danh sách các bộ phim (films) và thể loại (categories) của chúng, với điều kiện mỗi bộ phim thuộc thể loại “Horror”.
select film.title, category.name from film join film_category on film.film_id = film_category.film_id
join category on film_category.category_id = category.category_id
where category.name = 'Horror';