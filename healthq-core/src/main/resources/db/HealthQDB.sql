CREATE USER IF NOT EXISTS 'test'@'localhost' IDENTIFIED WITH mysql_native_password BY 'test';-- create a test user
grant all privileges on healthq.* to 'test'@'localhost';-- grant a test user privileges

/*
In the future, we could use a different schema for rentbetter core.
Or we can use multiple database schemas.
 */
CREATE DATABASE IF NOT EXISTS healthq;

CREATE TABLE IF NOT EXISTS healthq.doctors
(
    record_id bigint(20) unsigned not null auto_increment,
    id varchar(36) collate utf8mb4_bin not null,
    is_active tinyint(1) default '1',
    first_name varchar(50) collate utf8mb4_bin not null,
    middle_name varchar(50) collate utf8mb4_bin default null,
    last_name varchar(50) collate utf8mb4_bin not null,    
    gender varchar (25) collate utf8mb4_bin not null,  
    date_of_birth date not null,
    email varchar(128) collate utf8mb4_bin default null,
	phone varchar(25) collate utf8mb4_bin default null,
    provider_no varchar(30) collate utf8mb4_bin not null,
   	created_date_time datetime default current_timestamp not null,
    updated_date_time datetime default null,
    primary key (record_id),
    unique key record_id (record_id),
    unique key doctors_id (id)
);-- HealthQ doctors CRM table

CREATE TABLE IF NOT EXISTS healthq.patients
(
    record_id bigint(20) unsigned not null auto_increment,
    id varchar(36) collate utf8mb4_bin not null,
    is_active tinyint(1) default '1',
    first_name varchar(50) collate utf8mb4_bin not null,
    middle_name varchar(50) collate utf8mb4_bin default null,
    last_name varchar(50) collate utf8mb4_bin not null,
    gender varchar (25) collate utf8mb4_bin not null,  
    date_of_birth date not null,
    email varchar(128) collate utf8mb4_bin default null,
	phone varchar(25) collate utf8mb4_bin default null,
    medicare_no varchar(30) collate utf8mb4_bin not null,
   	created_date_time datetime default current_timestamp not null,
    updated_date_time datetime default null,
    primary key (record_id),
    unique key record_id (record_id),
    unique key patients_id (id)
);-- HealthQ patients CRM table

CREATE TABLE IF NOT EXISTS healthq.clinics
(
	record_id bigint(20) unsigned not null auto_increment,
    id varchar(36) collate utf8mb4_bin not null,
    is_active tinyint(1) default '1',
    address1 varchar(100) collate utf8mb4_bin default null,
  	address2 varchar(100) collate utf8mb4_bin default null,
  	suburb varchar(50) collate utf8mb4_bin default null,
  	state varchar(50) collate utf8mb4_bin default null,
  	postcode varchar(16) collate utf8mb4_bin default null,
  	clinic_name varchar(100) collate utf8mb4_bin default null,
  	abn bigint(20) unsigned not null,
   	created_date_time datetime default current_timestamp not null,
    updated_date_time datetime default null,
    primary key (record_id),
    unique key record_id (record_id),
    unique key clinics_id (id)
);-- HealthQ clinics CRM table

CREATE TABLE IF NOT EXISTS healthq.clinic_rooms
(
	record_id bigint(20) unsigned not null auto_increment,
    id varchar(36) collate utf8mb4_bin not null,
    is_active tinyint(1) default '1',
    clinics_id varchar(36) collate utf8mb4_bin not null,
    room_name varchar(100) collate utf8mb4_bin default null,
    created_date_time datetime default current_timestamp not null,
    updated_date_time datetime default null,
    primary key (record_id),
    unique key record_id (record_id),
    unique key clinic_rooms_id (id),
    constraint clinic_rooms_clinics_fk
        foreign key (clinics_id) references healthq.clinics (id) on update cascade on delete restrict
);-- HealthQ clinic rooms table

CREATE TABLE IF NOT EXISTS healthq.patient_queues
(
	record_id bigint(20) unsigned not null auto_increment,
    id varchar(36) collate utf8mb4_bin not null,
    is_active tinyint(1) default '1',
    clinics_id varchar(36) collate utf8mb4_bin not null,
    clinic_rooms_id varchar(36) collate utf8mb4_bin not null,
    doctors_id varchar(36) collate utf8mb4_bin not null,
    started_at datetime default current_timestamp not null,
    ended_at datetime default null,
    created_date_time datetime default current_timestamp not null,
    updated_date_time datetime default null,
    primary key (record_id),
    unique key record_id (record_id),
    unique key patient_queues_id (id),
    constraint patient_queues_clinics_fk
        foreign key (clinics_id) references healthq.clinics (id) on update cascade on delete restrict,
    constraint patient_queues_clinic_rooms_fk
        foreign key (clinic_rooms_id) references healthq.clinic_rooms (id) on update cascade on delete restrict,
   	constraint patient_queues_doctors_fk
        foreign key (doctors_id) references healthq.doctors (id) on update cascade on delete restrict    
);-- HealthQ patient queues table

CREATE TABLE IF NOT EXISTS healthq.patient_queue_requests
(
	record_id bigint(20) unsigned not null auto_increment,
    id varchar(36) collate utf8mb4_bin not null,
    is_active tinyint(1) default '1',
    patients_id varchar(36) collate utf8mb4_bin not null,
    patient_queues_id varchar(36) collate utf8mb4_bin default null,    
    joined_queue_date_time datetime default null,
    left_queue_date_time datetime default null, 
    processed_by_queue_date_time datetime default null,
    created_date_time datetime default current_timestamp not null,
    updated_date_time datetime default null,
    primary key (record_id),
    unique key record_id (record_id),
    unique key patient_queue_requests_id (id),
    constraint patient_queue_requests_patients_fk
        foreign key (patients_id) references healthq.patients (id) on update cascade on delete restrict,
   	constraint patient_queue_requests_patient_queues_fk
        foreign key (patient_queues_id) references healthq.patient_queues (id) on update cascade on delete restrict    
);-- HealthQ patient queue requests table