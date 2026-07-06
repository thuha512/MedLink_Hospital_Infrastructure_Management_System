# MEDLINK HOSPITAL DEVICE ACCESS

> Hệ thống quản lý hạ tầng công nghệ thông tin và quyền truy cập thiết bị trong bệnh viện.

---

# Giới thiệu

**MedLink Hospital Device Access** là dự án xây dựng cơ sở dữ liệu quan hệ nhằm hỗ trợ công tác quản lý hạ tầng công nghệ thông tin trong môi trường bệnh viện. Hệ thống được phát triển trên nền tảng **MySQL 8.0** và tập trung vào việc quản lý nhân sự, thiết bị, máy chủ, dịch vụ CNTT và quyền truy cập của người dùng.

Trong môi trường bệnh viện, số lượng thiết bị CNTT, máy chủ và dịch vụ ngày càng tăng. Nếu không có một hệ thống quản lý tập trung, việc cấp quyền truy cập, quản lý thiết bị và kiểm soát an toàn thông tin sẽ gặp nhiều khó khăn. Vì vậy, dự án này được xây dựng nhằm hỗ trợ quản trị viên theo dõi toàn bộ hạ tầng CNTT, đồng thời đảm bảo dữ liệu được lưu trữ chính xác, nhất quán và an toàn.

Cơ sở dữ liệu được thiết kế theo mô hình quan hệ, áp dụng các nguyên tắc chuẩn hóa dữ liệu, ràng buộc toàn vẹn, Trigger, Stored Procedure, Function, View và Secondary Index để nâng cao hiệu năng truy vấn cũng như khả năng quản trị hệ thống.

---

# Mục tiêu của dự án

Dự án hướng tới các mục tiêu sau:

- Quản lý thông tin khoa/phòng trong bệnh viện.
- Quản lý hồ sơ nhân sự.
- Quản lý tài khoản đăng nhập của nhân viên.
- Quản lý phòng máy và hệ thống máy chủ.
- Quản lý thiết bị CNTT được sử dụng trong bệnh viện.
- Quản lý các dịch vụ CNTT đang hoạt động.
- Kiểm soát quyền sử dụng dịch vụ của từng nhân viên.
- Kiểm tra điều kiện bảo mật của thiết bị trước khi truy cập máy chủ.
- Ghi nhận lịch sử cấp và thu hồi quyền truy cập.
- Hỗ trợ thống kê và khai thác dữ liệu phục vụ quản trị.

---

# Công nghệ sử dụng

| Thành phần | Công nghệ |
|------------|-----------|
| Hệ quản trị CSDL | MySQL 8.0 |
| Công cụ thiết kế | MySQL Workbench |
| Ngôn ngữ | SQL |
| Quản lý mã nguồn | GitHub |
| Tài liệu | Markdown |

---

# Mô hình dữ liệu

Hệ thống bao gồm các nhóm thực thể chính:

## Quản lý tổ chức

- Department
- Staff
- Staff_Account

Nhóm này lưu trữ thông tin về khoa/phòng, nhân viên và tài khoản truy cập hệ thống.

---

## Quản lý hạ tầng CNTT

- Computer_Room
- Server
- Physical_Server
- Virtual_Server
- Service

Các bảng này quản lý hạ tầng máy chủ và các dịch vụ CNTT của bệnh viện.

---

## Quản lý thiết bị

- Device
- Fixed_Workstation
- Mobile_Device

Lưu trữ thông tin về các thiết bị được cấp cho nhân viên.

---

## Quản lý quyền truy cập

- Service_Access
- Device_Server_Approval
- Access_History

Nhóm bảng này chịu trách nhiệm quản lý việc cấp quyền sử dụng dịch vụ, phê duyệt thiết bị và ghi nhận lịch sử truy cập.

---

# Chuẩn hóa dữ liệu

Cơ sở dữ liệu được chuẩn hóa đến **Chuẩn 3 (Third Normal Form – 3NF)**.

Việc chuẩn hóa giúp:

- Giảm dư thừa dữ liệu.
- Tránh bất thường khi cập nhật dữ liệu.
- Đảm bảo tính toàn vẹn.
- Dễ dàng mở rộng trong tương lai.

