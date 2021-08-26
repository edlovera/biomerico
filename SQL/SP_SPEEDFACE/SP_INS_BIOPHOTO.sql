IF EXISTS(
  SELECT *
    FROM sys.procedures
   WHERE name = N'SP_INS_BIOPHOTO'
)
	DROP PROCEDURE SP_INS_BIOPHOTO
GO
CREATE PROCEDURE [dbo].[SP_INS_BIOPHOTO]
	@pin INT,
	@no INT,
	@index  INT,
	@filename  VARCHAR(50),   
	@type INT,
	@size INT,	   
	@content VARCHAR(50),
	@equipo VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @equipoempresaID INT

	SELECT @equipoempresaID = EquipoEmpresaID FROM EquipoEmpresa  WHERE Equipo = @equipo;
	
	INSERT INTO BioPhoto (Pin, [No], [Index], [Filename], [Type], [Size], [Content], EquipoEmpresaID) 
	VALUES (@pin, @no, @index, @filename, @type, @size, @content, @equipoempresaID)
END
