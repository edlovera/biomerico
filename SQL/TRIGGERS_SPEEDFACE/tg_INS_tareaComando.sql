IF EXISTS(
  SELECT *
    FROM sys.triggers
   WHERE name = N'tg_INS_tareaComando'
)
	DROP TRIGGER tg_INS_tareaComando
GO

CREATE TRIGGER tg_INS_tareaComando ON TareaComando 
	FOR INSERT 
AS 							 
	DECLARE @bd VARCHAR(30)
	DECLARE @tarID INT	  		
	DECLARE @sql NVARCHAR(100)		  
	DECLARE @parametros NVARCHAR(100) 
	DECLARE @equipoEmpresaID INT 
	DECLARE @equipo VARCHAR(50)
	
	

	SELECT 
		@bd = e.EmpresaNombreBD,
		@tarID = tc.tar_id,
		@equipoEmpresaID = eg.EquipoEmpresaID,
		@equipo = eg.Equipo
	  FROM inserted tc		
	  INNER JOIN EquipoGenHoras eg ON eg.EquipoGenHorasID = tc.EquipoGenHorasId
	  INNER JOIN Empresa e ON e.EmpresaID = eg.EmpresaID

 

						 
DECLARE @outputParam INT;
	  
SET @parametros =  '@PA_tarID INT, @res_tar INT  OUTPUT'

SET @sql =	@bd + '.dbo.sp_acceso_s_tareaComando_comando  @PA_tarID, @res_tar OUTPUT'	
EXECUTE sp_executeSQL	@sql, @parametros, @PA_tarID = @tarID, @res_tar = @outputParam	 OUTPUT
									 

IF @outputParam	= 101
BEGIN																   
   INSERT INTO Comandos VALUES	
   (@equipo, GETDATE(), 'C:[{cmdid}]:DATA DELETE user Pin=*', 0, null, null) ,		  
   (@equipo, GETDATE(), 'C:[{cmdid}]:DATA DELETE templatev10 Pin=*', 0, null, null),
   (@equipo, GETDATE(), 'C:[{cmdid}]:DATA DELETE userauthorize Pin=*', 0, null, null)
END







   
SET @parametros =  '@PA_tarID INT'




-- ***********          TIMEZONE              ************
-- Se crea tabla temporal para recorrer e insertar
-- tanto en el Timezone como en su relación EquipoTimezone

CREATE TABLE #tmpTimezone(	
	[TimezoneID] [int],
	[SunTime1] [varchar](11) NULL,
	[SunTime2] [varchar](11) NULL,
	[SunTime3] [varchar](11) NULL,
	[MonTime1] [varchar](11) NULL,
	[MonTime2] [varchar](11) NULL,
	[MonTime3] [varchar](11) NULL,
	[TueTime1] [varchar](11) NULL,
	[TueTime2] [varchar](11) NULL,
	[TueTime3] [varchar](11) NULL,
	[WedTime1] [varchar](11) NULL,
	[WedTime2] [varchar](11) NULL,
	[WedTime3] [varchar](11) NULL,
	[ThuTime1] [varchar](11) NULL,
	[ThuTime2] [varchar](11) NULL,
	[ThuTime3] [varchar](11) NULL,
	[FriTime1] [varchar](11) NULL,
	[FriTime2] [varchar](11) NULL,
	[FriTime3] [varchar](11) NULL,
	[SatTime1] [varchar](11) NULL,
	[SatTime2] [varchar](11) NULL,
	[SatTime3] [varchar](11) NULL,
	[Hol1Time1] [varchar](11) NULL,
	[Hol1Time2] [varchar](11) NULL,
	[Hol1Time3] [varchar](11) NULL,
	[Hol2Time1] [varchar](11) NULL,
	[Hol2Time2] [varchar](11) NULL,
	[Hol2Time3] [varchar](11) NULL,
	[Hol3Time1] [varchar](11) NULL,
	[Hol3Time2] [varchar](11) NULL,
	[Hol3Time3] [varchar](11) NULL,
)	

SET @sql =	@bd + '.dbo.sp_acceso_s_TimeZone  @PA_tarID' 	
INSERT INTO #tmpTimezone
EXECUTE sp_executeSQL	@sql, @parametros,
						@PA_tarID			= @tarID 

