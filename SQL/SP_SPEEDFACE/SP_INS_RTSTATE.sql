IF EXISTS(
  SELECT *
    FROM sys.procedures
   WHERE name = N'SP_INS_RTSTATE'
)
	DROP PROCEDURE SP_INS_RTSTATE
GO
CREATE PROCEDURE [dbo].[SP_INS_RTSTATE] 
	@time VARCHAR(50),
	@sensor VARCHAR(50),
	@relay  VARCHAR(50),
	@alarm  VARCHAR(50),
	@door VARCHAR(50),
	@equipo	 VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @equipoempresaID INT

	SELECT @equipoempresaID = EquipoEmpresaID FROM EquipoEmpresa  WHERE Equipo = @equipo;
	
	INSERT INTO RtState ([Time], [Sensor], [Relay], [Alarm], [Door], [EquipoEmpresaID]) 
	VALUES (CAST(@time AS DATETIME2), @sensor, @relay, @alarm, @door, @equipoempresaID)

END
