USE [Midterm]
GO
/****** Object:  Table [dbo].[stg_2]    Script Date: 2/25/2024 8:13:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stg_2](
	[Inspection_SK] [int] IDENTITY(1,1) NOT NULL,
	[Inspection ID] [nvarchar](1000) NULL,
	[Facility Name] [nvarchar](1000) NULL,
	[License] [bigint] NULL,
	[Facility Type] [nvarchar](1000) NULL,
	[Inspection Type] [nvarchar](1000) NULL,
	[Inspection_Date] [date] NULL,
	[Inspection Score] [bigint] NULL,
	[Violation Number] [char](1000) NULL,
	[Violation_Category_ID] [nvarchar](1000) NULL,
	[Violation_Description] [nvarchar](1000) NULL,
	[Violation Point] [bigint] NULL,
	[Sum Violation Point] [bigint] NULL,
	[Risk] [nvarchar](1000) NULL,
	[Address] [nvarchar](1000) NULL,
	[City] [varchar](1000) NULL,
	[State] [nvarchar](1000) NULL,
	[Zip Code] [nvarchar](1000) NULL,
	[Results] [nvarchar](1000) NULL,
	[Latitude] [nvarchar](1000) NULL,
	[Longitude] [nvarchar](1000) NULL,
	[DI_CreateDate] [datetime] NULL,
	[DI_WorkflowFileName] [varchar](1000) NULL
) ON [PRIMARY]
GO


-- Creating the Dim_Facility_Type table
CREATE TABLE Dim_Facility (
    FacilitySK INT PRIMARY KEY IDENTITY(1,1), -- Assuming surrogate key with auto-increment
    Facility_Type VARCHAR(1000),
	Facility_Name VARCHAR(1000),
	[Address] VARCHAR(1000),
	City VARCHAR(1000),
	Zip_Code VARCHAR(1000)
);

select * from dim_Inspection_Type;

select * from dim_Results;

ALTER TABLE Dim_Facility
--ALTER COLUMN Facility_Type VARCHAR(1000)
--ALTER COLUMN Facility_Name VARCHAR(1000)
--ALTER COLUMN [Address] VARCHAR(1000)
--ALTER COLUMN City VARCHAR(1000)
ALTER COLUMN Zip_Code VARCHAR(1000)

create database target;





select * from Dim_Facility
-- Creating the Dim_RiskCategory table
CREATE TABLE Dim_RiskCategory (
    RiskSK INT PRIMARY KEY IDENTITY(1,1),
    Risk NVARCHAR(255)
);

-- Creating the Dim_Geo table
CREATE TABLE Dim_Geo (
    GeoSK INT PRIMARY KEY IDENTITY(1,1),
    Address NVARCHAR(255),
    City NVARCHAR(255),
    State NVARCHAR(255),
    ZipCode NVARCHAR(20),
    Latitude FLOAT,
    Longitude FLOAT
);

-- Creating the Dim_Restaurant table
CREATE TABLE Dim_Restaurant (
    RestaurantSK INT PRIMARY KEY IDENTITY(1,1),
    FacilityName NVARCHAR(255),
    Address NVARCHAR(255),
    ZipCode NVARCHAR(20)
);

-- Creating the Dim_Inspection_Type table
CREATE TABLE Dim_Inspection_Type (
    Inspection_TypeSK INT PRIMARY KEY IDENTITY(1,1),
    InspectionType NVARCHAR(255)
);

-- Creating the Dim_Results table
CREATE TABLE Dim_Results (
    ResultsSK INT PRIMARY KEY IDENTITY(1,1),
    Results NVARCHAR(255)
);

-- Creating the Dim_Violation table
CREATE TABLE Dim_Violation (
    ViolationSK INT PRIMARY KEY IDENTITY(1,1),
    Violation_Category_ID INT,
    Violation_Description NVARCHAR(255),
    "Version" NVARCHAR(50)
);

-- Creating the Fact_Inspection table
CREATE TABLE Fact_Inspection (
    InspectionSK INT PRIMARY KEY IDENTITY(1,1),
    InspectionScore DECIMAL(5,2),
    Inspection_Date DATETIME,
    License NVARCHAR(50),
    DL_CreateDate DATETIME,
    DL_WorkflowFileName NVARCHAR(255),
    FacilitySK INT FOREIGN KEY REFERENCES Dim_Facility_Type(FacilitySK),
    RiskSK INT FOREIGN KEY REFERENCES Dim_RiskCategory(RiskSK),
    Inspection_TypeSK INT FOREIGN KEY REFERENCES Dim_Inspection_Type(Inspection_TypeSK),
    RestaurantSK INT FOREIGN KEY REFERENCES Dim_Restaurant(RestaurantSK),
    GeoSK INT FOREIGN KEY REFERENCES Dim_Geo(GeoSK),
    ResultsSK INT FOREIGN KEY REFERENCES Dim_Results(ResultsSK)
);

-- Creating the Fact_Violation table
CREATE TABLE Fact_Violation (
    FactViolationSK INT PRIMARY KEY IDENTITY(1,1),
    Violation_Point INT,
    ViolationSK INT FOREIGN KEY REFERENCES Dim_Violation(ViolationSK),
    InspectionSK INT FOREIGN KEY REFERENCES Fact_Inspection(InspectionSK) -- Assuming that this should reference Fact_Inspection
);

select * from stg_2;

select * from Dim_Facility

create database MidtermFinal;

use MidtermFinal;



