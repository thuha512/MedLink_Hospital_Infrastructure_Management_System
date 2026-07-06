USE medlinkhospital;

-- Index 1: Hỗ trợ tìm kiếm nhân sự theo khoa và sắp xếp theo họ tên
CREATE INDEX idx_staff_dept_fullname
ON Staff(dept_code, last_name, middle_initial, first_name);

-- Index 2: Hỗ trợ truy vấn theo ngày đăng ký thiết bị
CREATE INDEX idx_device_registration_date
ON Device(registration_date);

-- Kiểm tra các index đã tạo
SHOW INDEX FROM Staff;
SHOW INDEX FROM Device;

-- Kiểm tra execution plan của Query 1
EXPLAIN
SELECT
    staff_id,
    last_name,
    middle_initial,
    first_name,
    job_title
FROM Staff
WHERE dept_code = 'DEP002'
ORDER BY last_name, middle_initial, first_name;

-- Kiểm tra execution plan của Query 7
EXPLAIN
SELECT
    device_id,
    registration_date
FROM Device
WHERE registration_date >= '2026-01-01'
  AND registration_date < '2027-01-01'
ORDER BY registration_date;