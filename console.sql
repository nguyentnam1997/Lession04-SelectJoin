use sakila;
-- 1. Lấy ra tên các thành phố và tên các quốc gia tương ứng của thành phố đó
select city.city, country.country from city join country on country.country_id = city.country_id;

-- 2. Lấy ra tên các thành phố của nước Mỹ
select city.city, country.country from city join country on city.country_id = country.country_id
                                  where country = 'United States';

-- 3. Lấy ra các địa chỉ của thành phố Hanoi
select address.address, city.city from address join city on address.city_id = city.city_id
where city = 'Hanoi';

-- 4. Lấy ra tên, mô tả, tên category của các bộ phim có rating = R
select film.title, film.description, category.name, film.rating from film join category join film_category
    on category.category_id = film_category.category_id and film.film_id = film_category.film_id
    where film.rating = 'R';

-- 5. Lấy ra thông tin của các bộ phim mà diễn viên NICK WAHLBERG tham gia
select film.*, actor.first_name, actor.last_name from film join film_actor join actor
    on film_actor.actor_id = actor.actor_id and film.film_id = film_actor.film_id
where actor.first_name = 'NICK' and actor.last_name = 'WAHLBERG';

-- 6. Tìm email của các khách hàng ở Mỹ
select customer.email, country.country from customer join address join city join country
on city.country_id = country.country_id and customer.address_id = address.address_id and address.city_id = city.city_id
where country = 'United States';