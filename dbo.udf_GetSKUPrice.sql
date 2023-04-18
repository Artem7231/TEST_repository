/*	
������� ������� (�� ������: ���� � ����������� dbo.udf_GetSKUPrice.sql � ����� Functions) 
-������� �������� @ID_SKU
-������������ ��������� ������������� �������� �� ������� dbo.Basket �� ������� ����� Value �� ����������� SKU / ����� Quantity �� ����������� SKU
-�� ������ �������� ���� decimal(18, 2)
*/
USE Test_repository;
GO

IF OBJECT_ID('dbo.udf_GetSKUPrice') IS NOT NULL DROP FUNCTION dbo.udf_GetSKUPrice;
GO

CREATE FUNCTION udf_GetSKUPrice
(
@ID_SKU INT
) 
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @result DECIMAL(18, 2)

    SELECT @result = SUM(Value)/SUM(Quantity)
	FROM dbo.Basket
	WHERE ID_SKU = @ID_SKU
	RETURN @result
END
GO

