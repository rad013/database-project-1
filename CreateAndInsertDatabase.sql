-- Create Database
CREATE DATABASE RoCALink
GO
USE RoCALink
GO

Create Table TblStaff ( StaffId     Char(5) Primary Key check(StaffId like ('ST[0-9][0-9][0-9]'))
,                       StaffName   Varchar (30) check (len(StaffName)>4)
,                       StaffEmail  Varchar (30) not null Check (StaffEmail like '%@rocalink.com')
,                       StaffPhone  Char (12) not null Check (StaffPhone like '08%')
,                       StaffGender Varchar (6) not null Check (StaffGender in ('Male' , 'Female'))
,                       StaffSalary Money not null )


Create Table TblCustomer ( CustomerId     Char (5) Primary Key check (CustomerId like ('CU[0-9][0-9][0-9]'))
,                          CustomerName   Varchar (30) not null Check (len(CustomerName)>4)
,                          CustomerPhone  Char (12) not null Check (CustomerPhone like '08%')
,                          CustomerGender Varchar (6) not null Check (CustomerGender in ('Male','Female'))
,                          CustomerEmail  Varchar (30) not null Check (CustomerEmail like '%@gmail.com') )

CREATE TABLE TblGroupSet ( GroupSetId         CHAR (5) NOT NULL PRIMARY KEY CHECK (GroupSetId LIKE 'GR[0-9][0-9][0-9]')
,                          GroupSetName       VARCHAR(30) NOT NULL
,                          GearNumber         INT NOT NULL CHECK (GearNumber >=4
AND GearNumber <=12)
,                          WirelessCapability VARCHAR(5) NOT NULL CHECK (WirelessCapability in ('True','False')) )

CREATE TABLE TblBikeBrand ( BikeBrandId      CHAR(5) PRIMARY KEY CHECK (BikeBrandId LIKE 'BR[0-9][0-9][0-9]') NOT NULL
,                           BrandName        VARCHAR(30) NOT NULL
,                           BrandDescription VARCHAR(100) NOT NULL
,                           BrandWebsite     VARCHAR(30) CHECK (BrandWebsite LIKE 'WWW.%') NOT NULL
,                           BrandNationality VARCHAR(30) NOT NULL )

CREATE TABLE TblBikeType ( BikeTypeID   CHAR (5) NOT NULL PRIMARY KEY CHECK (BikeTypeID LIKE 'BT[0-9][0-9][0-9]')
,                          BikeTypeName VARCHAR (30) NOT NULL )

CREATE TABLE TblBike ( BikeId      CHAR(5) PRIMARY KEY CHECK (BikeId LIKE 'BK[0-9][0-9][0-9]') NOT NULL
,                      BikeTypeId  CHAR(5) FOREIGN KEY REFERENCES TblBikeType(BikeTypeId) NOT NULL
,                      BikeBrandId CHAR(5) FOREIGN KEY REFERENCES TblBikeBrand(BikeBrandId) NOT NULL
,                      GroupSetId  CHAR(5) FOREIGN KEY REFERENCES TblGroupSet(GroupSetId) NOT NULL
,                      BikeName    VARCHAR(30) NOT NULL
,                      BikePrice   Money CHECK (BikePrice > 0) NOT NULL )

create table TblTransaction ( TransactionId   CHAR(5) PRIMARY KEY CHECK (TransactionId LIKE 'TR[0-9][0-9][0-9]')
,                             StaffId         CHAR(5) FOREIGN KEY REFERENCES TblStaff(StaffId) NOT NULL
,                             CustomerId      CHAR(5) FOREIGN KEY REFERENCES TblCustomer(CustomerId) NOT NULL
,                             TransactionDate DATE NOT NULL CHECK(TransactionDate <= getdate()) )

