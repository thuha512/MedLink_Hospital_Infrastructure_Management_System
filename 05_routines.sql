USE medlinkhospital;

-- Xóa Procedure và Function nếu đã tồn tại
DROP PROCEDURE IF EXISTS sp_GrantServiceAccess;
DROP PROCEDURE IF EXISTS sp_ApproveDeviceServer;
DROP FUNCTION IF EXISTS fn_CountStaffServices;

-- PROCEDURE 1: Cấp quyền sử dụng dịch vụ cho nhân sự

DELIMITER $$

CREATE PROCEDURE sp_GrantServiceAccess(
    IN p_staff_id VARCHAR(10),
    IN p_service_code VARCHAR(10)
)
BEGIN
    DECLARE v_staff_exists INT;
    DECLARE v_service_exists INT;
    DECLARE v_access_exists INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    SELECT COUNT(*) INTO v_staff_exists
    FROM Staff
    WHERE staff_id = p_staff_id;

    IF v_staff_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Mã nhân sự không tồn tại.';
    END IF;

    SELECT COUNT(*) INTO v_service_exists
    FROM Service
    WHERE service_code = p_service_code;

    IF v_service_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Mã dịch vụ không tồn tại.';
    END IF;

    SELECT COUNT(*) INTO v_access_exists
    FROM Service_Access
    WHERE staff_id = p_staff_id
      AND service_code = p_service_code;

    IF v_access_exists > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Nhân sự đã có quyền sử dụng dịch vụ này.';
    END IF;

    INSERT INTO Service_Access
    (staff_id, service_code, granted_date)
    VALUES
    (p_staff_id, p_service_code, CURDATE());

    COMMIT;

    SELECT 'Thành công: Đã cấp quyền sử dụng dịch vụ.' AS Result;

END$$

DELIMITER ;

-- PROCEDURE 2: Phê duyệt thiết bị truy cập máy chủ

DELIMITER $$

CREATE PROCEDURE sp_ApproveDeviceServer(
    IN p_device_id VARCHAR(10),
    IN p_server_id VARCHAR(10)
)
BEGIN

    DECLARE v_device_exists INT;
    DECLARE v_server_exists INT;
    DECLARE v_active_access INT;
    DECLARE v_old_access INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    SELECT COUNT(*)
    INTO v_device_exists
    FROM Device
    WHERE device_id = p_device_id;

    IF v_device_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Lỗi: Thiết bị không tồn tại.';
    END IF;

    SELECT COUNT(*)
    INTO v_server_exists
    FROM Server
    WHERE server_id = p_server_id;

    IF v_server_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Lỗi: Máy chủ không tồn tại.';
    END IF;

    SELECT COUNT(*)
    INTO v_active_access
    FROM Device_Server_Approval
    WHERE device_id = p_device_id
      AND server_id = p_server_id
      AND revoked_date IS NULL;

    SELECT COUNT(*)
    INTO v_old_access
    FROM Device_Server_Approval
    WHERE device_id = p_device_id
      AND server_id = p_server_id
      AND revoked_date IS NOT NULL;

    IF v_active_access > 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Lỗi: Thiết bị đã được phê duyệt.';

    ELSEIF v_old_access > 0 THEN

        UPDATE Device_Server_Approval
        SET approval_date = CURDATE(),
            revoked_date = NULL
        WHERE device_id = p_device_id
          AND server_id = p_server_id;

        COMMIT;

        SELECT 'Thành công: Đã kích hoạt lại quyền truy cập.' AS Result;

    ELSE

        INSERT INTO Device_Server_Approval
        (device_id, server_id, approval_date, revoked_date)
        VALUES
        (p_device_id, p_server_id, CURDATE(), NULL);

        COMMIT;

        SELECT 'Thành công: Đã phê duyệt thiết bị truy cập máy chủ.' AS Result;

    END IF;

END$$

DELIMITER ;

-- FUNCTION: Đếm số dịch vụ của nhân sự

DELIMITER $$

CREATE FUNCTION fn_CountStaffServices(
    p_staff_id VARCHAR(10)
)
RETURNS INT
READS SQL DATA
DETERMINISTIC
BEGIN

    DECLARE v_service_count INT DEFAULT 0;

    SELECT COUNT(*)
    INTO v_service_count
    FROM Service_Access
    WHERE staff_id = p_staff_id;

    RETURN v_service_count;

END$$

DELIMITER ;