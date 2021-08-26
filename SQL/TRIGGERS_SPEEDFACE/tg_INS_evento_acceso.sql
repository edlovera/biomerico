
IF EXISTS(
  SELECT *
    FROM sys.triggers
   WHERE name = N'tg_INS_evento_acceso'
)
	DROP TRIGGER tg_INS_evento_acceso
GO

CREATE TRIGGER tg_INS_evento_acceso ON RtLog 
	FOR INSERT 
AS 
						
DECLARE @db VARCHAR(30)	 
DECLARE @eva_codigo INT	= 100
DECLARE @equ_codigo INT	 
DECLARE @eql_lector CHAR(1)
DECLARE @tar_numero CHAR(8)
DECLARE @eva_fecha_hora DATETIME
DECLARE @tie_codigo CHAR(1)
DECLARE @eva_tipo_captura INT

SELECT  
	@db = [E].EmpresaNombreBD,
	@eva_codigo = [I].[Index],
	@equ_codigo = [EGH].equ_codigo,
	@eql_lector = 1,
	@tar_numero = [I].Pin,
	@eva_fecha_hora = [I].[Time],
	@eva_tipo_captura = [I].Inoutstatus,
	@eva_tipo_captura = 4,
	@tie_codigo =	CASE 
						WHEN [I].[Event]  IN (0, 3, 14, 15, 17, 203) 
							THEN 
								CASE [I].Inoutstatus
									WHEN 0 THEN 1
									WHEN 1 THEN 0
									ELSE  [I].Inoutstatus
								END						 
						WHEN [I].[Event]  IN (22) THEN 4   
						WHEN [I].[Event]  IN (24) THEN 'A'
						WHEN [I].[Event]  IN (27, 30, 34) THEN 7
						ELSE 'E'
					END
FROM inserted [I]
	INNER JOIN EquipoEmpresa [EE] ON [EE].EquipoEmpresaID = [I].EquipoEmpresaID
	INNER JOIN EquipoGenHoras [EGH] ON [EGH].EquipoEmpresaID = [EE].EquipoEmpresaID
	INNER JOIN Empresa [E] ON [E].EmpresaID = [EGH].EmpresaID

DECLARE @sql NVARCHAR(2000)
DECLARE @parametros  NVARCHAR(1000)



SET @sql =	@db + '.dbo.sp_acceso_i_zk_to_evento_acceso
			@PA_eva_codigo, @PA_equ_codigo,
			@PA_eql_lector,  @PA_tar_numero,
			@PA_eva_fecha_hora,
			@PA_tie_codigo,	@PA_eva_tipo_captura'
			
			
SET @parametros =  '@PA_eva_codigo INT, @PA_equ_codigo INT,  @PA_eql_lector CHAR(1), @PA_tar_numero CHAR(8), 
					@PA_eva_fecha_hora DATETIME,  @PA_tie_codigo CHAR(1), @PA_eva_tipo_captura INT'
					

EXECUTE sp_executeSQL	@sql, @parametros,
						@PA_eva_codigo				= @eva_codigo,				@PA_equ_codigo			= @equ_codigo,
						@PA_eql_lector				= @eql_lector,				@PA_tar_numero			= @tar_numero,
						@PA_eva_fecha_hora			= @eva_fecha_hora,			@PA_tie_codigo			= @tie_codigo,				 
						@PA_eva_tipo_captura		= @eva_tipo_captura	


GO