create table TblTransactionDetail ( TransactionId CHAR(5) FOREIGN KEY REFERENCES TblTransaction(TransactionId) NOT NULL
,                                   BikeId        CHAR(5) FOREIGN KEY REFERENCES TblBike(BikeId) NOT NULL
,                                   Qty           INT NOT NULL CHECK (Qty > 0)
,                                   PRIMARY KEY(TransactionId, BikeId) )
-- Insert Data into the Database
Insert Into TblStaff ( StaffId, StaffName,  StaffPhone,     StaffEmail,                   StaffGender, StaffSalary )
Values               ( 'ST001', 'David',    '085928592096', 'Davidaja@rocalink.com',      'Male',      7500000     )
,                    ( 'ST002', 'Abeng',    '081479378184', 'Abengobeng@rocalink.com',    'Male',      9000000     )
,                    ( 'ST003', 'Risman',   '081182773722', 'Rismana@rocalink.com',       'Male',      8500000     )
,                    ( 'ST004', 'Hermawan', '082535178560', 'Hermanwan@rocalink.com',     'Male',      8000000     )
,                    ( 'ST005', 'Tanto',    '081324735690', 'Tantohidayat@rocalink.com',  'Male',      7500000     )
,                    ( 'ST006', 'Yahya',    '082146708364', 'Yahyahiyahiya@rocalink.com', 'Male',      9000000     )
,                    ( 'ST007', 'Wendy',    '086651491428', 'Wendysday@rocalink.com',     'Female',    8500000     )
,                    ( 'ST008', 'Ehsan',    '087900384141', 'Ehsanfizi@rocalink.com',     'Male',      8000000     )
,                    ( 'ST009', 'Ijatz',    '087396932363', 'Ijatbicara@rocalink.com',    'Male',      7500000     )
,                    ( 'ST010', 'Oskar',    '086516525519', 'Oskarwantap@rocalink.com',   'Male',      9000000     )
,                    ( 'ST011', 'Patricia', '089840406557', 'Patriciacia@rocalink.com',   'Female',    8500000     )
,                    ( 'ST012', 'Sabrina',  '085134304139', 'Sabrinayes@rocalink.com',    'Female',    8000000     )
,                    ( 'ST013', 'Farell',   '081081084608', 'Farelldelahay@rocalink.com', 'Male',      10000000    )
,                    ( 'ST014', 'Stefany',  '085621647447', 'Stefannie@rocalink.com',     'Female',    9500000     )
,                    ( 'ST015', 'Chelsea',  '088371918876', 'Chelsealand@rocalink.com',   'Female',    9000000     )

Insert Into TblCustomer ( CustomerId, CustomerName, CustomerGender, CustomerPhone,  CustomerEmail               )
Values                  ( 'CU001',    'Renna',      'Female',       '081841052680', 'Renn@gmail.com'            )
,                       ( 'CU002',    'Marika',     'Female',       '082474032133', 'Mar@gmail.com'             )
,                       ( 'CU003',    'Alvian',     'Male',         '082038514624', 'Alviankeren@gmail.com'     )
,                       ( 'CU004',    'Fabio',      'Male',         '088673023885', 'Fabiodeltrame@gmail.com'   )
,                       ( 'CU005',    'Charles',    'Male',         '083506262711', 'Charlesking@gmail.com'     )
,                       ( 'CU006',    'Pedro',      'Male',         '082783272330', 'Pedroacosta@gmail.com'     )
,                       ( 'CU007',    'Sebastian',  'Male',         '085371009514', 'Vebastiansettel@gmail.com' )
,                       ( 'CU008',    'Marco',      'Male',         '082702641815', 'Marcopolo@gmail.com'       )
,                       ( 'CU009',    'Ayunda',     'Female',       '089719548486', 'Ayunda123@gmail.com'       )
,                       ( 'CU010',    'Ranni',      'Female',       '086387572400', 'Rann@gmail.com'            )
,                       ( 'CU011',    'Chloe',      'Female',       '081447740879', 'Chole@gmail.com'           )
,                       ( 'CU012',    'Melina',     'Female',       '082730675863', 'Meli@gmail.com'            )
,                       ( 'CU013',    'Amelia',     'Female',       '086145029306', 'Ameliawhatson@gmail.com'   )
,                       ( 'CU014',    'Malenia',    'Female',       '085148860653', 'Maleni@gmail.com'          )
,                       ( 'CU015',    'Radhan',     'Male',         '089559936943', 'Rad@gmail.com'             )