---

# Các chức năng chính

Hệ thống hỗ trợ:

- Quản lý khoa/phòng.
- Quản lý nhân sự.
- Quản lý tài khoản.
- Quản lý phòng máy.
- Quản lý máy chủ vật lý.
- Quản lý máy chủ ảo.
- Quản lý thiết bị.
- Quản lý dịch vụ CNTT.
- Cấp quyền sử dụng dịch vụ.
- Thu hồi quyền sử dụng dịch vụ.
- Kiểm tra điều kiện bảo mật thiết bị.
- Ghi nhận lịch sử truy cập.
- Thống kê dữ liệu.





## Các thành phần của dự án

### Views

- vw_StaffServiceAccess
- vw_DeviceSecurityStatus

Các View giúp tổng hợp dữ liệu từ nhiều bảng để phục vụ tra cứu và lập báo cáo.

---

### Stored Procedures

- sp_GrantServiceAccess
- sp_ApproveDeviceAccess

Các Procedure hỗ trợ tự động hóa quy trình cấp quyền sử dụng dịch vụ và phê duyệt thiết bị truy cập máy chủ.

---

### Function

- fn_CountStaffServices

Hàm trả về số lượng dịch vụ mà một nhân viên đang được cấp quyền sử dụng.

---

### Triggers

- trg_log_service_access_insert
- trg_log_service_access_delete
- trg_check_mobile_security

Các Trigger được sử dụng để:

- Ghi nhận lịch sử cấp quyền.
- Ghi nhận lịch sử thu hồi quyền.
- Kiểm tra điều kiện bảo mật của thiết bị trước khi cho phép truy cập máy chủ.

---

### Secondary Index

Hệ thống xây dựng hai Secondary Index:

- idx_staff_dept_fullname
- idx_device_registration_date

Các chỉ mục giúp tăng tốc độ tìm kiếm và giảm thời gian thực hiện các truy vấn thường xuyên.

---

## Cấu trúc thư mục

```text
.
├── README.md
├── report.pdf
├── erd.png
├── 01_schema.sql
├── 02_seed_data.sql
├── 03_queries.sql
├── 04_views.sql
├── 05_routines.sql
├── 06_triggers_events.sql
├── 07_indexes_explain.sql
├── 08_admin_backup.md
└── 09_tests.sql
```

---

## Hướng dẫn triển khai

Thực hiện các tệp SQL theo thứ tự sau:

1. `01_schema.sql` – Tạo cơ sở dữ liệu và các bảng.
2. `02_seed_data.sql` – Thêm dữ liệu mẫu.
3. `04_views.sql` – Tạo các View.
4. `05_routines.sql` – Tạo Stored Procedure và Function.
5. `06_triggers_events.sql` – Tạo Trigger.
6. `07_indexes_explain.sql` – Tạo Secondary Index.
7. `09_tests.sql` – Thực hiện các kịch bản kiểm thử.

---

## Sao lưu và phục hồi dữ liệu

Tài liệu hướng dẫn sao lưu và khôi phục cơ sở dữ liệu được trình bày trong:

```
08_admin_backup.md
```

Bao gồm:

- Sao lưu toàn bộ cơ sở dữ liệu.
- Sao lưu cấu trúc.
- Sao lưu dữ liệu.
- Phục hồi cơ sở dữ liệu.
- Kiểm tra sau khi phục hồi.
- Một số lỗi thường gặp.

---

## Kiểm thử

Hệ thống đã được kiểm thử đối với:

- Cấu trúc cơ sở dữ liệu.
- Ràng buộc dữ liệu.
- Trigger.
- Stored Procedure.
- Function.
- View.
- Secondary Index.
- SQL Query Pack.

Kết quả cho thấy các chức năng hoạt động đúng theo yêu cầu thiết kế.

---

## Tài liệu

- Báo cáo đồ án: `report.pdf`
- Sơ đồ ERD: `erd.png`
- Hướng dẫn Backup & Restore: `08_admin_backup.md`

---

## Nhóm thực hiện

**Nhóm 3**

Học phần: **Cơ sở dữ liệu**

Trường Quốc tế – Đại học Quốc gia Hà Nội
