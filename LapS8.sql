create table NhanVien(
	TenNV nvarchar(255) not null,
	ID int primary key identity(1,1)
);
create table LoaiSP(
	TenLoaiSP nvarchar(255) not null,
	MaLoaiSP char(20) primary key,
	NhanVienID int not null foreign key references NhanVien(ID)
);
create table SanPham(
	MaSoSP char(20) primary key,
	NgaySX date not null,
	NhanVienID int not null foreign key references NhanVien(ID),
	LoaiSpID char(20) not null foreign key references LoaiSP(MaLoaiSP)
);
--drop table NhanVien;
--drop table LoaiSP;
--drop table SanPham;
insert into NhanVien(TenNV)
	values
		(N'Nguyễn Văn B'),
		(N'Nguyễn Văn D'),
		(N'Nguyễn Văn Z'),
		(N'Nguyễn Văn A'),
		(N'Nguyễn Văn C');
		select * from SanPham;
			
insert into LoaiSP(TenLoaiSP,MaLoaiSP,NhanVienID)
	values
		(N'Máy tính sách tay Z32','N37N',1),
		(N'Máy tính sách tay Z38','Z37D',3),
		(N'Máy tính sách tay Z39','Z37G',4),
		(N'Máy tính sách tay Z30','Z37A',5),
		(N'Máy tính sách tay Z31','Z37C',1),
		(N'Máy tính sách tay Z37','Z37Z',2);
select * from LoaiSP;
insert into SanPham(MaSoSP,NgaySX,LoaiSpID,NhanVienID)
	values
		('Z37 1111912','2012-12-09','Z37Z',2),
		('Z37 11112','2012-12-08','N37N',1),
		('Z37 11114','2012-12-07','Z37G',4),
		('Z37 11113','2012-12-06','Z37A',5),
		('Z37 11115','2012-12-09','N37N',1);
select * from SanPham;

--4. Viết các câu lênh truy vấn để
--a) Liệt kê danh sách loại sản phẩm của công ty.
select * from LoaiSP;
--b) Liệt kê danh sách sản phẩm của công ty.
select * from SanPham;
--c) Liệt kê danh sách người chịu trách nhiệm của công ty.
select * from NhanVien;

--5. Viết các câu lệnh truy vấn để lấy
--a) Liệt kê danh sách loại sản phẩm của công ty theo thứ tự tăng dần của tên
select * from LoaiSP order by TenLoaiSP asc;
--b) Liệt kê danh sách người chịu trách nhiệm của công ty theo thứ tự tăng dần của tên.
select * from NhanVien order by TenNV asc;
--c) Liệt kê các sản phẩm của loại sản phẩm có mã số là Z37N.
select * from SanPham where LoaiSpID in ( select MaLoaiSP from LoaiSP where MaLoaiSP like 'Z37Z');
--d) Liệt kê các sản phẩm Nguyễn Văn An chịu trách nhiệm theo thứ tự giảm đần của mã.
select * from SanPham where NhanVienID in ( select ID from NhanVien where TenNV like N'Nguyễn Văn B');

--6. Viết các câu lệnh truy vấn để
--a) Số sản phẩm của từng loại sản phẩm.
select LoaiSpID, count(MaSoSP) from SanPham group by LoaiSpID; 
--b) Số loại sản phẩm trung bình theo loại sản phẩm.
--c) Hiển thị toàn bộ thông tin về sản phẩm và loại sản phẩm.
select TenLoaiSP,MaLoaiSP,MaSoSP,NgaySX from LoaiSP inner join SanPham on LoaiSP.MaLoaiSP = SanPham.LoaiSpID;
--d) Hiển thị toàn bộ thông tin về người chịu trách nhiêm, loại sản phẩm và sản phẩm.
select * from NhanVien inner join SanPham on NhanVien.ID = SanPham.NhanVienID;

--7. Thay đổi những thư sau từ cơ sở dữ liệu
--a) Viết câu lệnh để thay đổi trường ngày sản xuất là trước hoặc bằng ngày hiện tại.
alter table SanPham add check (NgaySX <= getdate());
--b) Viết câu lệnh để xác định các trường khóa chính và khóa ngoại của các bảng.

--c) Viết câu lệnh để thêm trường phiên bản của sản phẩm.
alter table SanPham add PhienBan char(20);

--8. Thực hiện các yêu cầu sau
--a) Đặt chỉ mục (index) cho cột tên người chịu trách nhiệm
create index TenNV_index on NhanVien(TenNV);
---b) Viết các View sau:
--◦ View_SanPham: Hiển thị các thông tin Mã sản phẩm, Ngày sản xuất, Loại sản phẩm
create view View_SanPhamm as 
select A.MaSoSP, A.NgaySX, B.TenLoaiSP from SanPham A inner join LoaiSP B on A.LoaiSpID = B.MaLoaiSP;
select * from View_SanPhamm;
--◦ View_SanPham_NCTN: Hiển thị Mã sản phẩm, Ngày sản xuất, Người chịu trách nhiệm
create view View_SanPham_NCTN as
select B.MaSoSP,B.NgaySX,A.ID as NguoiChiuTN from NhanVien A inner join SanPham B on A.ID = B.NhanVienID;
select * from View_SanPham_NCTN;
--◦ View_Top_SanPham: Hiển thị 5 sản phẩm mới nhất (mã sản phẩm, loại sản phẩm, ngày
--sản xuất)
create view View_Top_SanPham as 


--c) Viết các Store Procedure sau:
--◦ SP_Them_LoaiSP: Thêm mới một loại sản phẩm
--◦ SP_Them_NCTN: Thêm mới người chịu trách nhiệm
--◦ SP_Them_SanPham: Thêm mới một sản phẩm
--◦ SP_Xoa_SanPham: Xóa một sản phẩm theo mã sản phẩm
--◦ SP_Xoa_SanPham_TheoLoai: Xóa các sản phẩm của một loại nào đó