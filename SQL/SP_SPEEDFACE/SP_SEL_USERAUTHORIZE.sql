IF EXISTS(
  SELECT *
    FROM sys.procedures
   WHERE name = N'SP_SEL_USERAUTHORIZE'
)
	DROP PROCEDURE SP_SEL_USERAUTHORIZE
GO
CREATE PROCEDURE [dbo].[SP_SEL_USERAUTHORIZE]
	@enviado INT,
	@equipo VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT[EUA].EquipoUserauthorizeID, [UA].* 
	FROM Userauthorize [UA]
		INNER JOIN EquipoUserauthorize [EUA] ON [UA].UserauthorizeID = [EUA].UserauthorizeID 
		INNER JOIN EquipoEmpresa [EE] ON [EE].EquipoEmpresaID = [EUA].EquipoEmpresaID 
	WHERE [EE].Equipo = @equipo AND [EUA].Enviado = @enviado
END
