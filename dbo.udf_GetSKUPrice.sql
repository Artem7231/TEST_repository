/*	
Создать функцию (на выходе: файл в репозитории dbo.udf_GetSKUPrice.sql в ветке Functions) 
-Входной параметр @ID_SKU
-Рассчитывает стоимость передаваемого продукта из таблицы dbo.Basket по формуле сумма Value по переданному SKU / сумма Quantity по переданному SKU
-На выходе значение типа decimal(18, 2)
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

