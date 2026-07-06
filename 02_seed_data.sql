USE medlinkhospital;

-- 1. Department
INSERT INTO Department (dept_code, dept_name, internal_mailbox_code, phone_number)
VALUES
('D001', 'Khoa Tim mạch', 'MB001', '02438251001'),
('D002', 'Khoa Thần kinh', 'MB002', '02438251002'),
('D003', 'Khoa Chẩn đoán hình ảnh', 'MB003', '02438251003'),
('D004', 'Khoa Xét nghiệm', 'MB004', '02438251004'),
('D005', 'Phòng Hành chính', 'MB005', '02438251005');

-- 2. Staff 
INSERT INTO Staff
(staff_id, last_name, first_name, middle_initial, job_title, dept_code)
VALUES
('S001','Nguyễn','An','V','Bác sĩ','D001'),
('S002','Trần','Bình','Q','Bác sĩ','D001'),
('S003','Lê','Chi','T','Điều dưỡng','D001'),
('S004','Phạm','Dung','H','Điều dưỡng','D001'),
('S021','Nguyễn','Hải','K','Điều dưỡng','D001'),
('S022','Trần','Thảo','M','Kỹ thuật viên','D001'),

('S005','Hoàng','Giang','M','Bác sĩ','D002'),
('S006','Vũ','Hùng','N','Điều dưỡng','D002'),
('S007','Đỗ','Khánh','L','Kỹ thuật viên','D002'),
('S008','Bùi','Lan','P','Bác sĩ','D002'),
('S023','Phạm','Nam','T','Điều dưỡng','D002'),
('S024','Đỗ','Linh','H','Bác sĩ','D002'),

('S009','Ngô','Minh','T','Bác sĩ','D003'),
('S010','Đặng','Phương','A','Kỹ thuật viên','D003'),
('S011','Phan','Quỳnh','H','Điều dưỡng','D003'),
('S012','Lý','Sơn','K','Kỹ thuật viên','D003'),
('S025','Bùi','Phúc','A','Kỹ thuật viên','D003'),
('S026','Võ','Mai','Q','Điều dưỡng','D003'),

('S013','Mai','Trang','Y','Kỹ thuật viên xét nghiệm','D004'),
('S014','Đinh','Tuấn','B','Bác sĩ','D004'),
('S015','Tạ','Uyên','C','Điều dưỡng','D004'),
('S016','Trịnh','Việt','D','Kỹ thuật viên xét nghiệm','D004'),
('S027','Nguyễn','Đức','L','Kỹ thuật viên xét nghiệm','D004'),
('S028','Lê','Hương','N','Điều dưỡng','D004'),

('S017','Nguyễn','Xuân','E','Nhân viên hành chính','D005'),
('S018','Trần','Yến','F','Nhân viên hành chính','D005'),
('S019','Lê','Anh','G','Chuyên viên nhân sự','D005'),
('S020','Phạm','Hà','J','Trưởng phòng Hành chính','D005'),
('S029','Trần','Quân','P','Nhân viên hành chính','D005'),
('S030','Phạm','Yến','B','Chuyên viên nhân sự','D005');


-- 3. Staff Account 
-- Một số nhân viên mới chưa có tài khoản
INSERT INTO Staff_Account
(staff_id, username, password_hash)
VALUES
('S001','an.nguyen','hash001'),
('S002','binh.tran','hash002'),
('S003','chi.le','hash003'),
('S004','dung.pham','hash004'),
('S005','giang.hoang','hash005'),
('S006','hung.vu','hash006'),
('S007','khanh.do','hash007'),
('S008','lan.bui','hash008'),
('S009','minh.ngo','hash009'),
('S010','phuong.dang','hash010'),
('S011','quynh.phan','hash011'),
('S012','son.ly','hash012'),
('S013','trang.mai','hash013'),
('S014','tuan.dinh','hash014'),
('S015','uyen.ta','hash015'),
('S016','viet.trinh','hash016'),
('S017','xuan.nguyen','hash017'),
('S018','yen.tran','hash018'),
('S019','anh.le','hasg019'),
('S020','ha.pham','hash020');


-- 4. Computer Room 
INSERT INTO Computer_Room
(room_id, room_name)
VALUES
('R001','Phòng máy chủ A'),
('R002','Phòng máy chủ B'),
('R003','Phòng máy chủ C');


-- 5. Server
INSERT INTO Server
(server_id, server_name, vendor, ip_address, operating_system, room_id, server_type)
VALUES
('SV001','PHY-HIS-01','Dell','10.10.1.1','Windows Server 2022','R001','PHYSICAL'),
('SV002','PHY-DATA-01','HP','10.10.1.2','Ubuntu Server 24.04','R001','PHYSICAL'),
('SV003','PHY-BACKUP-01','Lenovo','10.10.1.3','Ubuntu Server 24.04','R002','PHYSICAL'),

