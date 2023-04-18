/*
Создать процедуру (на выходе: файл в репозитории dbo.usp_MakeFamilyPurchase в ветке Procedures) 
-Входной параметр (@FamilySurName varchar(255)) одно из значений аттрибута SurName таблицы dbo.Family
-Процедура при вызове обновляет данные в таблицы dbo.Family в поле BudgetValue по логике
      1. dbo.Family.BudgetValue - sum(dbo.Basket.Value), где dbo.Basket.Value покупки для переданной в процедуру семьи
      2. При передаче несуществующего dbo.Family.SurName пользователю выдается ошибка, что такой семьи нет.
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
    -- Тело процедуры
	IF @FamilySurName NOT IN (SELECT SurName FROM dbo.Family)
	BEGIN
	    SELECT 'Такой семьи нет!'
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