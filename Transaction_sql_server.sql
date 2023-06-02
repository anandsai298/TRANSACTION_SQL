create database ImplicitTransaction;
use ImplicitTransaction;
--
create table Employees(
ID int primary key,
Name varchar(50),
Salary bigint,
Age int,
);
drop table Employees;

insert into Employees values(1,'ask',10000,20);
insert into Employees values(2,'sai',20000,25);
insert into Employees values(3,'kumar',30000,22);
insert into Employees values(4,'anand',40000,26);

select * from Employees;
--implicit transaction
set Implicit_Transactions on;
--T1
update Employees set Name='aksra' where ID=1;
commit;
--T2
update Employees set Name='aski' where ID=2;
rollback;
--T3
update Employees set Name='kumaraja' where ID=3;
commit;
select * from Employees;
set Implicit_Transactions off;
select @@TRANCOUNT as opentransactions
--Explicit Transaction
declare @Error int;
begin transaction ;
insert into Employees values(6,'pspk',70000,29);
set @Error=@@ERROR;
if @Error!=0
begin
	print 'error occured: transaction failed '
	rollback;
end
else
begin
	print 'no errors: transactions success '
	commit;
end
--
select * from Employees;
select @@TRANCOUNT;
--SAVEPOINT--
begin transaction
	insert into Employees values(7,'dinu',45000,29);
	SAVE transaction deletepoint
	DELETE from Employees where ID=4;
	DELETE from Employees where ID=7;
	rollback transaction deletepoint
commit