('SV004','VM-EMR-01','VMware','10.10.2.1','Ubuntu Server 24.04','R001','VIRTUAL'),
('SV005','VM-LAB-01','VMware','10.10.2.2','Ubuntu Server 24.04','R001','VIRTUAL'),
('SV006','VM-APP-01','VMware','10.10.2.3','Windows Server 2022','R002','VIRTUAL'),
('SV007','VM-MAIL-01','VMware','10.10.2.4','Windows Server 2022','R003','VIRTUAL'),
('SV008','VM-CHAT-01','VMware','10.10.2.5','Ubuntu Server 24.04','R003','VIRTUAL');


-- 6. Physical Server
INSERT INTO Physical_Server
(server_id)
VALUES
('SV001'),
('SV002'),
('SV003');


-- 7. Virtual Server
INSERT INTO Virtual_Server
(server_id, host_physical_server_id)
VALUES
('SV004','SV001'),
('SV005','SV001'),
('SV006','SV002'),
('SV007','SV002'),
('SV008','SV003');

-- 8. Service (15 bản ghi)

INSERT INTO Service
(service_code, service_name, start_date, server_id)
VALUES
('SE001','Hệ thống bệnh án điện tử','2025-01-10','SV004'),
('SE002','Hệ thống xét nghiệm','2025-01-15','SV005'),
('SE003','Hệ thống lịch khám','2025-01-20','SV006'),
('SE004','Email nội bộ','2025-02-01','SV007'),
('SE005','Hệ thống nhắn tin','2025-02-05','SV008'),
('SE006','Quản lý dược','2025-02-10','SV004'),
('SE007','Quản lý kho vật tư','2025-02-15','SV005'),
('SE008','Thanh toán viện phí','2025-02-20','SV006'),
('SE009','Quản lý nhân sự','2025-03-01','SV007'),
('SE010','Quản lý lịch trực','2025-03-10','SV008'),
('SE011','Lưu trữ hình ảnh PACS','2025-03-15','SV005'),
('SE012','Báo cáo thống kê','2025-03-20','SV006'),
('SE013','Quản lý tiêm chủng','2025-04-01','SV004'),
('SE014','Quản lý khám ngoại trú','2025-04-10','SV004'),
('SE015','Quản lý hội chẩn','2025-04-20','SV007');

-- 9. Device 
INSERT INTO Device
(device_id, brand, model, registration_date, device_type, staff_id)
VALUES
('DV001','Dell','OptiPlex 7010','2026-01-05','FIXED_WORKSTATION','S001'),
('DV002','HP','EliteDesk 800','2026-01-06','FIXED_WORKSTATION','S002'),
('DV003','Lenovo','ThinkCentre M70','2026-01-07','FIXED_WORKSTATION','S003'),
('DV004','Dell','OptiPlex 7090','2026-01-08','FIXED_WORKSTATION','S004'),
('DV005','HP','ProDesk 600','2026-01-09','FIXED_WORKSTATION','S005'),
('DV006','Lenovo','ThinkCentre M80','2026-01-10','FIXED_WORKSTATION','S006'),
('DV007','Dell','OptiPlex 5000','2026-01-11','FIXED_WORKSTATION','S007'),
('DV008','HP','EliteDesk Mini','2026-01-12','FIXED_WORKSTATION','S008'),

('DV009','Apple','iPhone 15','2026-01-15','MOBILE_DEVICE','S009'),
('DV010','Samsung','Galaxy S24','2026-01-16','MOBILE_DEVICE','S010'),
('DV011','Apple','iPad Air','2026-01-17','MOBILE_DEVICE','S011'),
('DV012','Samsung','Galaxy Tab S9','2026-01-18','MOBILE_DEVICE','S012'),
('DV013','Xiaomi','Pad 6','2026-01-19','MOBILE_DEVICE','S013'),
('DV014','OPPO','Find X8','2026-01-20','MOBILE_DEVICE','S014'),
('DV015','Apple','iPhone 14','2026-01-21','MOBILE_DEVICE','S015'),
('DV016','Samsung','Galaxy A56','2026-01-22','MOBILE_DEVICE','S016'),
('DV017','Apple','iPad Gen 10','2026-01-23','MOBILE_DEVICE','S017'),
('DV018','Xiaomi','Redmi Note 14','2026-01-24','MOBILE_DEVICE','S018'),
('DV019','OPPO','Pad Neo','2026-01-25','MOBILE_DEVICE','S018'),
('DV020','Samsung','Galaxy Tab A9','2026-01-26','MOBILE_DEVICE','S020'),
('DV021','Dell','OptiPlex 7020','2026-02-01','FIXED_WORKSTATION','S001'),
('DV022','HP','EliteDesk 805','2026-02-03','FIXED_WORKSTATION','S006'),
('DV023','Apple','iPhone 16','2026-02-05','MOBILE_DEVICE','S011'),
('DV024','Samsung','Galaxy S25','2026-02-07','MOBILE_DEVICE','S015'),
('DV025','Xiaomi','Pad 7','2026-02-09','MOBILE_DEVICE','S020');


-- 10. Service_Access 
INSERT INTO Service_Access
(staff_id, service_code, granted_date)
VALUES
('S001','SE001','2026-01-05'),
('S001','SE003','2026-01-05'),

('S002','SE001','2026-01-08'),
('S002','SE004','2026-01-08'),

