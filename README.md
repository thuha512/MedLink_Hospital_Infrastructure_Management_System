# MedLink_Hospital_Infrastructure_Management_System
# MedLink Hospital Device Access

## Overview

MedLink Hospital Device Access is a relational database project developed for managing the IT infrastructure and access control within a hospital environment. The system supports the management of departments, staff, user accounts, computer rooms, servers, endpoint devices, IT services, and access permissions.

The database is implemented using **MySQL 8.0** and was developed as part of the **Database Systems** course at the **International School – Vietnam National University, Hanoi (VNU-IS)**.

---

## Objectives

The project aims to:

- Manage hospital departments and staff information.
- Manage staff accounts used to access hospital IT services.
- Manage physical and virtual servers.
- Manage fixed workstations and mobile devices.
- Control staff access to IT services.
- Approve devices before accessing hospital servers.
- Record service access history for auditing.
- Improve query performance using secondary indexes.

---

## Database Features

The database contains **14 relational tables** organized into four functional groups:

### Organization and Staff Management
- Department
- Staff
- Staff_Account

### Infrastructure and Service Management
- Computer_Room
- Server
- Physical_Server
- Virtual_Server
- Service

### Device Management
- Device
- Fixed_Workstation
- Mobile_Device

### Access Control and Auditing
- Service_Access
- Device_Server_Approval
- Access_History

The database is normalized to **Third Normal Form (3NF)** to reduce redundancy and maintain data consistency. :contentReference[oaicite:0]{index=0}

---

## Technologies

- MySQL 8.0
- MySQL Workbench
- SQL
- GitHub
- Markdown

---

## Database Design

The project applies standard relational database concepts including:

- Primary Keys
- Foreign Keys
- UNIQUE Constraints
- CHECK Constraints
- Generated Columns
- Secondary Indexes
- Views
- Stored Procedures
- Functions
- Triggers

The database uses **utf8mb4** character encoding to support Unicode characters. :contentReference[oaicite:1]{index=1}

---

## Project Structure

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

## Main Features

### Views

- vw_StaffServiceAccess
- vw_DeviceSecurityStatus

These views simplify reporting by combining data from multiple tables. :contentReference[oaicite:2]{index=2}

---

### Stored Procedures

- sp_GrantServiceAccess
- sp_ApproveDeviceAccess

The procedures validate business rules before modifying data and use transactions to maintain database consistency. :contentReference[oaicite:3]{index=3}

---

### Function

- fn_CountStaffServices

Returns the number of services assigned to a staff member. :contentReference[oaicite:4]{index=4}

---

### Triggers

- trg_log_service_access_insert
- trg_log_service_access_delete
- trg_check_mobile_security

The triggers automatically record access history and enforce security requirements before approving device access. :contentReference[oaicite:5]{index=5}

---

### Indexes

Two secondary indexes are implemented to improve query performance:

- idx_staff_dept_fullname
- idx_device_registration_date

The indexes reduce query execution time for staff and device searches. :contentReference[oaicite:6]{index=6}

---

## Installation

1. Create the database.

```sql
SOURCE 01_schema.sql;
```

2. Insert sample data.

```sql
SOURCE 02_seed_data.sql;
```

3. Create Views.

```sql
SOURCE 04_views.sql;
```

4. Create Procedures and Functions.

```sql
SOURCE 05_routines.sql;
```

5. Create Triggers.

```sql
SOURCE 06_triggers_events.sql;
```

6. Create Indexes.

```sql
SOURCE 07_indexes_explain.sql;
```

7. Execute test scripts.

```sql
SOURCE 09_tests.sql;
```

---

## Backup and Restore

Database backup and recovery procedures are described in:

```
08_admin_backup.md
```

The document includes:

- Full database backup
- Schema-only backup
- Data-only backup
- Restore process
- Verification after restoration
- Common troubleshooting

---

## Testing

The project has been tested for:

- Database creation
- Table creation
- Constraints
- Sample data insertion
- Views
- Stored Procedures
- Functions
- Triggers
- Indexes
- SQL Queries

All tests completed successfully according to the project requirements. :contentReference[oaicite:7]{index=7}

---

## Authors

**Group 3**

International School – Vietnam National University, Hanoi

Database Systems Course

---

## License

This repository is developed for educational purposes only.
