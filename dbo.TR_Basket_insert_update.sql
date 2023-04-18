--====================================
--������� ������� (�� ������: ���� � ����������� dbo.TR_Basket_insert_update � ����� Triggers)
--���� � ������� dbo.Basket �� ��� ����������� 2 � ����� ������� ������ ID_SKU, �� �������� � ���� DiscountValue,
--��� ����� ID_SKU �������������� �� ������� Value * 5%, ����� DiscountValue = 0
--====================================

USE Test_repository
GO

IF OBJECT_ID('dbo.TR_Basket_insert_update') IS NOT NULL DROP TRIGGER dbo.TR_Basket_insert_update;
GO

CREATE TRIGGER dbo.TR_Basket_insert_update ON dbo.Basket 
	FOR INSERT 
AS 
IF @@ROWCOUNT < 2
    INSERT INTO dbo.Basket(DiscountValue) VALUES(0)
	RETURN
BEGIN
    DECLARE @idfortrigger INT
	DECLARE @valuefortrigger DECIMAL(18,2)
	SELECT @valuefortrigger = Value * 0.05
	FROM dbo.Basket
	WHERE @idfortrigger = ID_SKU
    INSERT INTO dbo.Basket(DiscountValue) VALUES(@valuefortrigger)
END
GO
