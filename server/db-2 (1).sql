
CREATE DATABASE cua_hang_banh_mi
\c cua_hang_banh_mi;

CREATE TABLE kho_nguyen_lieu (
  id_nguyen_lieu SERIAL PRIMARY KEY,
  ten VARCHAR(255),
  so_luong INTEGER,
  don_vi VARCHAR(10)
);

CREATE TABLE nha_cung_cap (
  id_nha_cung_cap SERIAL PRIMARY KEY,
  ten_nha_cung_cap VARCHAR(255),
  so_dien_thoai VARCHAR(10)
);

CREATE TABLE nhan_vien (
  id_nhan_vien SERIAL PRIMARY KEY,
  ho_ten VARCHAR(255),
  so_dien_thoai VARCHAR(10),
  email VARCHAR(255),
  gioi_tinh VARCHAR(10),
  ngay_sinh DATE
);

CREATE TABLE don_nhap_nguyen_lieu (
  id_don SERIAL PRIMARY KEY,
  id_nha_cung_cap SERIAL,
  id_nhan_vien SERIAL,
  thoi_gian_thanh_toan DATE,
  tong_tien INTEGER,
  FOREIGN KEY (id_nha_cung_cap) REFERENCES nha_cung_cap(id_nha_cung_cap),
  FOREIGN KEY (id_nhan_vien) REFERENCES nhan_vien(id_nhan_vien)
);

CREATE TABLE chi_tiet_don_nhap (
  id_don INTEGER,
  id_nguyen_lieu SERIAL,
  so_luong INTEGER,
  gia_don_vi INTEGER,
  FOREIGN KEY (id_nguyen_lieu) REFERENCES kho_nguyen_lieu(id_nguyen_lieu),
  FOREIGN KEY (id_don) REFERENCES don_nhap_nguyen_lieu(id_don)
);



CREATE TABLE san_pham (
  id_san_pham SERIAL PRIMARY KEY,
  ten VARCHAR(255),
  gia INTEGER
);

CREATE TABLE lam_tu (
  id_san_pham SERIAL,
  id_nguyen_lieu SERIAL,
  CONSTRAINT FK_lam_tu_id_san_pham FOREIGN KEY (id_san_pham) REFERENCES san_pham(id_san_pham),
  CONSTRAINT FK_lam_tu_id_nguyen_lieu FOREIGN KEY (id_nguyen_lieu) REFERENCES kho_nguyen_lieu(id_nguyen_lieu)
);

create table hoa_don (
    id_hoa_don serial primary key,
    id_nhan_vien int,
    thoi_gian_thanh_toan timestamp,
    tong_tien int,
    foreign key (id_nhan_vien) references nhan_vien(id_nhan_vien)
);

create table chi_tiet_hoa_don (
    id_hoa_don int,
    id_san_pham int,
    so_luong int,
    foreign key (id_hoa_don) references hoa_don(id_hoa_don),
    foreign key (id_san_pham) references san_pham(id_san_pham)
);




INSERT INTO nhan_vien (ho_ten, so_dien_thoai, email, gioi_tinh, ngay_sinh)
VALUES
  ('Nguyen Van A', '0123456789', 'nguyenvana@example.com', 'Nam', '1990-01-01'),
  ('Tran Thi B', '0987654321', 'tranthib@example.com', 'Nu', '1992-05-15'),
  ('Pham Van C', '0369876543', 'phamvanc@example.com', 'Nam', '1988-09-30'),
  ('Le Thi D', '0765432198', 'lethid@example.com', 'Nu', '1995-12-10'),
  ('Hoang Van E', '0932165478', 'hoangvane@example.com', 'Nam', '1993-07-20');


INSERT INTO san_pham (ten, gia)
VALUES
  ('banh_mi_trung', 20000),
  ('banh_mi_xuc_xich', 25000),
  ('banh_mi_bo', 28000),
  ('banh_mi_ruoc', 18000),
  ('banh_mi_pate', 22000),
  ('banh_mi_thit_nguoi', 23000),
  ('banh_mi_heo_quay', 30000),
  ('banh_mi_cha_lua', 15000),
  ('banh_mi_sua_dac', 20000),
  ('banh_mi_xiu_mai', 27000);

INSERT INTO kho_nguyen_lieu (ten, so_luong, don_vi)
VALUES
  ('banh_mi', 1000, 'cai'),
  ('trung', 500, 'qua'),
  ('thit_bo', 200, 'kg'),
  ('thit_lon', 300, 'kg'),
  ('giam_bong', 100, 'kg'),
  ('cha_gio', 800, 'cai'),
  ('rau_xa_lach', 5, 'kg'),
  ('rau_mui', 2, 'kg'),
  ('dua_gop', 200, 'kg'),
  ('ruoc', 100, 'kg'),
  ('muoi', 50, 'kg'),
  ('duong', 100, 'kg'),
  ('nuoc_mam', 200, 'chai'),
  ('ot', 300, 'kg'),
  ('tuong_ot', 50, 'chai'),
  ('mi_chinh', 30, 'kg'),
  ('thit_ga', 150, 'kg'),
  ('ngo', 100, 'kg'),
  ('xuc_xich', 80, 'kg'),
  ('sua_dac', 50, 'chai');

INSERT INTO nha_cung_cap (id_nha_cung_cap, ten_nha_cung_cap, so_dien_thoai)
VALUES
  (1, 'Nha cung cap A', '0123456789'),
  (2, 'Nha cung cap B', '0987654321'),
  (3, 'Nha cung cap C', '0369876543'),
  (4, 'Nha cung cap D', '0765432198'),
  (5, 'Nha cung cap E', '0932165478');

INSERT INTO don_nhap_nguyen_lieu (id_don, id_nha_cung_cap, id_nhan_vien, thoi_gian_thanh_toan, tong_tien)
VALUES
  (1, 1, 1, '2023-07-01', 1600000),
  (2, 2, 2, '2023-07-02', 1250000),
  (3, 3, 3, '2023-07-03', 1400000),
  (4, 4, 4, '2023-07-04', 1180000),
  (5, 5, 1, '2023-07-05', 675000);

INSERT INTO chi_tiet_don_nhap (id_don, id_nguyen_lieu, so_luong, gia_don_vi)
VALUES
  (1, 1, 50, 10000),
  (1, 2, 100, 5000),
  (1, 3, 20, 30000),
  (2, 4, 30, 15000),
  (2, 5, 40, 20000),
  (3, 6, 80, 10000),
  (3, 7, 10, 50000),
  (3, 8, 5, 20000),
  (4, 9, 60, 8000),
  (4, 10, 70, 10000),
  (5, 11, 25, 12000),
  (5, 12, 15, 25000);


INSERT INTO lam_tu (id_san_pham, id_nguyen_lieu)
VALUES
  (1, 1),
  (1, 2),
  (1, 7),
  (1, 9),
  (2, 1),
  (2, 19),
  (2, 14),
  (2, 15),
  (3, 1),
  (3, 3),
  (3, 15),
  (3, 7),
  (4, 1),
  (4, 5),
  (4, 8),
  (4, 10),
  (5, 1),
  (5, 6),
  (5, 7),
  (5, 10);
