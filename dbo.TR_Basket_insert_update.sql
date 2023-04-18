--====================================
--Создать триггер (на выходе: файл в репозитории dbo.TR_Basket_insert_update в ветке Triggers)
--Если в таблицу dbo.Basket за раз добавляются 2 и более записей одного ID_SKU, то значение в поле DiscountValue,
--для этого ID_SKU рассчитывается по формуле Value * 5%, иначе DiscountValue = 0
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
