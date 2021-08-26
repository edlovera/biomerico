DELETE FROM EquipoBioData
DBCC CHECKIDENT ('EquipoBioData',RESEED, 0)

DELETE FROM BioData
DBCC CHECKIDENT ('BioData',RESEED, 0)

DELETE FROM BioPhoto
DBCC CHECKIDENT ('BioPhoto',RESEED, 0)

DELETE FROM Comandos
DBCC CHECKIDENT ('Comandos',RESEED, 0)	   	   

DELETE FROM EquipoTimezone
DBCC CHECKIDENT ('EquipoTimezone',RESEED, 0)

DELETE FROM EquipoUser
DBCC CHECKIDENT ('EquipoUser',RESEED, 0)			   

DELETE FROM EquipoUserauthorize
DBCC CHECKIDENT ('EquipoUserauthorize',RESEED, 0)

DELETE FROM Rtlog
DBCC CHECKIDENT ('Rtlog',RESEED, 0)

DELETE FROM RtState
DBCC CHECKIDENT ('RtState',RESEED, 0)		  

DELETE FROM Timezone
DBCC CHECKIDENT ('Timezone',RESEED, 0)

DELETE FROM [User]
DBCC CHECKIDENT ('[User]',RESEED, 0)

DELETE FROM Userauthorize
DBCC CHECKIDENT ('Userauthorize',RESEED, 0)