insert into TblGroupSet ( GroupSetId, GroupSetName, WirelessCapability, GearNumber )
values                  ( 'GR001',    'Shimano',    'True',             '10'       )
,                       ( 'GR002',    'Sram',       'False',            '6'        )
,                       ( 'GR003',    'Campagnolo', 'True',             '8'        )
,                       ( 'GR004',    'Shimano',    'False',            '4'        )
,                       ( 'GR005',    'Sram',       'True',             '9'        )
,                       ( 'GR006',    'Shimano',    'False',            '7'        )
,                       ( 'GR007',    'Sram',       'True',             '8'        )
,                       ( 'GR008',    'Campagnolo', 'True',             '5'        )
,                       ( 'GR009',    'Shimano',    'True',             '12'       )
,                       ( 'GR010',    'Campagnolo', 'False',            '6'        )


insert into TblBikeType ( BikeTypeID, BikeTypeName     )
values                  ( 'BT001',    'Electric Bike'  )
,                       ( 'BT002',    'Fixie Bike'     )
,                       ( 'BT003',    'Folding Bike'   )
,                       ( 'BT004',    'Mountain Bike'  )
,                       ( 'BT005',    'Touring Bike'   )
,                       ( 'BT006',    'Track Bike'     )
,                       ( 'BT007',    'BMX Bike'       )
,                       ( 'BT008',    'Recumbent Bike' )
,                       ( 'BT009',    'Cruiser Bike'   )
,                       ( 'BT010',    'Hybrid Bike'    )

INSERT INTO TblBikeBrand ( BikeBrandId, BrandName,         BrandDescription,                                                                       BrandWebsite,              BrandNationality )
VALUES                   ( 'BR001',     'Avanti Bicycles', 'Australian brand that makes road bikes, mountain bikes and ebikes',                    'www.avantibikes.com',     'Australia'      )
,                        ( 'BR002',     'Canyon',          'Major direct to consumer brand out of Germany',                                        'www.canyon.com',          'Germany'        )
,                        ( 'BR003',     'Erickson Bikes',  'Custom bicycles made in Seattle',                                                      'www.ericksonbikes.com',   'USA'            )
,                        ( 'BR004',     'Kestrel',         'Kestrel is one of the leading manufacturers for dedicated cyclists',                   'www.kestrelbicycles.com', 'USA'            )
,                        ( 'BR005',     'Basso',           'Basso offers a large selection of bikes recommended for the modern cyclist',           'www.bassobikes.com',      'Italy'          )
,                        ( 'BR006',     'Argon 18',        'This manufacturer produces high-end bicycles',                                         'www.argon18bike.com',     'Canada'         )
,                        ( 'BR007',     'Hampsten',        'Seattle based frame builder. Founded in 1999 by Andy and Steve Hampsten',              'www.hampsten.com',        'USA'            )
,                        ( 'BR008',     'Look',            'This manufacturer  offers premium solutions for professional and enthusiast cyclists', 'www.lookcycle.com',       'France'         )
,                        ( 'BR009',     'Marin',           'With a large selection of bikes, the brand offers solutions for all cyclists',         'www.marinbikes.com',      'USA'            )
,                        ( 'BR010',     'Mercier',         'Mercier is one of the manufacturers still believing in the golden age of cycling',     'www.cyclesmercier.com',   'France'         )


