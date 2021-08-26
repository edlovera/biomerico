IF EXISTS(
  SELECT *
    FROM sys.procedures
   WHERE name = N'SP_UPD_EQUIPOUSER'
)
	DROP PROCEDURE SP_UPD_EQUIPOUSER
GO
CREATE PROCEDURE [dbo].[SP_UPD_EQUIPOUSER]
	@enviado INT,
	@equipoUserID INT
AS
BEGIN


	UPDATE EquipoUser SET enviado = @enviado WHERE EquipoUserID = @equipoUserID
	
	DECLARE @tareaID INT
	
	SELECT @tareaID = tar_id FROM  EquipoUser  WHERE EquipoUserID = @equipoUserID 
	EXEC SP_INS_INFO_CLIENTE_TAREAS	@tareaID

END
