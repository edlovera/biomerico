IF EXISTS(
  SELECT *
    FROM sys.procedures
   WHERE name = N'SP_UPD_EQUIPOUSERAUTHORIZE'
)
	DROP PROCEDURE SP_UPD_EQUIPOUSERAUTHORIZE
GO
CREATE PROCEDURE [dbo].[SP_UPD_EQUIPOUSERAUTHORIZE]
	@enviado INT,
	@equipoUserauthorizeID VARCHAR(50)
AS
BEGIN


	UPDATE EquipoUserauthorize SET enviado = @enviado WHERE equipoUserauthorizeID = @equipoUserauthorizeID


END
