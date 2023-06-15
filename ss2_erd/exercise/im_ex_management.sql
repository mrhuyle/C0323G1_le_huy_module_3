create database quan_ly_nhap_xuat;

use quan_ly_nhap_xuat;

create table phieu_xuat (
so_px int not null auto_increment primary key,
ngay_xuat date
);

create table phieu_nhap (
so_pn int not null auto_increment primary key,
ngay_nhap date
);


create table vat_tu(
ma_vat_tu int not null auto_increment primary key,
ten_vat_tu varchar(55)
);

create table nha_cung_cap (
ma_nha_cc int not null auto_increment primary key,
ten_nha_cc varchar(55),
dia_chi varchar(55)
);

create table don_dh(
so_dh int not null auto_increment primary key,
ngay_dat_hang date,
ma_nha_cc int,
foreign key (ma_nha_cc) references nha_cung_cap (ma_nha_cc)
);

create table so_dien_thoai(
so_dien_thoai bigint not null primary key,
ma_nha_cc int,
foreign key (ma_nha_cc) references nha_cung_cap (ma_nha_cc)
);

create table chi_tiet_phieu_xuat (
so_px int,
ma_vat_tu int,
don_gia_xuat int,
sl_xuat int,
foreign key (so_px) references phieu_xuat (so_px),
foreign key (ma_vat_tu) references vat_tu (ma_vat_tu),
primary key (so_px, ma_vat_tu)
);

create table chi_tiet_phieu_nhap (
so_pn int,
ma_vat_tu int,
don_gia_nhap int,
sl_nhap int,
foreign key (so_pn) references phieu_nhap (so_pn),
foreign key (ma_vat_tu) references vat_tu (ma_vat_tu),
primary key (so_pn, ma_vat_tu)
);

create table chi_tiet_don_hang (
so_dh int,
ma_vat_tu int,
foreign key (so_dh) references don_dh (so_dh),
foreign key (ma_vat_tu) references vat_tu (ma_vat_tu),
primary key (so_dh, ma_vat_tu)
);