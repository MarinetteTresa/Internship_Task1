USE [AdventureWorks2014]
GO

/****** Object:  StoredProcedure [dbo].[usp_sales_20210222]    Script Date: 28/02/2021 6:05:55 pm ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[usp_sales_20210222]
	@SalesPersonID INT = NULL,
	@SalesCount INT OUTPUT
AS
BEGIN
  IF @SalesPersonID IS NULL
  BEGIN
	SELECT  
		SalesPersonID, 
		ROUND(TotalDue, 2) AS SalesAmount
	FROM 
		Sales.SalesOrderHeader
	ORDER BY TotalDue DESC
  END
  ELSE
  BEGIN
	SELECT  
		SalesPersonID, 
		ROUND(TotalDue, 2) AS SalesAmount
	FROM 
		Sales.SalesOrderHeader
	WHERE 
		SalesPersonID = @SalesPersonID
	ORDER BY TotalDue DESC
  END

  select @SalesCount=@@ROWCOUNT
END




DECLARE @salescount_output INT

EXEC [dbo].[usp_sales_20210222] null,@salescount_output OUTPUT

select @salescount_output as 'Rowcount'
GO


