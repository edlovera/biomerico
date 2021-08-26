IF EXISTS(
  SELECT *
    FROM sys.procedures
   WHERE name = N'SP_INS_USER'
)
	DROP PROCEDURE SP_INS_USER
GO
CREATE PROCEDURE [dbo].[SP_INS_USER] 
	@uid INT,
	@cardno VARCHAR(50),
	@pin INT,
	@password VARCHAR(50),
	@group INT,
	@starttime VARCHAR(50),
	@endtime VARCHAR(50),
	@name VARCHAR(100),
	@privilege INT,
	@disable INT,
	@verify INT,
	@equipo VARCHAR(50)
AS
BEGIN
	
	
	SET NOCOUNT ON;
	
	DECLARE @userID INT = 0;
	DECLARE @equipoEmpresaID INT = 0;
	
	--Buscar usuario para verificar si ya estaba creado en dicho equipo
	SELECT @userID = [U].UserID FROM [User] [U]
		INNER JOIN EquipoUser [EU] ON [EU].UserID = [U].UserID 
		INNER JOIN  EquipoEmpresa [EE] ON [EE].EquipoEmpresaID = [EU].EquipoEmpresaID
	WHERE 
		[U].[pin] = @pin	AND
		[EE].Equipo = @equipo
	
	-- Si no estaba creado entra aquí para crearlo en caso contrario lo actualiza

	IF(@userID = 0)	
	BEGIN
	
		SELECT @equipoEmpresaID = [EE].EquipoEmpresaID FROM EquipoEmpresa [EE] WHERE [EE].Equipo = @equipo

		--Verifica si el usuario está creado con los mismos parametros

		SELECT @userID = [U].UserID FROM [User] [U]
		WHERE 				
			[cardno] = @cardno AND
			[pin] = @pin AND
			[password] = @password AND
			[group] = @group AND
			[starttime] = @starttime AND
			[endtime] = @endtime AND
			[privilege] = @privilege AND
			[disable] = @disable AND
			[verify] = @verify

		-- Si no está creado con los mismo parametros crea uno nuevo y lo asocia al equipo de la empresa
		-- en caso contrario asocia el existente con el equipo de la empresa

		IF (@userID = 0)
		BEGIN
			INSERT INTO [User] 
				([uid], [cardno], [pin], [password], [group], [starttime], [endtime], [name], [privilege], [disable], [verify]) 
			VALUES 
				(@uid, @cardno, @pin, @password, @group, @starttime, @endtime, @name, @privilege, @disable, @verify)
			SET	@userID	= @@IDENTITY;
		END	   

		INSERT INTO EquipoUser (Enviado, EquipoEmpresaID, UserID) VALUES (1, @equipoEmpresaID, @userID)
	
	END
	ELSE
	BEGIN
		UPDATE  [User]
		SET 
			[cardno] = @cardno,
			[pin] = @pin,
			[password] = @password,
			[group] = @group,
			[starttime] = @starttime,
			[endtime] = @endtime,
			[name] = @name,
			[privilege] = @privilege,
			[disable] = @disable,
			[verify] = @verify
		WHERE
			UserID = @userID
	END



END
