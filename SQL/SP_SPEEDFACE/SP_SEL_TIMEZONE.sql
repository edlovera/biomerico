IF EXISTS(
  SELECT *
    FROM sys.procedures
   WHERE name = N'SP_SEL_TIMEZONE'
)
	DROP PROCEDURE SP_SEL_TIMEZONE
GO
CREATE PROCEDURE [dbo].[SP_SEL_TIMEZONE]
	@enviado INT,
	@equipo VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT [ET].EquipoTimezoneID, [T].* 
	FROM Timezone [T]
		INNER JOIN EquipoTimezone [ET] ON [ET].IDTimeZone = [T].IDTimeZone 
		INNER JOIN EquipoEmpresa [EE] ON [EE].EquipoEmpresaID = [ET].EquipoEmpresaID 
	WHERE [EE].Equipo = @equipo AND [ET].Enviado = @enviado
END
