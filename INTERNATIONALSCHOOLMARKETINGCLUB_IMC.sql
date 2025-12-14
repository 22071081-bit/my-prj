create database INTERNATIONALSCHOOLMARKETINGCLUB_IMC
go


use INTERNATIONALSCHOOLMARKETINGCLUB_IMC
go
create table MEMBERS(
   IDSV int not null,
   Tensv nvarchar(50) not null,
   Gioitinh nvarchar(10),
   Sodt varchar(10),
   Nganh char(20) not null,
   Diachi nvarchar(30) not null,
   CONSTRAINT PK_MEMBERS primary key (IDSV)
)
go


create table POSITION(
   IDSV int not null,
   Tensv nvarchar(100) not null,
   Chucvu nvarchar(100) not null,
   Nganh char(100) not null,
   CONSTRAINT PK_POSITION primary key (IDSV,Chucvu)
)
go


create table ACTIVITIES(
   Chude nvarchar(100) not null,
   Diadiem nvarchar(100)not null,
   MC nvarchar(100),
   Thoigian date,
   Khachmoi nvarchar(1000),
   Chiphithamgia varchar(10),
   CONSTRAINT PK_ACTIVITIES primary key (Chude)
)
go


create table FUNDCOLLECTION(
   Tienquyduytri float not null,
   Nhataitro nvarchar(50),
   Tinhtrang nvarchar(50),
   CONSTRAINT PK_FUNDCOLLECTION primary key (Tienquyduytri)
)
go


create table EXPENDITURE(
   Kinhphitochucsukien float not null,
   Chiphilienhoan float,
   Tuyenduong float,
   CONSTRAINT PK_EXPENDITURE PRIMARY KEY (Kinhphitochucsukien)
)
go


INSERT INTO MEMBERS(IDSV,Tensv,Gioitinh,Sodt,Nganh,Diachi) VALUES
('20071050',N'Lê Thị Thu Trang',N'Nữ','0963427086','Dual-MKT2020A',N'Hà Nội'),
('22070630',N'Nguyễn Ngọc Linh Trang',N'Nữ','0973258094','AC2020A',N'Hà Nội'),
('21070593',N'Nguyễn Nguyệt Minh',N'Nữ','0389522605','IB2021B',N'Hà Nội'),
('21073141',N'Nguyễn Minh Phương',N'Nữ','0919569263','ACF2021C',N'Hà Nội'),
('22070722',N'Nguyễn Bảo Linh',N'Nữ','0976532619','DUAL-MKT2022',N'Hà Nội'),
('21073137',N'Đỗ Đức Anh',N'Nam','0386529762','VISK2021B',N'Hà Nội'),
('23070680',N'Nguyễn Khánh VY',N'Nữ','0976538692','IB2023',N'Hà Nội'),
('21073519',N'Ngô Thúy Hà',N'Nữ','0389732526','ACF2021B',N'Hà Nội'),
('23070740',N'Vũ An Hà',N'Nữ','0372590805','IB2023',N'Hà Nội'),
('21070174',N'Nguyễn Thị Mai Hương',N'Nữ','0389633323','IB2021D',N'Hà Nội'),
('20071030',N'Nguyễn Thùy Linh',N'Nữ','0978997002','DUAL-MKT2020A',N'Hà Nội'),
('23070665',N'Cù Thu Uyên',N'Nữ','0974225314','IB2023',N'Hà Nội'),
('23073180',N'Hoàng Thị Thu Uyên',N'Nữ','0589267997','TADB',N'Hà Nội'),
('23070939',N'Trần Lê Quang',N'Nam','0868703495','DUAL-MKT2023',N'Hà Nội'),
('23071030',N'Hoàng Trần Thảo Linh',N'Nữ','0368810618','DUAL-MKT2023',N'Hà Nội'),
('21070497',N'Nguyễn Thị Trà Giang',N'Nữ','0868703495','IB2021D',N'Hà Nội'),
('22070651',N'Hà Tuấn Hiệp',N'Nam','0961731919','DUAL-MKT2022',N'Hà Nội'),
('23073095',N'Trần Văn Duy',N'Nam','0966921921','KEUKA',N'Hà Nội'),
('23070622',N'Kiều Việt Hòa',N'Nam','934550501','IB2023',N'Hà Nội'),
('21070494',N'Nguyễn Chu Nhật Linh',N'Nữ','0976173314','IB2021B',N'Hà Nội'),
('20070365',N'Nguyễn Thị Huyền Trang',N'Nữ','0904054857','IB2020D',N'Hà Nội'),
('22070670',N'Bùi Thị Duyên',N'Nữ','0866196616','DUAL-MKT2022B',N'Hà Nội'),
('22070654',N'Trần Thị Hà Châu',N'Nữ','0914786616','BDA2022C',N'Hà Nội'),
('21070689',N'Nguyễn Thị Phượng',N'Nữ','0912264778','IB2021C',N'Hà Nội'),
('23070931',N'Đinh Thị Ánh Tuyết',N'Nữ','0966150687','DUAL-MKT2023',N'Hà Nội'),
('23073073',N'Đỗ Yến Nhi',N'Nữ','0914663992','Keuka',N'Hà Nội'),
('23070464',N'Nguyễn Quỳnh Chi',N'Nữ','0968150649','ISEL2023',N'Hà Nội'),
('23070041',N'Lê Ngọc Mai',N'Nữ','0853833999','BEL2022B',N'Hà Nội'),
('20070147',N'Vũ Hoàng Ngân Giang',N'Nữ','0857078366','IB2020B',N'Hà Nội'),
('21070199',N'Nguyễn Tuệ Linh',N'Nữ','0398881932','IB2021',N'Hà Nội')
SELECT * FROM MEMBERS;




