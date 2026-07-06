USE medlinkhospital;

-- Query 1 (Liệt kê nhân sự thuộc Khoa Tim mạch theo thứ tự họ tên)
SELECT
    staff_id,
    last_name,
    middle_initial,
    first_name,
    job_title
FROM Staff
WHERE dept_code = 'D001'
ORDER BY last_name ASC, first_name ASC;

-- Query 2 (Nhân sự nào thuộc khoa nào và đang được cấp quyền sử dụng những dịch vụ nào ?)
SELECT
    s.staff_id,
    CONCAT(s.last_name, ' ', s.middle_initial, ' ', s.first_name) AS full_name,
    d.dept_name,
    sv.service_name,
    sa.granted_date
FROM Staff s
INNER JOIN Department d ON s.dept_code = d.dept_code
INNER JOIN Service_Access sa ON s.staff_id = sa.staff_id
INNER JOIN Service sv ON sa.service_code = sv.service_code
ORDER BY d.dept_name, full_name;

-- Query 3 (Những dịch vụ nào chưa được cấp quyền cho bất kỳ nhân sự nào?)
SELECT
    s.service_code,
    s.service_name
FROM Service s
LEFT JOIN Service_Access sa
    ON s.service_code = sa.service_code
WHERE sa.staff_id IS NULL;

-- Query 4 ( Máy chủ nào đang cung cấp từ 2 dịch vụ trở lên?)
SELECT
    se.server_id,
    se.server_name,
    COUNT(s.service_code) AS total_services
FROM Server se
INNER JOIN Service s ON se.server_id = s.server_id
GROUP BY
    se.server_id,
    se.server_name
HAVING COUNT(s.service_code) >= 2
ORDER BY total_services DESC;

-- Query 5 ( Nhân sự nào chưa được cấp quyền sử dụng bất kỳ dịch vụ nào? )
SELECT
    staff_id,
    CONCAT(last_name,' ',middle_initial,' ',first_name) AS full_name,
    job_title
FROM Staff s
WHERE NOT EXISTS
(	SELECT *
    FROM Service_Access sa
    WHERE sa.staff_id = s.staff_id
);

-- Query 6 ( Nhân sự nào đang sở hữu từ 2 thiết bị trở lên?)
WITH Device_Count AS
(
    SELECT staff_id, COUNT(device_id) AS total_devices
    FROM Device
    GROUP BY staff_id
)
SELECT
    s.staff_id,
    CONCAT(s.last_name,' ',s.middle_initial,' ',s.first_name) AS full_name,
    dc.total_devices
FROM Device_Count dc
INNER JOIN Staff s ON dc.staff_id = s.staff_id
WHERE dc.total_devices >= 2
ORDER BY dc.total_devices DESC;

-- Query 7 (Thống kê số lượng thiết bị đăng ký theo từng tháng năm 2026)
SELECT
    YEAR(registration_date) AS year,
    MONTH(registration_date) AS month,
    COUNT(*) AS total_devices
FROM Device
WHERE registration_date >= '2026-01-01'
AND registration_date < '2027-01-01'
GROUP BY
    YEAR(registration_date),
    MONTH(registration_date)
ORDER BY
    month;
    
-- Query 8 ( Hiển thị nhân sự và quyền truy cập dịch vụ)
SELECT *
FROM vw_staff_service_access
ORDER BY dept_name,full_name;

-- Query 9 ( Thống kê số lượng nhân sự và thiết bị của từng khoa)
SELECT
    d.dept_name,
    COUNT(DISTINCT s.staff_id) AS total_staff,
    COUNT(DISTINCT dv.device_id) AS total_devices
FROM Department d
LEFT JOIN Staff s
ON d.dept_code=s.dept_code
LEFT JOIN Device dv
ON s.staff_id=dv.staff_id
GROUP BY
    d.dept_code,
    d.dept_name
ORDER BY total_devices DESC;

-- Query 10 (Mỗi máy chủ vật lý hiện đang lưu trữ bao nhiêu máy chủ ảo?)
SELECT
    ps.server_id AS physical_server_id,
    s.server_name,
    COUNT(vs.server_id) AS total_virtual_servers
FROM Physical_Server ps
INNER JOIN Server s
ON ps.server_id=s.server_id
LEFT JOIN Virtual_Server vs
ON ps.server_id=vs.host_physical_server_id
GROUP BY
    ps.server_id,
    s.server_name
ORDER BY total_virtual_servers DESC;