('S003','SE001','2026-01-10'),

('S004','SE002','2026-01-12'),
('S004','SE005','2026-01-12'),

('S005','SE002','2026-01-15'),
('S005','SE007','2026-01-15'),

('S006','SE003','2026-01-18'),
('S006','SE008','2026-01-18'),

('S007','SE002','2026-01-20'),

('S008','SE003','2026-01-22'),

('S009','SE011','2026-01-25'),
('S009','SE012','2026-01-25'),

('S010','SE011','2026-01-28'),

('S011','SE004','2026-02-01'),

('S012','SE006','2026-02-03'),

('S013','SE002','2026-02-05'),

('S016','SE012','2026-02-11'),

('S017','SE009','2026-02-13'),

('S020','SE009','2026-02-19'),

('S003','SE006','2026-02-22'),
('S010','SE005','2026-02-24'),
('S014','SE001','2026-02-26');

-- 11. Device_Server_Approval (20 bản ghi)
INSERT INTO Device_Server_Approval
(device_id, server_id, approval_date, revoked_date)
VALUES
('DV001','SV007','2026-03-01',NULL),
('DV002','SV006','2026-05-02',NULL),
('DV003','SV005','2026-03-03',NULL),
('DV004','SV006','2026-03-04',NULL),
('DV005','SV004','2026-05-03',NULL),
('DV006','SV006','2026-03-06',NULL),
('DV007','SV007','2026-03-07',NULL),
('DV008','SV008','2026-03-08',NULL),

('DV009','SV004','2026-03-09',NULL),
('DV010','SV005','2026-03-10','2026-05-15'),
('DV011','SV006','2026-05-11',NULL),
('DV012','SV007','2026-03-12',NULL),
('DV013','SV008','2026-03-13','2026-06-01'),
('DV014','SV004','2026-03-14',NULL),
('DV015','SV005','2026-03-15',NULL),
('DV016','SV006','2026-03-16',NULL),
('DV017','SV007','2026-03-17',NULL),
('DV018','SV008','2026-03-18',NULL),
('DV019','SV004','2026-03-19',NULL),
('DV020','SV005','2026-03-20',NULL),
('DV021','SV004','2026-04-01',NULL),
('DV021','SV005','2026-04-02',NULL),

('DV022','SV006','2026-04-03',NULL),
('DV022','SV007','2026-04-04',NULL),

('DV023','SV004','2026-04-05',NULL),
('DV023','SV008','2026-04-06',NULL),

('DV024','SV005','2026-04-07',NULL),
('DV024','SV006','2026-04-08','2026-06-15'),

('DV025','SV007','2026-04-09',NULL),
('DV025','SV008','2026-04-10',NULL);


-- 12. Fixed_Workstation 

INSERT INTO Fixed_Workstation
(device_id, static_ip_address, mac_address, building_name, room_number)
VALUES
('DV001','192.168.10.11','00:1A:2B:3C:4D:11','Tòa A','101'),
('DV002','192.168.10.12','00:1A:2B:3C:4D:12','Tòa A','102'),
('DV003','192.168.10.13','00:1A:2B:3C:4D:13','Tòa A','103'),
('DV004','192.168.20.11','00:1A:2B:3C:4D:14','Tòa B','201'),
('DV005','192.168.20.12','00:1A:2B:3C:4D:15','Tòa B','202'),
('DV006','192.168.20.13','00:1A:2B:3C:4D:16','Tòa B','203'),
('DV007','192.168.30.11','00:1A:2B:3C:4D:17','Tòa C','301'),
('DV008','192.168.30.12','00:1A:2B:3C:4D:18','Tòa C','302'),
('DV021','192.168.30.13','00:1A:2B:3C:4D:19','Tòa C','303'),
('DV022','192.168.30.14','00:1A:2B:3C:4D:20','Tòa C','304');


-- 13. Mobile_Device (12 bản ghi)
INSERT INTO Mobile_Device
(device_id, serial_number, operating_system, os_version,
 screen_lock_enabled, data_encryption_enabled)
VALUES
('DV009','APL20260001','iOS','18.1',TRUE,TRUE),
('DV010','SAM20260002','Android','15',TRUE,TRUE),
('DV011','APL20260003','iPadOS','18.1',TRUE,TRUE),
('DV012','SAM20260004','Android','15',TRUE,FALSE),
('DV013','XIA20260005','Android','15',TRUE,TRUE),
('DV014','OPP20260006','Android','15',FALSE,FALSE),
('DV015','APL20260007','iOS','17.6',TRUE,TRUE),
('DV016','SAM20260008','Android','14',TRUE,FALSE),
('DV017','APL20260009','iPadOS','18.0',TRUE,TRUE),
('DV018','XIA20260010','Android','15',TRUE,TRUE),
('DV019','OPP20260011','Android','14',FALSE,TRUE),
('DV020','SAM20260012','Android','15',TRUE,TRUE),
('DV023','APL20260013','iOS','18.2',TRUE,TRUE),
('DV024','SAM20260014','Android','15',TRUE,TRUE),
('DV025','XIA20260015','Android','15',TRUE,FALSE);

