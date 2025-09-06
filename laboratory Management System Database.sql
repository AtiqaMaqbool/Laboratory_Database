-- Laboratory Management System Database Schema
-- Author: Atiqa (based on project description)
-- Engine: MySQL

CREATE DATABASE IF NOT EXISTS lab_management;
USE lab_management;

-- =========================
-- 1. LABORATORY
-- =========================
CREATE TABLE Laboratory (
    license_number VARCHAR(20) PRIMARY KEY,
    name           VARCHAR(100) NOT NULL,
    address        VARCHAR(255) NOT NULL
);

-- =========================
-- 2. LABORATORIAN
-- =========================
CREATE TABLE Laboratorian (
    laboratorian_id INT PRIMARY KEY AUTO_INCREMENT,
    name            VARCHAR(100) NOT NULL,
    address         VARCHAR(255) NOT NULL,
    salary          DECIMAL(10,2) NOT NULL,
    phone_number    VARCHAR(20),
    license_number  VARCHAR(20) NOT NULL,
    FOREIGN KEY (license_number) REFERENCES Laboratory(license_number)
);

-- =========================
-- 3. PATIENT
-- =========================
CREATE TABLE Patient (
    patient_id   INT PRIMARY KEY AUTO_INCREMENT,
    name         VARCHAR(100) NOT NULL,
    address      VARCHAR(255) NOT NULL,
    age          INT CHECK (age >= 0),
    gender       ENUM('Male','Female') NOT NULL,
    phone_number VARCHAR(20)
);

-- =========================
-- 4. TEST
-- =========================
CREATE TABLE Test (
    test_id    INT PRIMARY KEY AUTO_INCREMENT,
    name       VARCHAR(100) NOT NULL,
    price      DECIMAL(10,2) NOT NULL
);

-- =========================
-- 5. AGREEMENT
-- =========================
CREATE TABLE Agreement (
    agreement_number INT PRIMARY KEY AUTO_INCREMENT,
    lab_from         VARCHAR(20) NOT NULL,
    lab_to           VARCHAR(20) NOT NULL,
    FOREIGN KEY (lab_from) REFERENCES Laboratory(license_number),
    FOREIGN KEY (lab_to)   REFERENCES Laboratory(license_number)
);

-- Agreement ↔ Test (many-to-many)
CREATE TABLE Agreement_Test (
    agreement_number INT NOT NULL,
    test_id          INT NOT NULL,
    PRIMARY KEY (agreement_number, test_id),
    FOREIGN KEY (agreement_number) REFERENCES Agreement(agreement_number),
    FOREIGN KEY (test_id) REFERENCES Test(test_id)
);

-- =========================
-- 6. SAMPLE
-- =========================
CREATE TABLE Sample (
    sample_number   INT PRIMARY KEY AUTO_INCREMENT,
    date_taken      DATE NOT NULL,
    time_taken      TIME NOT NULL,
    type            VARCHAR(50) NOT NULL,
    temperature     DECIMAL(5,2),
    license_number  VARCHAR(20) NOT NULL,
    FOREIGN KEY (license_number) REFERENCES Laboratory(license_number)
);

-- Sample ↔ Patient (many-to-many)
CREATE TABLE Sample_Patient (
    sample_number INT NOT NULL,
    patient_id    INT NOT NULL,
    PRIMARY KEY (sample_number, patient_id),
    FOREIGN KEY (sample_number) REFERENCES Sample(sample_number),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

-- Sample ↔ Laboratorian (many-to-many)
CREATE TABLE Sample_Laboratorian (
    sample_number   INT NOT NULL,
    laboratorian_id INT NOT NULL,
    PRIMARY KEY (sample_number, laboratorian_id),
    FOREIGN KEY (sample_number) REFERENCES Sample(sample_number),
    FOREIGN KEY (laboratorian_id) REFERENCES Laboratorian(laboratorian_id)
);

-- Sample ↔ Test (many-to-many)
CREATE TABLE Sample_Test (
    sample_number INT NOT NULL,
    test_id       INT NOT NULL,
    PRIMARY KEY (sample_number, test_id),
    FOREIGN KEY (sample_number) REFERENCES Sample(sample_number),
    FOREIGN KEY (test_id) REFERENCES Test(test_id)
);

-- =========================
-- 7. RECEIPT
-- =========================
CREATE TABLE Receipt (
    receipt_number INT PRIMARY KEY AUTO_INCREMENT,
    receipt_date   DATE NOT NULL,
    receipt_time   TIME NOT NULL,
    patient_id     INT NOT NULL,
    test_id        INT NOT NULL,
    charges        DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (test_id) REFERENCES Test(test_id)
);

-- =========================
-- 8. REPORT
-- =========================
CREATE TABLE Report (
    report_number INT PRIMARY KEY AUTO_INCREMENT,
    report_time   TIME NOT NULL,
    report_date   DATE NOT NULL,
    result        TEXT NOT NULL,
    patient_id    INT NOT NULL,
    test_id       INT NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (test_id) REFERENCES Test(test_id)
);
SHOW TABLES;
DESCRIBE Laboratory;
INSERT INTO Laboratory (license_number, name, address)
VALUES ('LAB001', 'Central Lab', '123 Main Street');

SELECT * FROM Laboratory;