DECLARE @countTimezone INT 	= (SELECT COUNT(*) FROM #tmpTimezone)
WHILE  @countTimezone > 0
BEGIN
	INSERT INTO TimeZone
	SELECT TOP(1) * FROM  #tmpTimezone

	INSERT INTO EquipoTimezone (EquipoEmpresaID, IDTimeZone, Enviado)  VALUES (@equipoEmpresaID, scope_identity(), 0)

	DELETE 	 TOP(1)  FROM  #tmpTimezone

	SET @countTimezone = (SELECT COUNT(*) FROM #tmpTimezone)
END

DROP TABLE #tmpTimezone


 
 
-- ***********              USERAUTHORIZE               ************
-- Se crea tabla temporal para recorrer e insertar
-- tanto en el Userauthorize como en su relación EquipoUserauthorize

	
CREATE TABLE #tmpUserauthorize(
	[Pin] [varchar](50) NULL,
	[AuthorizeTimezoneID] [int] NULL,
	[AuthorizeDoorID] [int] NULL,
	[DevID] [int] NULL
)	  

SET @sql =	@bd + '.dbo.sp_acceso_s_Userauthorize  @PA_tarID'  
INSERT INTO #tmpUserauthorize
EXECUTE sp_executeSQL	@sql, @parametros,
						@PA_tarID			= @tarID						



DECLARE @countUserauthorize INT 	= (SELECT COUNT(*) FROM #tmpUserauthorize)
WHILE  @countUserauthorize > 0
BEGIN
	INSERT INTO Userauthorize
	SELECT TOP(1) * FROM  #tmpUserauthorize
																															
	INSERT INTO EquipoUserauthorize (EquipoEmpresaID, UserauthorizeID, Enviado, tar_id)  VALUES (@equipoEmpresaID, scope_identity(), 0, @tarID)

	DELETE 	 TOP(1) FROM  #tmpUserauthorize

	SET @countUserauthorize = (SELECT COUNT(*) FROM #tmpUserauthorize)
END


DROP TABLE #tmpUserauthorize

-- ***********              BIODATA               ************
-- Se crea tabla temporal para recorrer e insertar
-- tanto en el Biodata como en su relación EquipoBioData

CREATE TABLE #tmpBioData(
	[Pin] [int] NULL,
	[No] [int] NULL,
	[Index] [int] NULL,
	[Valid] [int] NULL,
	[Duress] [int] NULL,
	[Type] [int] NULL,
	[Majorver] [varchar](50) NULL,
	[Minorver] [varchar](50) NULL,
	[Format] [varchar](50) NULL,
	[Tmp] [varchar](max) NULL,
)	  

SET @sql =	@bd + '.dbo.sp_acceso_s_BioData  @PA_tarID'  
INSERT INTO #tmpBioData
EXECUTE sp_executeSQL	@sql, @parametros,
						@PA_tarID			= @tarID						



DECLARE @countBioData INT 	= (SELECT COUNT(*) FROM #tmpBioData)
WHILE  @countBioData > 0
BEGIN
	INSERT INTO BioData
	SELECT TOP(1) * FROM  #tmpBioData
																															
	INSERT INTO EquipoBioData(EquipoEmpresaID, BioDataID, Enviado)  VALUES (@equipoEmpresaID, scope_identity(), 0)

	DELETE 	 TOP(1) FROM  #tmpBioData

	SET @countBioData = (SELECT COUNT(*) FROM #tmpBioData)
END


DROP TABLE #tmpBioData


 
-- ***********          USER          ************
-- Se crea tabla temporal para recorrer e insertar
-- tanto en el User como en su relación EquipoUser


CREATE TABLE #tmpUser	( 
	[Uid] [int] NULL,
	[CardNo] [varchar](50) NULL,
	[Pin] [int] NULL,
	[Password] [varchar](50) NULL,
	[Group] [int] NULL,
	[StartTime] [varchar](50) NULL,
	[EndTime] [varchar](50) NULL,
	[Name] [varchar](100) NULL,
	[Privilege] [int] NULL,
	[Disable] [int] NULL,
	[Verify] [int] NULL,
	[eliminar]  [int] NULL,
)
	  
SET @sql =	@bd + '.dbo.sp_acceso_s_User  @PA_tarID' 
INSERT INTO #tmpUser
EXECUTE sp_executeSQL	@sql, @parametros,
						@PA_tarID			= @tarID

DECLARE @countUser INT 	= (SELECT COUNT(*) FROM #tmpUser)
WHILE  @countUser > 0
BEGIN
	DECLARE @eliminar INT = 0;
	SELECT TOP(1) @eliminar = eliminar FROM  #tmpUser

	INSERT INTO [User]
	SELECT TOP(1) [Uid], [CardNo],[Pin], [Password],[Group], [StartTime], [EndTime],[Name], [Privilege],[Disable], [Verify]  FROM  #tmpUser



	INSERT INTO EquipoUser  (EquipoEmpresaID, UserID, Enviado, EliminarUser, tar_id)    VALUES (@equipoEmpresaID, scope_identity(), 0, @eliminar, @tarID)


	DELETE 	TOP(1)  FROM  #tmpUser

	SET @countUser = (SELECT COUNT(*) FROM #tmpUser)
END


DROP TABLE #tmpUser


	


SET @parametros =  '@PA_tarID INT, @PA_estado CHAR(1)'


-- ***********           ******               ************
-- Se cambia estado de comando en genhoras
SET @sql =	@bd + '.dbo.sp_acceso_u_tareaComando_estado  @PA_tarID, @PA_estado' 
EXECUTE sp_executeSQL	@sql, @parametros,
						@PA_tarID			= @tarID,
						@PA_estado			= 'E'
GO





 