INSERT INTO POSITION(IDSV,Tensv,Chucvu,Nganh) VALUES
('20071050',N'Lê Thị Thu Trang','MC-DES-Presidnet','Dual-MKT2020A'),
('22070630',N'Nguyễn Ngọc Linh Trang','PG-Vice President','AC2020A'),
('21070593',N'Nguyễn Nguyệt Minh','IPR-Vice President','IB2021B'),
('21073141',N'Nguyễn Minh Phương','PG-Assistant','ACF2021C'),
('22070722',N'Nguyễn Bảo Linh','PG-Leader','Dual-MKT2022'),
('21073137',N'Đỗ Đức Anh','PG-Member','VISK2021B'),
('21070174',N'Nguyễn Thị Mai Hương','MC-CONTENT MEMBER','IB2021D'),
('22070651',N'Hà Tuấn Hiệp','MC-DES MEMBER','DUAL-MKT2022'),
('21070494',N'Nguyễn Chu Nhật Linh','Leader IPR','IB2022B'),
('20070147',N'Vũ Hoàng Ngân Giang','IPR MEMBER','IB2020B'),
('20070147',N'Vũ Hoàng Ngân Giang','Leader ER','IB2020B'),
('23070799',N'Đỗ Đình Thanh','ER Member','IB2023')
SELECT * FROM POSITION;




INSERT INTO ACTIVITIES(Chude,Diadiem,MC,Thoigian)
VALUES ('Workshop: RECESSIONS CALL, OPPORTUNITY FOR ALL',N'Phòng 412,Trường Quốc Tế - ĐHQGHN, số 1 Trịnh Văn Bô',N'Lê Thị Thu Trang','2023-12-16')
INSERT INTO ACTIVITIES(Chude,Diadiem,Thoigian,Khachmoi)VALUES
('Workshop: Marcomms industry insights',N'Phòng 514,Trường Quốc Tế - ĐHQGHN, số 1 Trịnh Văn Bô','2023-04-07',N'diễn giả: Trần Hoàng Hà'),
('Workshop: Audit to finance | Networking day',N'Phòng 514,Trường Quốc Tế - ĐHQGHN, số 1 Trịnh Văn Bô','2023-04-08',N'diễn giả: Khuất Thái Tài, Đoàn Tuấn Vũ'),
('Workshop: She self-defense: she will be strong',N'Phòng 514,Trường Quốc Tế - ĐHQGHN, số 1 Trịnh Văn Bô','2023-03-04',
N'HLV Phạm Văn Lý, HLV Trưởng Vietnhatclub Long Biên'),
('Workshop: Martech- make your hance',N'Cafe sách Đông Tây-79 Ngụy Như Kon Tum','2022-12-22',N'diễn giả: Tình Nguyễn , Bùi Mỹ Trinh')
INSERT INTO ACTIVITIES(Chude,Diadiem,MC,Thoigian,Khachmoi,Chiphithamgia)VALUES
('Workshop: KICK-START YOUR CAREER: KILLER WAYS TO BUILD PERFECT CV',N'Zoom',N'Bùi Thị Duyên','2023-02-02',N'diễn giả: các chuyên gia nhân sự hàng đầu','free')
SELECT * FROM ACTIVITIES;




INSERT INTO FUNDCOLLECTION(Tienquyduytri) VALUES ('100000')
SELECT * FROM FUNDCOLLECTION;


INSERT INTO EXPENDITURE(Tuyenduong) VALUES ('10000000','50000')
SELECT * FROM EXPENDITURE;




--thêm dữ liệu(có thêm tv tham gia clb)--
INSERT INTO MEMBERS(IDSV,tenSV,Gioitinh,Sodt,Nganh,Diachi) Values
('23070468',N'Đào Huy Phúc',N'Nam','038496204','IB2023',N'Hà Nội'),
('22070638',N'Hồ Nguyễn Hiền Thư',N'Nữ','098455917','IB2022',N'Hà Nội'),
('22070623',N'Cao Hiểu Khánh',N'Nữ','036808475','BDA2022',N'Hà Nội'),
('22070133',N'Lưu Quang Tuấn',N'Nam','038735691','AAIK21',N'Hà Nội'),
('22070856',N'Bùi Minh Hưng',N'Nam','029674555','Marketing2022',N'Hà Nội'),
('23070851',N'Nguyễn Trúc Anh',N'Nữ','0971346779','DUAL_MKT2023',N'Hà Nội'),
('23070721',N'Ninh Trúc Quỳnh',N'Nữ','039223828','IB2023',N'Hà Nội'),
('23070593',N'Lê Thị Ngân',N'Nữ','0964804793','IB2023',N'Hà Nội'),
('23070799',N'Đỗ Đình Thanh',N'Nam','0368041999','IB2023',N'Hà Nội'),
('23070686',N'Trần Yến Ngọc',N'Nữ','0977506783','IB2023',N'Hà Nội')
SELECT * FROM MEMBERS;


