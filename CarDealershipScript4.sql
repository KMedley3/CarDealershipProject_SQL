create table car_inventory(
	car_serial SERIAL primary key,
	car_make VARCHAR(100),
	car_model VARCHAR(100),
	car_year INTEGER,
	color VARCHAR(100),
	car_price NUMERIC(7,2)
);


create table customer(
	
	customer_id INTEGER primary key,
	first_name VARCHAR(100),
	last_name VARCHAR(100)

)

create table staff(
	staff_id INTEGER primary key,
	staff_position VARCHAR(100),
	first_name VARCHAR(100),
	last_name VARCHAR(100)
);

create table part_inventory(
	part_id VARCHAR(100) primary key,
	amount INTEGER,
	part_cost NUMERIC(5,2)
);

create table payment(
	transaction_id INTEGER primary key,
	transaction_type VARCHAR(100),
	customer_id INTEGER,
	car_serial INTEGER,
	staff_id INTEGER,
	foreign key(customer_id) references customer(customer_id),
	foreign key(car_serial) references car_inventory(car_serial),
	foreign key(staff_id) references staff(staff_id)
);

create table service(
	repair_ticket INTEGER primary key,
	service_cost NUMERIC(6,2),
	car_serial INTEGER,
	part_id VARCHAR(100),
	staff_id INTEGER,
	transaction_id INTEGER,
	foreign key(car_serial) references car_inventory(car_serial),
	foreign key(part_id) references part_inventory(part_id),
	foreign key(staff_id) references staff(staff_id),
	foreign key(transaction_id) references payment(transaction_id)
);

-- insert data into car_inventory table --
insert into car_inventory(car_serial, car_make, car_model, car_year, car_price)
values 	(12345, 'Audi', 'A6', 2023, 63600.00),
		(32132, 'Ford', 'Mustang', 1967, 58000.00),
		(77711, 'Mercedes-Benz', 'G-Class AMG G63', 2020, 99995.00)

-- insert data into customer table --
insert into customer(customer_id, first_name, last_name)
values		(1, 'Daryin', 'Medlington'),
			(2, 'Jordan', 'Medlington'),
			(3, 'India', 'Love')
			
select * from customer
-- insert data into staff table --
insert into staff(staff_id, staff_position, first_name, last_name)
values		(35, 'Salesperson', 'Tiffany', 'Craven'),
			(36, 'Mechanic', 'Jack', 'Alamo'),
			(37, 'Mechanic', 'Dora', 'Little'),
			(38, 'Salesperson', 'Jacoby', 'Brissett')
-- insert data into part_inventory table -- 
insert into part_inventory(part_id, amount, part_cost)
values		('7 Carburetor', 19, 157.99),
			('8 Air-filter', 2, 16.99),
			('9 Rear Passenger Door', 4, 397.99),
			('10 Front Rotors', 11, 86.00)
			
--insert data into payment table --
insert into payment(transaction_id, transaction_type, customer_id, car_serial, staff_id)
values		(1, 'Car purchase', 1, 12345, 35),
			(2, 'Repair service', 2, 32132, 36),
			(3, 'Car purchase', 3, 77711, 38)

-- adding another repair --
insert into payment(transaction_id, transaction_type, customer_id, car_serial, staff_id)
values		(4, 'Repair service', 1, 12345, 37)	

select * from payment
-- insert data into service table --
insert into service(repair_ticket, service_cost, car_serial, part_id, staff_id, transaction_id)
values		(11, 489.00, 32132, '7 Carburetor', 36, 2),
			(12, 711.52, 12345, '9 Rear Passenger Door', 37,4)
			

CREATE function new_car(
	_car_serial INTEGER,
	_car_make varchar(100),
	_car_model varchar(100), 
	_car_year INTEGER, 
	_color VARCHAR(100), 
	_car_price NUMERIC(7,2)
	)

returns void
AS $$
BEGIN
	-- Add a new car to car_inventory --
	insert into car_inventory(car_serial, car_make, car_model, car_year, color, car_price)
	values(_car_serial, _car_make, _car_model, _car_year, _color, _car_price);
	
END;
$$
LANGUAGE plpgsql;


-- call new_car function and add a car --

select new_car(19231, 'Land Rover', 'Range Rover', 2024, 'White', 66003.00)

-- creating a stored function to add a customer
create function new_customer(
	_customer_id INTEGER,
	_first_name VARCHAR,
	_last_name VARCHAR
)

returns void
as $$
begin 
	
	insert into customer(customer_id, first_name, last_name)
	values(_customer_id, _first_name, _last_name);
	
end;
$$
language plpgsql;

-- call function to add new customer --
select new_customer(300, 'Keenan', 'Medley Jr.')

select * from customer
