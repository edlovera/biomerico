IF EXISTS(
  SELECT *
    FROM sys.procedures
   WHERE name = N'SP_SEL_BIODATA'
)
	DROP PROCEDURE SP_SEL_BIODATA
GO
CREATE PROCEDURE [dbo].[SP_SEL_BIODATA]
	@enviado INT,
	@equipo VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT ebd.EquipoBioDataID, bd.Pin, bd.[No], bd.[Index], bd.Valid, bd.Duress, bd.[Type], bd.Majorver, bd.Minorver, bd.Format, bd.Tmp 
	FROM EquipoBioData  ebd
		INNER JOIN BioData bd ON bd.BioDataID = ebd.BioDataID
		INNER JOIN EquipoEmpresa ee ON ee.EquipoEmpresaID = ebd.EquipoEmpresaID
	WHERE ebd.Enviado = @enviado AND ee.Equipo = @equipo
END