INSERT INTO POSITION(IDSV,Tensv,Chucvu,Nganh) VALUES
('21073519',N'Ngô Thúy Hà','PG','ACF2021B'),
('20070365',N'Nguyễn Thị Huyền Trang','IPR','IB2022B'),
('21070199',N'Nguyễn Tuệ Linh','ER','IB2021'),
('23073095',N'Trần Văn Duy','MC-DES','KEUKA'),
('20071030',N'Nguyễn Thùy Linh','MC-CONTENT','DUAL-MKT2020A')
SELECT * FROM POSITION;




--thêm cột --
alter table Position
add Gioitinh nvarchar(50);
SELECT * FROM POSITION;


--drop cột--
Alter table FUNDCOLLECTION
drop column Tinhtrang;
SELECT * FROM FUNDCOLLECTION;


--xóa tv--
DELETE FROM MEMBERS
WHERE IDSV = 20071050;




--update thông tin--
UPDATE ACTIVITIES
SET Diadiem = 'Phòng 514,Trường Quốc Tế - ĐHQGHN, số 1 Trịnh Văn Bô'
WHERE Chude = 'Workshop: Martech- make your hancee';
SELECT * FROM ACTIVITIES;


UPDATE ACTIVITIES
SET Thoigian = '2023-12-20'
WHERE Chude = 'Workshop: RECESSIONS CALL, OPPORTUNITY FOR ALL';
SELECT * FROM ACTIVITIES;


--truy vấn thông tin--
SELECT IDSV, Tensv, Nganh
FROM MEMBERS
WHERE Tensv = N'Nguyễn Chu Nhật Linh'
GROUP BY IDSV, Tensv, Nganh
HAVING Count (Tensv)>=1
ORDER BY Tensv DESC;
SELECT DISTINCT Tensv
FROM MEMBERS;


--sx theo thứ tự nam nữ--
select IDSV as 'Mã số sinh viên',Tensv as 'họ tên sinh viên',Gioitinh as 'Gioi tính',Nganh as'Ngành'
from MEMBERS
order by Gioitinh asc


--tìm tv khóa 2023--
select * from MEMBERS
where Gioitinh=N'nữ' and Nganh like N'%2023%'


--đếm số sv từng ngành--
select Nganh'Ngành','Số sinh viên nam'=count(Gioitinh)
from MEMBERS
where Gioitinh=N'Nam'
group by Nganh
having count(Gioitinh)>=1


--slg sv nam/nữ của từng chức vụ--
select Chucvu,'Tổng sinh viên nam'=sum(case Chucvu when 'MC-DES MEMBER' then 1 else 0
end),'Tổng sinh viên nữ'=sum(case Chucvu when 'MC-DES MEMBER' then 1 else 0 end)
from POSITION
group by Chucvu


--đếm số sv nam,nữ--
select Gioitinh,'Tổng sinh viên nam'=sum(case Gioitinh when N'Nam' then 1 else 0
end),'Tổng sinh viên nữ'=sum(case Gioitinh when N'Nữ' then 1 else 0 end)
from MEMBERS
group by Gioitinh


--tìm địa chỉ--
select IDSV,Tensv
from MEMBERS
where Diachi=( select Diachi
from MEMBERS
where Tensv=N'Cù Thu Uyên')


--tìm sv vs idsv--
Select distinct IDSV, Tensv
From MEMBERS mb
Where Exists(Select distinct Nganh
From MEMBERS
Where IDSV='23073180' and Nganh=mb.Nganh)


--thêm sv bằg câu lệnh procedure--
drop proc themsinhvien1
go
create procedure themsinhvien1
(
@Masv int,
@Tensv nvarchar(50),
@gioitinh nvarchar(10),
@Sodt varchar(10),
@Nganh char(20),
@Diachi nvarchar(30)
)
as
begin
   insert MEMBERS
   values (@Masv, @Tensv, @gioitinh, @Sodt,@Nganh, @Diachi)
   insert MEMBERS (IDSV, Tensv, Gioitinh, Sodt, Nganh, Diachi)
   select  @Masv, @Tensv, @gioitinh, @Sodt,@Nganh, @Diachi
   from MEMBERS
end
go
exec themsinhvien1 '22071081', N'Nguyễn Hà Chi', N'Nữ', '0983445297', 'ICE2022B', 'Hà Nội'



