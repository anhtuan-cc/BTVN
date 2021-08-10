create table NhaCC(
	MaNhaCC int primary key identity(1,1),
	TenNhaCC nvarchar(255) not null unique,
	DiaChi ntext not null,
	SoDT char(20) not null unique,
	MaSoThue nchar(50)
);
create table LoaiDichVu(
	MaLoaiDV int primary key identity(1,1),
	TenLoaiDV nvarchar(255) not null unique,
);
create table MucPhi(
	MaMP int primary key identity(1,1),
	DonGia decimal(12,4),
	MoTa ntext,
);
create table DongXe(
	DongXe int primary key identity(1,1),
	HangXe varchar(255),
	SoChoNgoi int,
);
create table DangKyCungCap(
	MaDKCC int primary key identity(1,1),
	MaNhaCC int not null foreign key references NhaCC(MaNhaCC),
	MaLoaiDV int not null foreign key references LoaiDichVu(MaLoaiDV),
	DongXe int not null foreign key references DongXe(DongXe),
	MaMP int not null foreign key references MucPhi(MaMP),
	NgayBatDauCungCap date not null check(NgayBatDauCungCap <= Getdate()),
	NgayKetThucCungCap date not null check (NgayKetThucCungCap >= Getdate()),
	SoLuongXeDangKy int not null
);

insert into NhaCC(TenNhaCC,DiaChi,SoDT,MaSoThue)
	values
	(N'Cty Nguyễn Anh Tuấn',N'Hà Nội','0987654321','HN123345'),
	(N'Cty Nguyễn Anh Tuấn2',N'Hà Nội','0987654322','HN1233456');

select * from NhaCC;