IF EXISTS(
  SELECT *
    FROM sys.procedures
   WHERE name = N'SP_SEL_USER'
)
	DROP PROCEDURE SP_SEL_USER
GO
CREATE PROCEDURE [dbo].[SP_SEL_USER]
	@enviado INT,
	@equipo VARCHAR(50),
	@elimnaruser INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT [EU].EquipoUserID, [U].* FROM [User] [U]
		INNER JOIN EquipoUser [EU] ON [EU].UserID = [U].UserID 
		INNER JOIN  EquipoEmpresa [EE] ON [EE].EquipoEmpresaID = [EU].EquipoEmpresaID
	WHERE ISNULL([EU].Enviado, 0) = @enviado AND [EE].Equipo = @equipo	 AND ISNULL([EU].EliminarUser, 0) = @elimnaruser
END
