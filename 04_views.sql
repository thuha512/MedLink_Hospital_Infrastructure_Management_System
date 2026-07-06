USE medlinkhospital;
USE medlinkhospital;

-- VIEW 1: Danh sách nhân sự và dịch vụ được cấp quyền

DROP VIEW IF EXISTS vw_staff_service_access;

CREATE VIEW vw_staff_service_access AS
SELECT
    s.staff_id,
    CONCAT(s.last_name, ' ', s.middle_initial, ' ', s.first_name) AS full_name,
    d.dept_name,
    sv.service_name,
    sa.granted_date
FROM Staff s
JOIN Department d
    ON s.dept_code = d.dept_code
JOIN Service_Access sa
    ON s.staff_id = sa.staff_id
JOIN Service sv
    ON sa.service_code = sv.service_code;


-- VIEW 2: Trạng thái bảo mật của thiết bị di động

DROP VIEW IF EXISTS vw_device_security_status;

CREATE VIEW vw_device_security_status AS
SELECT
    d.device_id,
    d.brand,
    d.model,
    m.operating_system,
    m.os_version,

    CASE
        WHEN m.screen_lock_enabled = 1
            THEN 'Đã bật'
        ELSE 'Chưa bật'
    END AS screen_lock_status,

    CASE
        WHEN m.data_encryption_enabled = 1
            THEN 'Đã bật'
        ELSE 'Chưa bật'
    END AS encryption_status,

    CONCAT(s.last_name,' ',s.middle_initial,' ',s.first_name) AS owner_name,
    s.job_title

FROM Device d
JOIN Mobile_Device m
    ON d.device_id = m.device_id
JOIN Staff s
    ON d.staff_id = s.staff_id;
