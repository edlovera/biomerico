IF EXISTS(
  SELECT *
    FROM sys.procedures
   WHERE name = N'SP_INS_BIODATA'
)
	DROP PROCEDURE SP_INS_BIODATA
GO
CREATE PROCEDURE [dbo].[SP_INS_BIODATA]

	@pin VARCHAR(50),
	@no  VARCHAR(50),	   
	@index  VARCHAR(50),   
	@valid  VARCHAR(50),   
	@duress  VARCHAR(50),   
	@type  VARCHAR(50),   
	@majorver  VARCHAR(50),   
	@minorver  VARCHAR(50),   
	@format  VARCHAR(50),   
	@tmp  VARCHAR(MAX),   
	@equipo  VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @equipoempresaID INT

	SELECT @equipoempresaID = EquipoEmpresaID FROM EquipoEmpresa  WHERE Equipo = @equipo;
	
	INSERT INTO BioData ([Pin], [No], [Index], [Valid], [Duress], [Type], [Majorver], [Minorver], [Format], [Tmp]) 
	VALUES (@pin, @no, @index, @valid, @duress, @type, @majorver, @minorver, @format, @tmp)

	INSERT INTO EquipoBioData (BioDataID, Enviado, EquipoEmpresaID)
	VALUES (@@IDENTITY, 1, @equipoempresaID)

END
