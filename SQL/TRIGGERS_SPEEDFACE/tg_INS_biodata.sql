
IF EXISTS(
  SELECT *
    FROM sys.triggers
   WHERE name = N'tg_INS_biodata'
)
	DROP TRIGGER tg_INS_biodata
GO

CREATE TRIGGER tg_INS_biodata ON EquipoBioData 
	FOR INSERT 
AS 

DECLARE  @db VARCHAR(30)	 																										 
DECLARE	 @Pin INT
DECLARE	 @No INT	 
DECLARE	 @Index INT
DECLARE	 @Valid INT
DECLARE	 @Duress INT
DECLARE	 @Type INT	
DECLARE	 @Majorver VARCHAR(50)		
DECLARE	 @Minorver VARCHAR(50)	
DECLARE	 @Format VARCHAR(50)	
DECLARE	 @Tmp VARCHAR(MAX)
DECLARE	 @equ_serie VARCHAR(20)

SELECT 

	@db = [E].EmpresaNombreBD,
	@Pin = [I].Pin,
	@No = [I].[No],
	@Index = [I].[Index],
	@Valid = [I].Valid,
	@Duress = [I].Duress,
	@Type = [I].[Type],
	@Majorver = [I].Majorver,
	@Minorver = [I].Minorver,
	@Format = [I].[Format],
	@Tmp = [I].Tmp,
	@equ_serie = [EE].Equipo
	
FROM BioData [I]
	INNER JOIN inserted [EB] ON [EB].BioDataID = [I].BioDataID
	INNER JOIN EquipoEmpresa [EE] ON [EE].EquipoEmpresaID = [EB].EquipoEmpresaID
	INNER JOIN  EquipoGenHoras [EGH] ON [EGH].EquipoEmpresaID = [EE].EquipoEmpresaID
	INNER JOIN Empresa [E] ON [E].EmpresaID = [EGH].EmpresaID

DECLARE @sql NVARCHAR(MAX)
DECLARE @parametros  NVARCHAR(MAX)



SET @sql =	@db + '.dbo.sp_acceso_i_zk_to_biodata
			@PA_Pin, @PA_No,
			@PA_Index,  @PA_Valid,
			@PA_Duress,				  
			@PA_Type,	@PA_Majorver,
			@PA_Minorver,	@PA_Format,
			@PA_Tmp,	@PA_equ_serie'
			

			
SET @parametros =  '@PA_Pin INT, @PA_No INT,  @PA_Index INT, @PA_Valid INT, 
					@PA_Duress INT,  @PA_Type INT, @PA_Majorver varchar(50), 
					@PA_Minorver varchar(50), @PA_Format varchar(50), 
					@PA_Tmp varchar(MAX), @PA_equ_serie varchar(20)'
					

EXECUTE sp_executeSQL	@sql, @parametros,
						@PA_Pin				= @Pin,				@PA_No			= @No,
						@PA_Index			= @Index,			@PA_Valid		= @Valid,
						@PA_Duress			= @Duress,			@PA_Type		= @Type,				 
						@PA_Majorver		= @Majorver,		@PA_Minorver	= @Minorver,				 
						@PA_Format			= @Format,			@PA_Tmp			= @Tmp,				
						@PA_equ_serie		= @equ_serie


GO