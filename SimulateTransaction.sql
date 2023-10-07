USE RoCALink
-- Simulate Transaction with old customer
begin tran
insert into TblTransaction ( TransactionId, StaffId, CustomerId, TransactionDate )
values                     ( 'TR016',       'ST005', 'CU014',    '2022-06-10'    )

insert into TblTransactionDetail ( TransactionId, BikeId,   Qty )
values                           ( 'TR016',       'BK006 ', '1' )
,                                ( 'TR016',       'BK007',  '1' )
commit

-- Simulate Transaction with new customer
begin tran
Insert Into TblCustomer ( CustomerId, CustomerName, CustomerGender, CustomerPhone,  CustomerEmail        )
Values                  ( 'CU016',    'Rykard',     'Male',         '084449090369', 'Rykarddd@gmail.com' )

Insert into TblTransaction ( TransactionId, StaffId, CustomerId, TransactionDate )
values                     ( 'TR017',       'ST009', 'CU016',    '2022-06-10'    )

Insert into TblTransactionDetail ( TransactionId, BikeID,  Qty )
values                           ( 'TR017',       'BK008', '1' )
,                                ( 'TR017',       'BK010', '2' )
commit
