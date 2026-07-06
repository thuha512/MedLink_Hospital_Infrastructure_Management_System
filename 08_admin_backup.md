# Backup và Restore cơ sở dữ liệu

## Giới thiệu

Tài liệu này hướng dẫn cách sao lưu (Backup) và phục hồi (Restore) cơ sở dữ liệu **MedLink Hospital Device Access**. Việc sao lưu dữ liệu là một trong những nhiệm vụ quan trọng của quản trị cơ sở dữ liệu nhằm đảm bảo dữ liệu có thể được khôi phục khi xảy ra sự cố như mất dữ liệu, lỗi hệ thống hoặc hỏng máy chủ.

Hệ thống được triển khai trên **MySQL 8.0**, do đó có thể sử dụng **MySQL Workbench** hoặc công cụ dòng lệnh **mysqldump** để thực hiện sao lưu và phục hồi.

---

# 1. Sao lưu bằng MySQL Workbench

## Bước 1

Mở **MySQL Workbench** và kết nối tới máy chủ MySQL.

---

## Bước 2

Trên thanh menu chọn:

```
Server
    → Data Export
```

---

## Bước 3

Chọn cơ sở dữ liệu:

```
medlink_hospital_device_access
```

---

## Bước 4

Chọn các tùy chọn sao lưu.

### Export to Self-Contained File

Lưu toàn bộ cơ sở dữ liệu thành một tệp SQL.

Ví dụ:

```
D:\Backup\medlink_backup.sql
```

---

### Export Structure and Data

Chọn:

```
Dump Structure and Data
```

để sao lưu cả cấu trúc bảng và dữ liệu.

---

## Bước 5

Nhấn

```
Start Export
```

Sau khi hoàn thành sẽ nhận được thông báo:

```
Export Completed Successfully.
```

---

# 2. Sao lưu bằng mysqldump

Mở Command Prompt hoặc Terminal.

Thực hiện lệnh:

```bash
mysqldump -u root -p medlink_hospital_device_access > medlink_backup.sql
```

Trong đó:

| Thành phần | Ý nghĩa |
|------------|----------|
| root | Tài khoản MySQL |
| -p | Nhập mật khẩu |
| medlink_hospital_device_access | Tên cơ sở dữ liệu |
| medlink_backup.sql | Tệp sao lưu |

Sau khi nhập mật khẩu, hệ thống sẽ tạo tệp:

```
medlink_backup.sql
```

---

# 3. Chỉ sao lưu cấu trúc (Schema)

Nếu chỉ muốn sao lưu cấu trúc cơ sở dữ liệu mà không bao gồm dữ liệu:

```bash
mysqldump -u root -p --no-data medlink_hospital_device_access > schema_backup.sql
```

Tệp tạo ra:

```
schema_backup.sql
```

chỉ chứa:

- CREATE DATABASE
- CREATE TABLE
- PRIMARY KEY
- FOREIGN KEY
- INDEX
- VIEW
- PROCEDURE
- FUNCTION
- TRIGGER

---

# 4. Chỉ sao lưu dữ liệu

Nếu chỉ muốn sao lưu dữ liệu:

```bash
mysqldump -u root -p --no-create-info medlink_hospital_device_access > data_backup.sql
```

Tệp:

```
data_backup.sql
```

chỉ chứa các câu lệnh:

```sql
INSERT INTO ...
```

---

# 5. Phục hồi cơ sở dữ liệu (Restore)

## Cách 1: MySQL Workbench

Chọn

```
Server
    → Data Import
```

Chọn:

```
Import from Self-Contained File
```

Sau đó chọn

```
medlink_backup.sql
```

Chọn cơ sở dữ liệu đích:

```
medlink_hospital_device_access
```

Nhấn:

```
Start Import
```

Nếu thành công sẽ xuất hiện thông báo:

```
Import Completed Successfully.
```

---

## Cách 2: Command Line

Nếu cơ sở dữ liệu chưa tồn tại:

```sql
CREATE DATABASE medlink_hospital_device_access;
```

Sau đó thực hiện:

```bash
mysql -u root -p medlink_hospital_device_access < medlink_backup.sql
```

Toàn bộ dữ liệu sẽ được phục hồi.

---

# 6. Kiểm tra sau khi Restore

Sau khi phục hồi nên kiểm tra:

## Kiểm tra danh sách bảng

```sql
SHOW TABLES;
```

---

## Kiểm tra số lượng bản ghi

Ví dụ:

```sql
SELECT COUNT(*) FROM Staff;
```

```sql
SELECT COUNT(*) FROM Device;
```

```sql
SELECT COUNT(*) FROM Service;
```

Nếu số lượng bản ghi trùng với cơ sở dữ liệu ban đầu thì quá trình Restore thành công.

---

## Kiểm tra Trigger

```sql
SHOW TRIGGERS;
```

---

## Kiểm tra Procedure

```sql
SHOW PROCEDURE STATUS
WHERE Db='medlink_hospital_device_access';
```

---

## Kiểm tra Function

```sql
SHOW FUNCTION STATUS
WHERE Db='medlink_hospital_device_access';
```

---

## Kiểm tra View

```sql
SHOW FULL TABLES
WHERE TABLE_TYPE='VIEW';
```

---

# 7. Một số lỗi thường gặp

## Lỗi

```
Unknown database
```

Nguyên nhân:

Cơ sở dữ liệu chưa được tạo.

Khắc phục:

```sql
CREATE DATABASE medlink_hospital_device_access;
```

---

## Lỗi

```
Access denied
```

Nguyên nhân:

Sai tài khoản hoặc mật khẩu MySQL.

Khắc phục:

Kiểm tra lại tài khoản và quyền truy cập.

---

## Lỗi

```
ERROR 1062 Duplicate entry
```

Nguyên nhân:

Đã tồn tại dữ liệu trong bảng.

Khắc phục:

```sql
DROP DATABASE medlink_hospital_device_access;

CREATE DATABASE medlink_hospital_device_access;
```

Sau đó Restore lại.

---

## Lỗi

```
ERROR 1215 Cannot add foreign key constraint
```

Nguyên nhân:

Thứ tự tạo bảng không đúng hoặc dữ liệu vi phạm khóa ngoại.

Khắc phục:

Thực hiện Restore từ tệp Backup đầy đủ hoặc kiểm tra lại các ràng buộc khóa ngoại.

---

# 8. Kết luận

Việc sao lưu và phục hồi cơ sở dữ liệu giúp đảm bảo tính an toàn và khả năng khôi phục dữ liệu khi xảy ra sự cố. Đối với hệ thống **MedLink Hospital Device Access**, có thể sử dụng **MySQL Workbench** hoặc công cụ **mysqldump** để thực hiện Backup và Restore một cách nhanh chóng và hiệu quả.

Quản trị viên nên thực hiện sao lưu định kỳ, lưu trữ các bản sao lưu ở vị trí an toàn và kiểm tra khả năng phục hồi dữ liệu nhằm giảm thiểu rủi ro mất mát dữ liệu trong quá trình vận hành hệ thống.
