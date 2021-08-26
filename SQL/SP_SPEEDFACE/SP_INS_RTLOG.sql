IF EXISTS(
  SELECT *
    FROM sys.procedures
   WHERE name = N'SP_INS_RTLOG'
)
	DROP PROCEDURE SP_INS_RTLOG
GO
CREATE PROCEDURE [dbo].[SP_INS_RTLOG]
	@time VARCHAR(50),
	@pin VARCHAR(50),
	@cardno  VARCHAR(50),
	@eventaddr  VARCHAR(50),   
	@inoutstatus VARCHAR(50),
	@verifytype VARCHAR(50),
	@index VARCHAR(50),
	@linkid VARCHAR(50),	
	@maskflag VARCHAR(50),
	@temperature VARCHAR(50),  
	@sitecode VARCHAR(50),
	@event VARCHAR(50),
	@equipo	 VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @equipoempresaID INT

	SELECT @equipoempresaID = EquipoEmpresaID FROM EquipoEmpresa  WHERE Equipo = @equipo;
	
	INSERT INTO Rtlog ([Time], Pin, Cardno, Eventaddr, Inoutstatus, Verifytype, [Index], Linkid, Maskflag, Temperature, Sitecode, [Event], EquipoEmpresaID) 
	VALUES (CAST(@time AS DATETIME2), @pin, @cardno, @eventaddr, @inoutstatus, @verifytype, @index, @linkid, @maskflag, @temperature, @sitecode, @event, @equipoempresaID)

END