INSERT INTO TblBike ( BikeId,  BikeTypeId, BikeBrandId, GroupSetId, BikeName,   BikePrice )
VALUES              ( 'BK001', 'BT002',    'BR002',     'GR004',    'Monza',    213000000 )
,                   ( 'BK002', 'BT002',    'BR001',     'GR002',    'Imola',    137000000 )
,                   ( 'BK003', 'BT005',    'BR007',     'GR001',    'Spectre',  160000000 )
,                   ( 'BK004', 'BT001',    'BR006',     'GR003',    'Xtrada',   75000000  )
,                   ( 'BK005', 'BT004',    'BR002',     'GR004',    'Strattos', 177777777 )
,                   ( 'BK006', 'BT003',    'BR010',     'GR007',    'Sterling', 189000000 )
,                   ( 'BK007', 'BT003',    'BR003',     'GR001',    'Gavril',   100000000 )
,                   ( 'BK008', 'BT001',    'BR009',     'GR004',    'Paradox',  115000000 )
,                   ( 'BK009', 'BT005',    'BR008',     'GR008',    'Helios',   45000000  )
,                   ( 'BK010', 'BT004',    'BR005',     'GR009',    'Epsilon',  67000000  )


insert into TblTransaction ( TransactionId, StaffId, CustomerId, TransactionDate )
values                     ( 'TR001',       'ST001', 'CU007',    '2021-12-05'    )
,                          ( 'TR002',       'ST002', 'CU003',    '2021-12-10'    )
,                          ( 'TR003',       'ST003', 'CU009',    '2021-12-12'    )
,                          ( 'TR004',       'ST004', 'CU013',    '2022-01-16'    )
,                          ( 'TR005',       'ST005', 'CU007',    '2022-01-20'    )
,                          ( 'TR006',       'ST006', 'CU015',    '2022-01-21'    )
,                          ( 'TR007',       'ST007', 'CU003',    '2022-01-22'    )
,                          ( 'TR008',       'ST008', 'CU012',    '2022-01-23'    )
,                          ( 'TR009',       'ST009', 'CU001',    '2022-01-24'    )
,                          ( 'TR010',       'ST010', 'CU010',    '2022-01-25'    )
,                          ( 'TR011',       'ST011', 'CU011',    '2022-01-30'    )
,                          ( 'TR012',       'ST012', 'CU014',    '2022-02-01'    )
,                          ( 'TR013',       'ST013', 'CU005',    '2022-02-05'    )
,                          ( 'TR014',       'ST014', 'CU006',    '2022-02-12'    )
,                          ( 'TR015',       'ST015', 'CU004',    '2022-02-15'    )


insert into TblTransactionDetail ( TransactionId, BikeId,   Qty )
values                           ( 'TR001',       'BK005 ', '2' )
,                                ( 'TR001',       'BK001',  '1' )
,                                ( 'TR002',       'BK001 ', '1' )
,                                ( 'TR002',       'BK002 ', '1' )
,                                ( 'TR003',       'BK003',  '1' )
,                                ( 'TR003',       'BK001',  '1' )
,                                ( 'TR004',       'BK010',  '3' )
,                                ( 'TR004',       'BK003 ', '2' )
,                                ( 'TR005',       'BK002',  '4' )
,                                ( 'TR005',       'BK006',  '2' )
,                                ( 'TR006',       'BK004',  '1' )
,                                ( 'TR006',       'BK006',  '4' )
,                                ( 'TR007',       'BK002',  '2' )
,                                ( 'TR007',       'BK003',  '2' )
,                                ( 'TR008',       'BK002',  '2' )
,                                ( 'TR008',       'BK005',  '3' )
,                                ( 'TR009',       'BK006',  '1' )
,                                ( 'TR009',       'BK009',  '1' )
,                                ( 'TR010',       'BK007',  '1' )
,                                ( 'TR010',       'BK001',  '1' )
,                                ( 'TR011',       'BK002',  '2' )
,                                ( 'TR011',       'BK001',  '2' )
,                                ( 'TR012',       'BK004',  '3' )
,                                ( 'TR012',       'BK008',  '4' )
,                                ( 'TR013',       'BK010',  '4' )
,                                ( 'TR013',       'BK003',  '1' )
,                                ( 'TR014',       'BK007',  '2' )
,                                ( 'TR014',       'BK009',  '1' )
,                                ( 'TR015',       'BK002',  '3' )
,                                ( 'TR015',       'BK010',  '2' )





