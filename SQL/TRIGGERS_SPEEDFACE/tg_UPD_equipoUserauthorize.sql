 IF EXISTS(
  SELECT *
    FROM sys.triggers
   WHERE name = N'tg_UPD_equipoUserauthorize'
)
	DROP TRIGGER tg_UPD_equipoUserauthorize
GO
CREATE TRIGGER tg_UPD_equipoUserauthorize 
   ON  EquipoUserauthorize 
   AFTER UPDATE
AS 
BEGIN

	SET NOCOUNT ON;
	DECLARE @bd VARCHAR(30)	 
	DECLARE @pin INT		
	DECLARE @equ_codigo INT
	DECLARE @tar_id INT		   
	DECLARE @sql NVARCHAR(2000)		  
	DECLARE @parametros NVARCHAR(2000)
	DECLARE @contador INT
	DECLARE @activa INT

		
	SELECT
		@bd = E.EmpresaNombreBD,
		@pin = U.Pin,
		@equ_codigo = EG.equ_codigo,
		@tar_id = EU.tar_id		
	FROM inserted EU
	INNER JOIN Userauthorize U ON U.UserauthorizeID = EU.UserauthorizeID
	INNER JOiN EquipoEmpresa EE ON EE.EquipoEmpresaID = EU.EquipoEmpresaID
	INNER JOIN EquipoGenHoras EG ON EG.EquipoEmpresaID = EE.EquipoEmpresaID
	INNER JOIN Empresa E ON E.EmpresaID = EG.EmpresaID
	WHERE EU.Enviado = 1





SET @sql =	@bd + '.dbo.sp_acceso_iu_equipo_tarjeta
			@PA_pin, @PA_equ_codigo,  @PA_tar_id, @PA_activa'

			
SET @parametros =  '@PA_pin INT, @PA_equ_codigo INT,  @PA_tar_id INT, @PA_activa INT' 
		

EXECUTE sp_executeSQL	@sql, @parametros,
						@PA_pin				= @pin,				@PA_equ_codigo			= @equ_codigo,
						@PA_tar_id			= @tar_id,			@PA_activa				= 1




					   			 		  		  
END
GO
