IF EXISTS(
  SELECT *
    FROM sys.procedures
   WHERE name = N'SP_INS_EQUIPONOINSCRITO'
)
	DROP PROCEDURE SP_INS_EQUIPONOINSCRITO
GO
CREATE PROCEDURE [dbo].[SP_INS_EQUIPONOINSCRITO] 
	@equipo VARCHAR(50)
AS
BEGIN

	DECLARE @fecha DATETIME2 = GETDATE()
	
	SET NOCOUNT ON;
	IF (NOT EXISTS (SELECT 1 FROM EquipoNoInscrito WHERE  Equipo = @equipo))
		BEGIN
			 INSERT INTO EquipoNoInscrito (Equipo, Fecha) VALUES (@equipo, @fecha)
		END
	ELSE 
		BEGIN 		   
			UPDATE EquipoNoInscrito SET Fecha = @fecha WHERE Equipo = @equipo
		END



	
END
