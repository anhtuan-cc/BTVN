create table KhachHang(
	TenKhachHang nvarchar(255) not null,
	ID int primary key identity(1,1),
	DienThoai char(20) not null unique,
	DiaChi ntext not null
);
create table SanPham(
	TenSanPham nvarchar(255) not null,
	MoTa ntext,
	MaSP int primary key identity(1,1) ,
	Gia decimal(12,4),
	DonVi nchar(20)	
);
create table DonHang(
	MaSoDH int primary key identity(1,1),
	NgayDat date not null check(NgayDat <= GETDATE()),
	TongTien decimal(12,4),
	KhachHangID  int not null foreign key references KhachHang(ID),
	
);
create table DonHangSanPham(
	MaDH int not null foreign key references DonHang(MaSoDH),
	MaSp int not null foreign key references SanPham(MaSP),
	SoLuong int not null check(SoLuong >0),
	ThanhTien decimal(12,4) not null check(ThanhTien >=0)
);
