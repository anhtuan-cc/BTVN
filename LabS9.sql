create table NhaXB(
	TenNXB nvarchar(255) not null unique,
	DiaChi ntext,
	ID int primary key identity(1,1)
);
create table LoaiSach(
	TenLoaiSach nvarchar(255) not null unique,
	ID int primary key identity(1,1)
);
create table TacGia(
	TenTG nvarchar(255) not null,
	ID int primary key identity(1,1)
);
create table Sach(
	MaSach int primary key identity(1,1),
	TenSach nvarchar(255) not null unique,
	NoiDung ntext,
	NamXB date not null check (NamXB <= Getdate()),
	Giaban decimal(12,4) not null,
	SoLuong int not null,
	LanXB int not null,
	TacGiaID int not null foreign key references TacGia(ID),
	NhaXbID int not null foreign key references NhaXB(ID),
	LoaiSachID int not null foreign key references LoaiSach(ID)
);

insert into NhaXB(TenNXB,DiaChi)
	values 
	(N'Tri Thức',N'53 Nguyễn Du, Hai Bà Trưng, Hà Nội'),
	(N'Trí Tuệ',N'20 Cầu Giấy, Hà Nội'),
	(N'Thông Minh',N'30 Hàng Bài, Hà Nội');
insert into LoaiSach(TenLoaiSach)
	values
	(N'Khoa học xã hội'),
	(N'Tâm lý'),
	(N'Tình Cảm'),
	(N'Kinh Dị');
insert into TacGia(TenTG)
	values 
	(N'Eran Katz'),
	(N'Nguyễn Du'),
	(N'Tố Hữu'),
	(N'Nguyễn Anh Tuấn');
insert into Sach(TenSach,NamXB,Giaban,SoLuong,LanXB,TacGiaID,NhaXbID,LoaiSachID)
	values
	(N'Trí tuệ do thái','2010','79000',100,1,1,1,1),
	(N'Tâm lý xã hội','2012','5000',50,3,2,3,3),
	(N'Truyện cười','2004','60000',70,2,1,3,2);

	--Các yêu cầu cụ thể như sau:
--1. Viết lệnh SQL tạo CSDL có tên như trên, CSDL gồm các file theo yêu cầu sau:
--Tên logic Tên vật lý Dung lượng ban đầu Dung lượng tối đa
--bookstore bookstore_data.mdf 4MB 4GB
---- bookstore_data2.ndf 2MB 2GB
--bookstore_log bookstore_log.ldf 2MB 1GB

--2. Viết lệnh SQL chèn vào các bảng của CSDL các dữ liệu mẫu

--3. Liệt kê các cuốn sách có năm xuất bản từ 2008 đến nay
select * from Sach where NamXB > 2008; --**

--4. Liệt kê 10 cuốn sách có giá bán cao nhất
select top(10)* from Sach order by Giaban asc;
alter table Sach alter column Giaban decimal(12,0);

--5. Tìm những cuốn sách có tiêu đề chứa từ “tin học”
select * from Sach where TenSach like N'%Tin học%' ;

--6. Liệt kê các cuốn sách có tên bắt đầu với chữ “T” theo thứ tự giá giảm dần
select * from Sach where TenSach like N'T%' order by Giaban desc; --**

--7. Liệt kê các cuốn sách của nhà xuất bản Tri thức
select TenSach,Giaban from Sach where NhaXbID in
	(select ID from NhaXB where TenNXB like N'Tri thức');

--8. Lấy thông tin chi tiết về nhà xuất bản xuất bản cuốn sách “Trí tuệ Do Thái”
select * from NhaXB where ID
	in (select NhaXbID from Sach where TenSach like N'Trí tuệ do thái');

