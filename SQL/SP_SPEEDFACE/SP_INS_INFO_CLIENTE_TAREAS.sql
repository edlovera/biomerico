IF EXISTS(
  SELECT *
    FROM sys.procedures
   WHERE name = N'SP_INS_INFO_CLIENTE_TAREAS'
)
	DROP PROCEDURE SP_INS_INFO_CLIENTE_TAREAS
GO
CREATE PROCEDURE [dbo].[SP_INS_INFO_CLIENTE_TAREAS]
	@tar_id INT
AS
BEGIN

		  
DECLARE @tar_ejecutado CHAR(1)
DECLARE @tar_mensaje VARCHAR(500)
DECLARE @sql2 NVARCHAR(2000)		  
DECLARE @parametros2 NVARCHAR(2000)	
DECLARE @bd VARCHAR(30)	 



SELECT
	E.EmpresaNombreBD,
	EU.tar_id,
	COUNT(
	CASE EU.Enviado
		WHEN 1 THEN 1
		ELSE NULL
	END ) AS CantitadTareasRealizadas,
	COUNT(
	CASE EU.Enviado
		WHEN 0 THEN 0
		ELSE NULL
	END ) AS CantitadTareasPendiente 
INTO #CantitadTareas
FROM EquipoUser EU
INNER JOIN EquipoGenHoras EG ON EG.EquipoEmpresaID = EU.EquipoEmpresaID
INNER JOIN Empresa E ON E.EmpresaID = EG.EmpresaID
WHERE EU.tar_id =  @tar_id	
GROUP BY EU.tar_id, E.EmpresaNombreBD




DECLARE @pendientes	INT
DECLARE @realizadas INT
DECLARE @tar_fechhor_respuesta DATETIME	= GETDATE()
DECLARE @tar_estado  CHAR(1)




		
	SELECT 	TOP(1)
		@bd = EmpresaNombreBD,
		@realizadas = CantitadTareasRealizadas,
		@pendientes = CantitadTareasPendiente,
		@tar_id =  tar_id
	FROM  #CantitadTareas  

	IF @pendientes = 0
	BEGIN
		SET @tar_mensaje = 'Ejecutado con éxito: ' +  CONVERT(VARCHAR(5), @realizadas ) + ', Pendientes: ' +	 CONVERT(VARCHAR(5), @pendientes  )	
		SET @tar_ejecutado = 'S' 
		SET @tar_estado = 'E'


						  

	SET @sql2 =	@bd + '.dbo.sp_acceso_u_tareaComando_mensajeEjecutado
				@PA_tar_id, @PA_tar_ejecutado,  @PA_tar_mensaje, @PA_tar_fechhor_respuesta, @PA_tar_estado'
			
	SET @parametros2 =  '@PA_tar_id INT, @PA_tar_ejecutado CHAR(1),  @PA_tar_mensaje  VARCHAR(500), @PA_tar_fechhor_respuesta DATETIME, @PA_tar_estado CHAR(1)' 
		

	EXECUTE sp_executeSQL	@sql2, @parametros2,
							@PA_tar_id			= @tar_id,				@PA_tar_ejecutado			= @tar_ejecutado,
							@PA_tar_mensaje		= @tar_mensaje,			@PA_tar_fechhor_respuesta	= @tar_fechhor_respuesta,
							@PA_tar_estado		= @tar_estado


END

						   
	DROP TABLE #CantitadTareas
END
