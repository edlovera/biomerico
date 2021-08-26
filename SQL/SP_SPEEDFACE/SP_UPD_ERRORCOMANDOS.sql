IF EXISTS(
  SELECT *
    FROM sys.procedures
   WHERE name = N'SP_UPD_ERRORCOMANDOS'
)
	DROP PROCEDURE SP_UPD_ERRORCOMANDOS
GO
CREATE PROCEDURE [dbo].[SP_UPD_ERRORCOMANDOS]
	@intentos INT,
	@error INT,
	@cmdid 	INT


AS
BEGIN
	DECLARE @contador INT;

	SELECT @contador = ISNULL(Intentos, 0) FROM Comandos WHERE CmdID = @cmdid;

	

	IF @contador = @intentos
	BEGIN											  		 
		UPDATE Comandos SET Enviado = 1, Error= @error  WHERE CmdID = @cmdid;
	END
	ELSE
	BEGIN 		 
		UPDATE Comandos SET Intentos = (@contador + 1)	 WHERE CmdID = @cmdid;
	END

END
