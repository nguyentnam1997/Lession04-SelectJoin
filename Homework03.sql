-- Leetcode 04
SELECT employee_id FROM Employees WHERE employee_id NOT IN (SELECT employee_id FROM Salaries)
UNION
SELECT employee_id FROM Salaries WHERE employee_id NOT IN (SELECT employee_id FROM Employees)
order by employee_id asc;

-- Leetcode 05
select Employee.name, Bonus.bonus from Employee left join Bonus
    on Employee.empId = Bonus.empId
    where Bonus.bonus < 1000 or Bonus.bonus is null;
