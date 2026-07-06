USE medlinkhospital;

-- Trigger ghi nhận lịch sử thay đổi quyền truy cập

DROP TRIGGER IF EXISTS trg_log_service_access_insert;
DROP TRIGGER IF EXISTS trg_log_service_access_delete;

DELIMITER $$
CREATE TRIGGER trg_log_service_access_insert
AFTER INSERT ON Service_Access
FOR EACH ROW
BEGIN

    INSERT INTO Access_History
    (staff_id, service_code, action_type)
    
    
    
    
    VALUES
    (NEW.staff_id, NEW.service_code,'GRANT');

END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER trg_log_service_access_delete
AFTER DELETE ON Service_Access
FOR EACH ROW
BEGIN

    INSERT INTO Access_History
    (staff_id, service_code, action_type)
    VALUES
    (OLD.staff_id, OLD.service_code, 'REVOKE');

END$$
DELIMITER ;

-- Trigger kiểm tra điều kiện bảo mật thiết bị
DROP TRIGGER IF EXISTS trg_check_mobile_security;

DELIMITER $$

CREATE TRIGGER trg_check_mobile_security
BEFORE INSERT
ON Device_Server_Approval
FOR EACH ROW
BEGIN
    DECLARE v_device_type VARCHAR(30);
    DECLARE v_security BOOLEAN;

    SELECT device_type
    INTO v_device_type
    FROM Device
    WHERE device_id = NEW.device_id;

    IF v_device_type = 'MOBILE_DEVICE' THEN

        SELECT security_eligible
        INTO v_security
        FROM Mobile_Device
        WHERE device_id = NEW.device_id;

        IF v_security = FALSE THEN

            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            'Khong the cap quyen: thiet bi di dong chua dat yeu cau bao mat';

        END IF;

    END IF;

END$$

DELIMITER ;
