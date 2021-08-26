IF EXISTS(
  SELECT *
    FROM sys.procedures
   WHERE name = N'SP_UPD_EQUIPOEMPRESA'
)
	DROP PROCEDURE SP_UPD_EQUIPOEMPRESA
GO
CREATE PROCEDURE SP_UPD_EQUIPOEMPRESA 
	@equipo varchar(50)
AS
BEGIN


	SET NOCOUNT ON;
	UPDATE EquipoEmpresa SET FechaConexion = GETDATE() WHERE equipo = @equipo
END
GO
