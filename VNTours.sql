create table Tours(
	ToursID int primary key identity(1,1),
	TourName nvarchar(200) not null,
	Day tinyint,
	Nights tinyint,
	Images  varchar(150),
	Description  nvarchar(500),
	Price money check(Price >0),
 
);
create table TourDetails(
	TourDetaillID int primary key identity(1,1),
	ToursID int foreign key references Tours(ToursID),
	Day tinyint,
	Place nvarchar(100) not null,
	Detail nvarchar(200),
	Vehicle nvarchar(100)
);

insert into Tours(TourName,Day,Nights,Description,Price)
	values
	   
		(N'Du Lịch Xanh',3,2,N'Nghỉ Dưỡng','5000000'),
		(N'Du Lịch 123',4,3,N'Thăm Quan','6000000'),
		(N'Du Lịch 789',4,3,N'Tắm Biển','7000000'),
		(N'Thích Tắm Biển',3,2,N'Tắm Biển','4000000'),
		(N'Vui Choi',2,2,N'Tắm Biển','4000000');
		

select * from Tours;
insert into TourDetails(ToursID,Day,Place,Detail,Vehicle)
	values
		(2,3,N'Hà Nội',N'Đẹp',N'Ô tô'),
		(1,3,N'Đà Lạt',N'Mát mẻ',N'Máy bay'),
		(4,3,N'Hạ Long',N'Đẹp',N'Tàu'),
		(3,4,N'Đà Nẵng',N'Trong lành',N'Máy bay');

--lam bai
--4. Write a query to select from Tours table where TourName or Description contains  ‘Ha Long’. 
select * from Tours where TourName like N'%Hạ Long%';

--5. Write a query to get tours that have days and nights less than 3 and Price less than  10 million. 
select * from Tours where Day <3 and Price < 10000000;

--6. Create index on column TourName of Tours table. 
create index TourName_Index on Tours(TourName);
--7. Create a view named v_TourInfor about one tour that display TourName, Price,  Day, Place, Detail and Vehicle from Tours and TourDetails tables. 
create view v_TourInfor as
select A.TourName,A.Price,A.Day,B.Place,B.Detail,B.Vehicle from Tours A inner join TourDetails B on A.ToursID = B.ToursID;
select * from v_TourInfor;

--8. Create a stored procedure named sp_FindTourByName that accepts keyword as  given input and display all tours that have TourName contain the keyword. 
create procedure sp_FindTourByName @keyword nvarchar(200) as
select * from Tours where TourName like '%'+@keyword+'%';

exec sp_FindTourByName @keyword = Du;

--9. Create a trigger named tg_RemoveTour that allows delete information relating to a  tour when this tour is deleted from the table Tours (delete information in table  TourDetails)

create trigger tg_RemoveTour on TourDetails
after delete
as
	if (select * from Tours right join TourDetails on Tours.ToursID = TourDetails.ToursID) <0
	 rollback transaction;