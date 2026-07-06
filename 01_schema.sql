DROP DATABASE IF EXISTS medlinkhospital;
CREATE DATABASE medlinkhospital
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;
USE medlinkhospital;

-- 1. Department
CREATE TABLE Department (
    dept_code VARCHAR(10) NOT NULL,
    dept_name VARCHAR(100) NOT NULL,
    internal_mailbox_code VARCHAR(20) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,

    PRIMARY KEY (dept_code),

    CONSTRAINT uq_department_name
        UNIQUE (dept_name)
) ENGINE = InnoDB;

-- 2. Staff
CREATE TABLE Staff (
    staff_id VARCHAR(10) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    middle_initial VARCHAR(1),
    job_title VARCHAR(100) NOT NULL,
    dept_code VARCHAR(10) NOT NULL,

    PRIMARY KEY (staff_id),

    CONSTRAINT fk_staff_department
        FOREIGN KEY (dept_code)
        REFERENCES Department(dept_code)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
) ENGINE = InnoDB;

-- 3. Staff Account
CREATE TABLE Staff_Account (
    staff_id VARCHAR(10) NOT NULL,
    username VARCHAR(50) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,

    PRIMARY KEY (staff_id),

    CONSTRAINT uq_account_username
        UNIQUE (username),

    CONSTRAINT fk_account_staff
        FOREIGN KEY (staff_id)
        REFERENCES Staff(staff_id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
) ENGINE = InnoDB;

-- 4. Computer Room
CREATE TABLE Computer_Room (
    room_id VARCHAR(10) NOT NULL,
    room_name VARCHAR(100) NOT NULL,

    PRIMARY KEY (room_id)
) ENGINE = InnoDB;

-- 5. Server
CREATE TABLE Server (
    server_id VARCHAR(10) NOT NULL,
    server_name VARCHAR(100) NOT NULL,
    vendor VARCHAR(100) NOT NULL,
    ip_address VARCHAR(45) NOT NULL,
    operating_system VARCHAR(100) NOT NULL,
    room_id VARCHAR(10) NOT NULL,
    server_type ENUM('PHYSICAL','VIRTUAL') NOT NULL,

    PRIMARY KEY (server_id),

    CONSTRAINT uq_server_name
        UNIQUE (server_name),

    CONSTRAINT uq_server_ip
        UNIQUE (ip_address),

    CONSTRAINT fk_server_room
        FOREIGN KEY (room_id)
        REFERENCES Computer_Room(room_id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
) ENGINE = InnoDB;

-- 6. Physical Server
CREATE TABLE Physical_Server (
    server_id VARCHAR(10) NOT NULL,

    PRIMARY KEY (server_id),

    CONSTRAINT fk_physical_server
        FOREIGN KEY (server_id)
        REFERENCES Server(server_id)
        ON UPDATE RESTRICT
        ON DELETE CASCADE
) ENGINE = InnoDB;

-- 7. Virtual Server
CREATE TABLE Virtual_Server (
    server_id VARCHAR(10) NOT NULL,
    host_physical_server_id VARCHAR(10) NOT NULL,

    PRIMARY KEY (server_id),

    CONSTRAINT fk_virtual_server
        FOREIGN KEY (server_id)
        REFERENCES Server(server_id)
        ON UPDATE RESTRICT
        ON DELETE CASCADE,

    CONSTRAINT fk_virtual_host
        FOREIGN KEY (host_physical_server_id)
        REFERENCES Physical_Server(server_id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
) ENGINE = InnoDB;

-- 8. Service
CREATE TABLE Service (
    service_code VARCHAR(10) NOT NULL,
    service_name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    server_id VARCHAR(10) NOT NULL,

    PRIMARY KEY (service_code),

    CONSTRAINT fk_service_server
        FOREIGN KEY (server_id)
        REFERENCES Server(server_id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
) ENGINE = InnoDB;

-- 9. Service Access
CREATE TABLE Service_Access (
    staff_id VARCHAR(10) NOT NULL,
    service_code VARCHAR(10) NOT NULL,
    granted_date DATE NOT NULL,

    PRIMARY KEY (staff_id, service_code),

    CONSTRAINT fk_access_staff
        FOREIGN KEY (staff_id)
        REFERENCES Staff(staff_id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_access_service
        FOREIGN KEY (service_code)
        REFERENCES Service(service_code)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
) ENGINE = InnoDB;

-- 10. Device
CREATE TABLE Device (
    device_id VARCHAR(10) NOT NULL,
    brand VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    registration_date DATE NOT NULL,
    device_type ENUM('FIXED_WORKSTATION','MOBILE_DEVICE') NOT NULL,
    staff_id VARCHAR(10) NOT NULL,

    PRIMARY KEY (device_id),

    CONSTRAINT fk_device_staff
        FOREIGN KEY (staff_id)
        REFERENCES Staff(staff_id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
) ENGINE = InnoDB;

-- 11. Fixed Workstation
CREATE TABLE Fixed_Workstation (
    device_id VARCHAR(10) NOT NULL,
    static_ip_address VARCHAR(45) NOT NULL,
    mac_address VARCHAR(50) NOT NULL,
    building_name VARCHAR(100) NOT NULL,
    room_number VARCHAR(20) NOT NULL,

    PRIMARY KEY (device_id),

    CONSTRAINT uq_fixed_ip
        UNIQUE (static_ip_address),

    CONSTRAINT uq_fixed_mac
        UNIQUE (mac_address),

    CONSTRAINT fk_fixed_device
        FOREIGN KEY (device_id)
        REFERENCES Device(device_id)
        ON UPDATE RESTRICT
        ON DELETE CASCADE
) ENGINE = InnoDB;

-- 12. Mobile Device
CREATE TABLE Mobile_Device (
    device_id VARCHAR(10) NOT NULL,
    serial_number VARCHAR(100) NOT NULL,
    operating_system VARCHAR(100) NOT NULL,
    os_version VARCHAR(50) NOT NULL,
    screen_lock_enabled BOOLEAN NOT NULL,
    data_encryption_enabled BOOLEAN NOT NULL,

    security_eligible BOOLEAN
        GENERATED ALWAYS AS (
            screen_lock_enabled
            AND data_encryption_enabled
        ) STORED,

    PRIMARY KEY (device_id),

    CONSTRAINT uq_mobile_serial
        UNIQUE (serial_number),

    CONSTRAINT fk_mobile_device
        FOREIGN KEY (device_id)
        REFERENCES Device(device_id)
        ON UPDATE RESTRICT
        ON DELETE CASCADE
) ENGINE = InnoDB;

-- 13. Device Server Approval
CREATE TABLE Device_Server_Approval (
    approval_id INT NOT NULL AUTO_INCREMENT,
    device_id VARCHAR(10) NOT NULL,
    server_id VARCHAR(10) NOT NULL,
    approval_date DATE NOT NULL,
    revoked_date DATE NULL,

    PRIMARY KEY (approval_id),

    CONSTRAINT fk_approval_device
        FOREIGN KEY (device_id)
        REFERENCES Device(device_id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_approval_server
        FOREIGN KEY (server_id)
        REFERENCES Server(server_id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT chk_revoked_date
        CHECK (
            revoked_date IS NULL
            OR revoked_date >= approval_date
        )
) ENGINE = InnoDB;

-- 14. Access_History
CREATE TABLE Access_History (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    staff_id VARCHAR(10) NOT NULL,
    service_code VARCHAR(10) NOT NULL,
    action_type ENUM('GRANT','REVOKE') NOT NULL,
    action_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_history_staff
        FOREIGN KEY (staff_id)
        REFERENCES Staff(staff_id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_history_service
        FOREIGN KEY (service_code)
        REFERENCES Service(service_code)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);
