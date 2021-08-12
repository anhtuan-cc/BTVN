create table KhachHang(
	TenKH nvarchar(255) not null ,
	ChungMinhThu char(20) not null unique,
	DiaChi ntext not null,
	ID int primary key identity(1,1)
);
create table ThueBao(
	SoThueBao char(20) primary key,
	LoaiThueBao nvarchar(255) not null,
	NgayDangKy date not null check(NgayDangKy <= GETDATE()),
	KhachHangID int not null foreign key references KhachHang(ID)
);
insert into KhachHang(TenKH,ChungMinhThu,DiaChi)
	values
	(N'Nguyễn Nguyệt Nga','123456789',N'Hà Nội'),
	(N'Nguyễn Văn A','12345678112',N'Thanh Hóa'),
	(N'Nguyễn Văn B','1234567891',N'Lào Cai'),
	(N'Nguyễn Văn C','987654321',N'Yên Bái'),
	(N'Nguyễn Văn D','98876564312',N'Hà Nội');
insert into ThueBao(SoThueBao,LoaiThueBao,NgayDangKy,KhachHangID)
	values
	('123456789',N'Trả trước','2012-12-02',1),
	('0911111111',N'Trả trước','2012-12-02',1),
	('0932121243',N'trả sau','2013-12-1',3),
	('09321214243',N'Trả trước','2013-12-1',1),
	('09321212413',N'trả sau','2013-12-2',4),
	('09321213243',N'trả sau','2013-12-3',5),
	('0932121243233',N'trả sau','2013-12-8',2);

	--4 ab
select * from KhachHang; 
select * from ThueBao;
--drop table ThueBao;
--drop table KhachHang;
	--5a
select	* from ThueBao where SoThueBao like '123456789';
select * from KhachHang where ID in  (select KhachHangID from ThueBao where SoThueBao like '123456789'); -- thông tin khách hàng
	--5b
select * from KhachHang where ChungMinhThu like '123456789';
--5c
select SoThueBao from ThueBao where KhachHangID in(select ID from KhachHang where ChungMinhThu like '123456789');
--5d
select * from ThueBao where NgayDangKy like '2012-12-02';
--5e
select * from ThueBao where KhachHangID in (select ID from KhachHang where DiaChi like N'Hà Nội');
--6a
select count(*) as TổngsốKH from KhachHang;
--6b
select count(*) as TổngTB from ThueBao;
--6c
select count(*) as TổngTB from ThueBao where KhachHangID in (select ID from KhachHang where NgayDangKy like '2012-12-02');
--6d
select * from KhachHang order by TenKH desc;
select * from KhachHang 
		inner join ThueBao on KhachHang.ID = ThueBao.KhachHangID;
			
--7a
alter table KhachHang alter column NgayDangKy add not null;
--7b
alter table KhachHang alter column NgayDangKy add check(NgayDangKy <= GetDate());
--7c
alter table ThueBao add check SoThueBao like '09%';
--7d
alter table ThueBao add DiemThuongTB;
