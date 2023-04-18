/*
4.	������� ������������� (�� ������: ���� � ����������� dbo.vw_SKUPrice� ����� VIEWs) 
���������� ��� �������� ��������� �� ������� dbo.SKU � ��������� ������� �� ���������� ������ �������� (��������� ������� dbo.udf_GetSKUPrice)
*/

USE Test_repository;
GO

IF OBJECT_ID('dbo.vw_SKUPrice') IS NOT NULL DROP VIEW dbo.vw_SKUPrice;
GO

CREATE VIEW dbo.vw_SKUPrice
AS
SELECT ID_identity_SKU, Code, Name, dbo.udf_GetSKUPrice(1) AS value_per_product
FROM dbo.SKU
GO