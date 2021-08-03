create table MonThi(
	TenMonThi char(50),
	MaMonThi int primary key
);
create table LopHoc(
	TenLopHoc char(50),
	PhongHoc char(50),
	MaLopHoc int primary key,
);
create table SinhVien(
	TenSV char(255),
	MaSV int primary key,
	NgaySinh date,
	MaLopHoc int foreign key references LopHoc(MaLopHoc),
	MaMonThi int foreign key references MonThi(MaMonThi)
);
create table KetQua(
	DiemThi int,
	KetQuaSV text,
	ID int primary key,
);
create table SinhVienKetQua(
	MaSinhVien int foreign key references SinhVien(MaSV),
	KetquaID int foreign key references KetQua(ID)
);