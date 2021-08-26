
-- ************ Se inscribe equipo
INSERT INTO EquipoEmpresa (Equipo)  VALUES ('CKJY203760024')
SELECT * FROM  EquipoEmpresa
--

-- ************ Actualización de data de usuario	  
UPDATE [User] SET Privilege = 14, [Name] = 'Eli David' WHERE Pin = 26007944  			   
SELECT * FROM [User]
--

-- ************ Enviar usario a equipo
UPDATE EquipoUser SET EliminarUser= 1, Enviado = 0 WHERE UserID = 	(SELECT UserID FROM [User] WHERE Pin = 26007944 )   
SELECT * FROM EquipoUser
--
					   
-- ************ Enviar huellas
UPDATE EquipoBioData SET Enviado = 0
SELECT * FROM EquipoBioData
--

-- *********** Crear horario
INSERT INTO Timezone (TimezoneID, TueTime1)  VALUES	(22  ,'9:30-19:00')
SELECT * FROM  Timezone
--

-- ********** Asignar horario a usuario
INSERT INTO Userauthorize (Pin, AuthorizeTimezoneID, AuthorizeDoorID,DevID) VALUES ('26007944', 22, 1, 0) 
SELECT * FROM Userauthorize
--


-- *********** Mandar  horario a equipo
INSERT INTO EquipoTimezone (IDTimeZone ,EquipoEmpresaID, Enviado)  VALUES	(1  ,1 , 0)
SELECT * FROM  EquipoTimezone
--		  		 

-- ********** Mandar horario asignado a usuario al equipo
INSERT INTO  EquipoUserauthorize (EquipoEmpresaID, UserauthorizeID, Enviado) VALUES (1, 1, 0)
SELECT * FROM EquipoUserauthorize
--

--Registro en Equipo				   
SELECT * FROM [User]
SELECT * FROM BioData
SELECT * FROM BioPhoto

SELECT * FROM Comandos
SELECT * FROM Rtlog
SELECT * FROM RtState
SELECT * FROM Timezone
SELECT * FROM Userauthorize