--9. Hiển thị các thông tin sau về các cuốn sách: Mã sách, Tên sách, Năm xuất bản, Nhà xuất bản,
--Loại sách
select * from Sach A
inner join NhaXB B on A.NhaXbID = B.ID
inner join LoaiSach C on A.LoaiSachID = C.ID;
--10. Tìm cuốn sách có giá bán đắt nhất
select top 1 * from Sach order by Giaban desc;
--11. Tìm cuốn sách có số lượng lớn nhất trong kho
select top 1 * from Sach order by SoLuong desc;

--12. Tìm các cuốn sách của tác giả “Eran Katz”
select TenSach from Sach where TacGiaID in
	(select ID from TacGia where TenTG like N'Eran Katz');
--13. Giảm giá bán 10% các cuốn sách xuất bản từ năm 2008 trở về trước
update Sach set Giaban = Giaban - (Giaban*10%); --**
----14. Thống kê số đầu sách của mỗi nhà xuất bản
select NhaXbID,count(*) as So_dau_sach from Sach group by NhaXbID;
--15. Thống kê số đầu sách của mỗi loại sách
select LoaiSachID, count(*) as So_dau_sac from Sach group by LoaiSachID;
--16. Đặt chỉ mục (Index) cho trường tên sách
create index TenSach_Index on Sach(TenSach);
--17. Viết view lấy thông tin gồm: Mã sách, tên sách, tác giả, nhà xb và giá bán
create view View_ThongTin as 
select A.MaSach,A.TenSach,B.TenTG,C.TenNXB, A.Giaban from Sach A inner join TacGia B on A.TacGiaID =  B.ID
					inner join NhaXB C on A.NhaXbID = C .ID;

select * from View_ThongTin;
--18. Viết Store Procedure:
--◦ SP_Them_Sach: thêm mới một cuốn sách
create procedure SP_ThemSach @TenSach nvarchar(255),@NamXB date,@Giaban decimal (12),@SoLuong int,@LanXB int,@TacGiaID int,@NhaXbID int,@LoaiSachID int as
	insert into Sach(TenSach,NamXB,Giaban,SoLuong,LanXB,TacGiaID,NhaXbID,LoaiSachID)
		values (@TenSach,@NamXB,@Giaban,@SoLuong,@LanXB,@TacGiaID,@NhaXbID,@LoaiSachID);
		select * from Sach;
exec SP_ThemSach @TenSach= N'Học SQL', @NamXB='2001',@Giaban='50000',@SoLuong=30,@LanXB=3,@TacGiaID=4,@NhaXbID=2,@LoaiSachID=3;
	
--◦ SP_Tim_Sach: Tìm các cuốn sách theo từ khóa
create procedure SP_TimSach @TuKhoa nvarchar(255) as
select * from Sach where TenSach like '%'+@TuKhoa+'%';
exec SP_TimSach @TuKhoa = trí;
drop procedure SP_TimSach;
--◦ SP_Sach_ChuyenMuc: Liệt kê các cuốn sách theo mã chuyên mục
create procedure SP_Sach_ChuyenMuc @MaChuyenMuc nvarchar(255) as
select * from Sach where MaSach in
	(select LoaiSachID from LoaiSach where ID like '%'+@MaChuyenMuc+'%');

exec SP_Sach_ChuyenMuc @MaChuyenMuc = 1;
drop procedure SP_Sach_ChuyenMuc;
--19. Viết trigger không cho phép xóa các cuốn sách vẫn còn trong kho (số lượng > 0)
create trigger Ko_Cho_Xoa on Sach
after delete
as 
	if (select SoLuong from Sach) >0
	print 'Ko duoc xoa';
	rollback transaction;

select * from Sach;
delete from Sach where TenSach like N'Học SQL';
drop trigger Ko_Cho_Xoa;
--20. Viết trigger chỉ cho phép xóa một danh mục sách khi không còn cuốn sách nào thuộc chuyên
--mục này.
create trigger Ko_Xoa_DanhMuc on LoaiSach
after delete
as
	if (
	 select SoLuong from Sach where LoaiSachID in 
	 ( select ID from LoaiSach)) >0
	 rollback transaction;
