-- Employee Dimension Table (Type 2)
-- Tracks employee information with historical records for any changes in employment.
CREATE TABLE Dim_Employee (
    employee_key INT PRIMARY KEY IDENTITY(1,1),
    employee_nic VARCHAR(15) NOT NULL,   -- Natural Key, National ID
    employee_name VARCHAR(100) NOT NULL,
    designation VARCHAR(50),
    employment_from_date DATE NOT NULL,
    employment_to_date DATE,
    passport_no VARCHAR(20),
    tin VARCHAR(20),                     -- Taxpayer Identification Number
    income_tax_file_no VARCHAR(20),
    is_current_record TINYINT DEFAULT 1, -- Using TINYINT for boolean representation
    start_date DATETIME DEFAULT CURRENT_TIMESTAMP, 
    end_date DATETIME                          
);  

-- Remuneration Fact Table
-- Records remuneration details of employees for analysis.
CREATE TABLE Fact_Remuneration (
    remuneration_id INT PRIMARY KEY IDENTITY(1,1),  -- Use IDENTITY for auto-increment in SQL Server
    employee_key INT NOT NULL,
    employment_from_date_key DATE,         -- Foreign key to Dim_Date for analysis purposes
    employment_to_date_key DATE,           -- Foreign key to Dim_Date for analysis purposes
    cash_payment DECIMAL(15, 2),           -- Cash Payments
    non_cash_benefits DECIMAL(15, 2),      -- Non-Cash Benefits
    total_remuneration DECIMAL(15, 2),     -- Total Remuneration
    total_tax_exempt_income DECIMAL(15, 2),-- Total Tax-Exempt Income
    FOREIGN KEY (employee_key) REFERENCES Dim_Employee(employee_key),
    FOREIGN KEY (employment_from_date_key) REFERENCES Dim_Date(date_key),
    FOREIGN KEY (employment_to_date_key) REFERENCES Dim_Date(date_key)
);

-- Tax Deduction Fact Table
-- Captures all tax deductions under different sections and the total deducted.
CREATE TABLE Fact_Tax_Deduction (
    deduction_id INT PRIMARY KEY IDENTITY(1,1),
    employee_key INT NOT NULL,
    deduction_date_key DATE,                    -- Foreign key to Dim_Date
    tax_deducted_section_114 DECIMAL(15, 2),    -- Tax deducted under Section 114
    tax_deducted_section_117 DECIMAL(15, 2),    -- Tax deducted under Section 117 and 117A
    total_tax_deducted DECIMAL(15, 2),          -- Total Tax Deducted
    FOREIGN KEY (employee_key) REFERENCES Dim_Employee(employee_key),
    FOREIGN KEY (deduction_date_key) REFERENCES Dim_Date(date_key)
);

-- Date Dimension Table
-- Provides a calendar hierarchy for employment dates to enable time-based analysis.
CREATE TABLE Dim_Date (
    date_key DATE PRIMARY KEY,
    day INT,
    month INT,
    quarter INT,
    year INT,
    day_name VARCHAR(10),
    month_name VARCHAR(15),
    is_weekend TINYINT DEFAULT 0, -- Using TINYINT for boolean representation
);

