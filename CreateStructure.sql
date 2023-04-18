/*
Создать таблицы (на выходе: файл в репозитории CreateStructure.sql в ветке Tables) 
1. dbo.SKU (ID identity, Code, Name) 
    -Ограничение на уникальность поля Code
    -Поле Code вычисляемое: "s" + ID
2. dbo.Family (ID identity, SurName, BudgetValue)
3. dbo.Basket (ID identity, ID_SKU (внешний ключ на таблицу dbo.SKU), ID_Family (Внешний ключ на таблицу dbo.Family) Quantity, Value, PurchaseDate, DiscountValue) 
    -Ограничение, что поле Quantity и Value не могут быть меньше 0
    -Добавить значение по умолчанию для поля PurchaseDate: дата добавления записи (текущая дата)
*/

USE Test_repository;

--Создание таблицы dbo.SKU
IF OBJECT_ID('dbo.SKU', 'U') IS NOT NULL DROP TABLE dbo.SKU;     

CREATE TABLE dbo.SKU                                              
(
  ID_identity_SKU                 INT             NOT NULL IDENTITY(1,1),
  Code                            NVARCHAR(20)    NOT NULL,
  Name                            NVARCHAR(20)    NOT NULL,                                  
  CONSTRAINT PK_SKU PRIMARY KEY(ID_identity_SKU),
  CONSTRAINT AK_SKU UNIQUE(Code)
);

--Создание таблицы dbo.Family                                                           
IF OBJECT_ID('dbo.Family', 'U') IS NOT NULL DROP TABLE dbo.Family;

CREATE TABLE dbo.Family                                          
(
  ID_identity_Family     INT             NOT NULL IDENTITY(1,1), 
  SurName                NVARCHAR(20)    NOT NULL,                
  BudgetValue            MONEY           NOT NULL,                
  CONSTRAINT CHK_Family_BudgetValue CHECK(BudgetValue >= 0),      
  CONSTRAINT PK_Family PRIMARY KEY(ID_identity_Family)            
);

--Создание таблицы dbo.Basket                                                          
IF OBJECT_ID('dbo.Basket', 'U') IS NOT NULL DROP TABLE dbo.Basket;

CREATE TABLE dbo.Basket
(
  ID_identity_Basket     INT             NOT NULL IDENTITY(1,1),
  ID_SKU                 INT             NOT NULL,                
  ID_Family              INT             NOT NULL,                
  Quantity               INT             NOT NULL,                
  Value                  MONEY           NOT NULL,                
  PurchaseDate           DATETIME        NOT NULL
    CONSTRAINT DFT_PurchaseDate DEFAULT(SYSDATETIME()),
  DiscountValue          MONEY           NOT NULL,             
  CONSTRAINT FK_Basket_SKU FOREIGN KEY(ID_SKU)                    
    REFERENCES dbo.SKU(ID_identity_SKU),                          
  CONSTRAINT FK_Basket_Family FOREIGN KEY(ID_Family)              
    REFERENCES dbo.Family(ID_identity_Family),                    
  CONSTRAINT CHK_Basket_Value CHECK(Value >= 0),                  
  CONSTRAINT CHK_Basket_DiscountValue CHECK(DiscountValue >= 0)   
);
