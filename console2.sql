use sakila;
create table Students
(
    student_id   int primary key not null,
    student_name varchar(50),
    student_age  int
);
create table Courses
(
    course_id          int primary key not null,
    course_name        varchar(50),
    course_description varchar(250)
);
create table Enrollments
(
    enrollment_id int primary key not null,
    student_id    int             not null,
    course_id     int             not null,
    foreign key (student_id) references Students (student_id),
    foreign key (course_id) references Courses (course_id)
);
insert into Students (student_id, student_name, student_age)
values (1, 'Nam1', 26),
       (2, 'Nam2', 20),
       (3, 'Nam3', 12),
       (4, 'Nam4', 11),
       (5, 'Nam5', 23),
       (6, 'Nam6', 18),
       (7, 'Nam7', 24),
       (8, 'Nam8', 19),
       (9, 'Nam9', 23),
       (10, 'Nam10', 13),
       (11, 'Nam11', 9),
       (12, 'Nam12', 13),
       (13, 'Nam13', 12),
       (14, 'Nam14', 20),
       (15, 'Nam15', 22),
       (16, 'Nam16', 8),
       (17, 'Nam17', 12),
       (18, 'Nam18', 17),
       (19, 'Nam19', 26),
       (20, 'Nam20', 10);

insert into Courses (course_id, course_name, course_description)
values (1, 'Toan', 'Des1'),
       (2, 'Van', 'Des2'),
       (3, 'Anh', 'Des3'),
       (4, 'Lich su', 'Des4'),
       (5, 'Sinh hoc', 'Des5'),
       (6, 'Khoa hoc', 'Des6'),
       (7, 'Java', 'Des7'),
       (8, 'C#', 'Des8'),
       (9, 'C++', 'Des9'),
       (10, 'Flutter', 'Des10'),
       (11, 'HTML', 'Des11'),
       (12, 'CSS', 'Des12'),
       (13, 'Javascript', 'Des13'),
       (14, 'Vue Js', 'Des14'),
       (15, 'Python', 'Des15'),
       (16, 'Android', 'Des16'),
       (17, 'IOS', 'Des17'),
       (18, 'SQL', 'Des18'),
       (19, 'C', 'Des19'),
       (20, 'Golang', 'Des20');

insert into Enrollments (enrollment_id, student_id, course_id)
values (1, 1, 3),
       (2, 5, 12),
       (3, 3, 4),
       (4, 7, 20),
       (5, 10, 2),
       (6, 4, 17),
       (7, 17, 14),
       (8, 20, 2),
       (9, 3, 9),
       (10, 2, 19),
       (11, 3, 13),
       (12, 2, 6),
       (13, 8, 4),
       (14, 8, 4),
       (15, 15, 13),
       (16, 4, 10),
       (17, 5, 16),
       (18, 1, 1),
       (19, 4, 6),
       (20, 14, 7);

-- Bài tập 1: Lấy danh sách tất cả sinh viên và thông tin khóa học mà họ đã đăng ký.
select Students.*, Courses.*
from Students
         join Courses
         join Enrollments
              on Courses.course_id = Enrollments.course_id and Students.student_id = Enrollments.student_id;

-- Bài tập 2: Lấy tên của tất cả các khóa học mà một sinh viên cụ thể đã đăng ký (sử dụng tham số student_id).
select Students.*, Courses.*
from Students
         join Courses
         join Enrollments
              on Courses.course_id = Enrollments.course_id and Students.student_id = Enrollments.student_id
where Students.student_id = 1;

-- Bài tập 3: Lấy danh sách tất cả sinh viên và số lượng khóa học mà họ đã đăng ký.
select Students.student_id, COUNT(Enrollments.course_id)
from Students
         left join Enrollments on Students.student_id = Enrollments.student_id
group by Students.student_id;

-- Bài tập 4: Lấy tất cả các khóa học mà chưa có sinh viên nào đăng ký.
select Courses.*
from Courses
         left join Enrollments on Courses.course_id = Enrollments.course_id
where student_id is null;

-- Bài tập 5: Lấy tất cả sinh viên và thông tin khóa học mà họ đã đăng ký, sắp xếp theo tên sinh viên và tên khóa học.
select Students.student_name, Courses.course_name
from Students
         left join Enrollments on Students.student_id = Enrollments.student_id
         left join Courses on Enrollments.course_id = Courses.course_id
order by Students.student_name, Courses.course_name;

-- Bài tập 6: Lấy tất cả các sinh viên và thông tin của họ, cùng với tên khóa học mà họ đăng ký (nếu có).
