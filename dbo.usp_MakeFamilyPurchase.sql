/*
������� ��������� (�� ������: ���� � ����������� dbo.usp_MakeFamilyPurchase � ����� Procedures) 
-������� �������� (@FamilySurName varchar(255)) ���� �� �������� ��������� SurName ������� dbo.Family
-��������� ��� ������ ��������� ������ � ������� dbo.Family � ���� BudgetValue �� ������
      1. dbo.Family.BudgetValue - sum(dbo.Basket.Value), ��� dbo.Basket.Value ������� ��� ���������� � ��������� �����
      2. ��� �������� ��������������� dbo.Family.SurName ������������ �������� ������, ��� ����� ����� ���.
*/

USE Test_repository;
GO

IF OBJECT_ID('dbo.usp_MakeFamilyPurchase') IS NOT NULL DROP PROCEDURE dbo.usp_MakeFamilyPurchase;
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE dbo.usp_MakeFamilyPurchase
     @FamilySurName VARCHAR(255)
AS
BEGIN
	SET NOCOUNT ON;
    -- ���� ���������
	IF @FamilySurName NOT IN (SELECT SurName FROM dbo.Family)
	BEGIN
	    SELECT '����� ����� ���!'
		RETURN
	END
	
	DECLARE @result INT
	SELECT @result = (df.BudgetValue - SUM(db.Value))
	FROM dbo.Family AS df
	  JOIN dbo.Basket AS db
	    ON df.ID_identity_Family = db.ID_Family
     WHERE df.SurName = @FamilySurName 
	 GROUP BY df.SurName, df.BudgetValue 

	 INSERT INTO dbo.Basket(Value) VALUES(@result)
	
END
GO

/*
	SELECT @result = (dbo.Family.BudgetValue - SUM(dbo.Basket.Value))
	FROM dbo.Family, dbo.Basket
    WHERE dbo.Family.SurName = @FamilySurName 
	GROUP BY dbo.Family.SurName, dbo.Family.BudgetValue;
*/