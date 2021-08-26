USE [AttDBgenZK]
GO
/****** Object:  Table [dbo].[BioData]    Script Date: 03/08/2021 18:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BioData](
	[BioDataID] [int] IDENTITY(1,1) NOT NULL,
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
 CONSTRAINT [PK_BioData] PRIMARY KEY CLUSTERED 
(
	[BioDataID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BioPhoto]    Script Date: 03/08/2021 18:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BioPhoto](
	[BioPhotoID] [int] IDENTITY(1,1) NOT NULL,
	[Pin] [int] NULL,
	[No] [int] NULL,
	[Index] [int] NULL,
	[Filename] [varchar](50) NULL,
	[Type] [int] NULL,
	[Size] [int] NULL,
	[Content] [varchar](max) NULL,
	[EquipoEmpresaID] [int] NULL,
 CONSTRAINT [PK_BioPhoto] PRIMARY KEY CLUSTERED 
(
	[BioPhotoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comandos]    Script Date: 03/08/2021 18:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comandos](
	[CmdID] [int] IDENTITY(1,1) NOT NULL,
	[Equipo] [varchar](50) NULL,
	[Fecha] [datetime2](7) NULL,
	[Cmd] [varchar](max) NULL,
	[Enviado] [int] NULL,
	[Intentos] [int] NULL,
	[Error] [int] NULL,
 CONSTRAINT [PK_Comandos] PRIMARY KEY CLUSTERED 
(
	[CmdID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Empresa]    Script Date: 03/08/2021 18:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empresa](
	[EmpresaID] [int] IDENTITY(1,1) NOT NULL,
	[EmpresaCliente] [varchar](50) NOT NULL,
	[EmpresaNombreBD] [varchar](30) NOT NULL,
	[EmpresaFechaIngreso] [datetime] NOT NULL,
	[Activo] [int] NULL,
 CONSTRAINT [pk_empresa] PRIMARY KEY CLUSTERED 
(
	[EmpresaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmpresaEquipo]    Script Date: 03/08/2021 18:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpresaEquipo](
	[EmpresaEquipoID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[EmpresaID] [int] NULL,
	[Equipo] [varchar](20) NOT NULL,
	[EmpresaEquipoFechaIngreso] [datetime] NOT NULL,
	[equ_codigo] [int] NULL,
 CONSTRAINT [pk_empresa_equipo] PRIMARY KEY CLUSTERED 
(
	[EmpresaEquipoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipoBioData]    Script Date: 03/08/2021 18:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipoBioData](
	[EquipoBioDataID] [int] IDENTITY(1,1) NOT NULL,
	[EquipoEmpresaID] [int] NULL,
	[BioDataID] [int] NULL,
	[Enviado] [int] NULL,
 CONSTRAINT [PK_EquipoBioData] PRIMARY KEY CLUSTERED 
(
	[EquipoBioDataID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipoEmpresa]    Script Date: 03/08/2021 18:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipoEmpresa](
	[EquipoEmpresaID] [int] IDENTITY(1,1) NOT NULL,
	[Equipo] [varchar](50) NULL,
	[RegistryCode] [varchar](100) NULL,
	[SessionID] [varchar](100) NULL,
	[InfoEquipo] [varchar](2000) NULL,
	[FechaConexion] [datetime] NULL,
 CONSTRAINT [PK_EquipoEmpresa] PRIMARY KEY CLUSTERED 
(
	[EquipoEmpresaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipoGenHoras]    Script Date: 03/08/2021 18:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipoGenHoras](
	[EquipoGenHorasID] [int] IDENTITY(1,1) NOT NULL,
	[EmpresaID] [int] NULL,
	[Equipo] [varchar](20) NOT NULL,
	[EquipoGenHorasFechaIngreso] [datetime] NOT NULL,
	[equ_codigo] [int] NULL,
	[Estado] [int] NULL,
	[EquipoEmpresaID] [int] NOT NULL,
 CONSTRAINT [PK_EquipoGenHoras] PRIMARY KEY CLUSTERED 
(
	[EquipoGenHorasID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipoNoInscrito]    Script Date: 03/08/2021 18:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipoNoInscrito](
	[EquipoNoInscritoID] [int] IDENTITY(1,1) NOT NULL,
	[Equipo] [varchar](50) NULL,
	[Fecha] [datetime2](7) NULL,
 CONSTRAINT [PK_EquipoNoInscrito] PRIMARY KEY CLUSTERED 
(
	[EquipoNoInscritoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipoTimezone]    Script Date: 03/08/2021 18:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipoTimezone](
	[EquipoTimezoneID] [int] IDENTITY(1,1) NOT NULL,
	[IDTimeZone] [int] NULL,
	[EquipoEmpresaID] [int] NULL,
	[Enviado] [int] NULL,
 CONSTRAINT [PK_EquipoTimezone] PRIMARY KEY CLUSTERED 
(
	[EquipoTimezoneID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipoUser]    Script Date: 03/08/2021 18:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipoUser](
	[EquipoUserID] [int] IDENTITY(1,1) NOT NULL,
	[EquipoEmpresaID] [int] NULL,
	[UserID] [int] NULL,
	[Enviado] [int] NULL,
	[EliminarUser] [int] NULL,
	[tar_id] [int] NULL,
 CONSTRAINT [PK_EquipoUser] PRIMARY KEY CLUSTERED 
(
	[EquipoUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipoUserauthorize]    Script Date: 03/08/2021 18:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipoUserauthorize](
	[EquipoUserauthorizeID] [int] IDENTITY(1,1) NOT NULL,
	[EquipoEmpresaID] [int] NULL,
	[UserauthorizeID] [int] NULL,
	[Enviado] [int] NULL,
	[tar_id] [int] NULL,
 CONSTRAINT [PK_EquipoUserauthorize] PRIMARY KEY CLUSTERED 
(
	[EquipoUserauthorizeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rtlog]    Script Date: 03/08/2021 18:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rtlog](
	[RtlogID] [int] IDENTITY(1,1) NOT NULL,
	[Time] [datetime2](7) NULL,
	[Pin] [int] NULL,
	[Cardno] [int] NULL,
	[Eventaddr] [int] NULL,
	[Event] [int] NULL,
	[Inoutstatus] [int] NULL,
	[Verifytype] [int] NULL,
	[Index] [int] NULL,
	[Linkid] [int] NULL,
	[Maskflag] [int] NULL,
	[Temperature] [varchar](5) NULL,
	[Sitecode] [varchar](50) NULL,
	[EquipoEmpresaID] [int] NULL,
 CONSTRAINT [PK_Rtlog] PRIMARY KEY CLUSTERED 
(
	[RtlogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RtState]    Script Date: 03/08/2021 18:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RtState](
	[RtStateID] [int] IDENTITY(1,1) NOT NULL,
	[Time] [datetime2](7) NULL,
	[Sensor] [varchar](10) NULL,
	[Relay] [varchar](10) NULL,
	[Alarm] [varchar](50) NULL,
	[Door] [varchar](10) NULL,
	[EquipoEmpresaID] [int] NULL,
 CONSTRAINT [PK_RtState] PRIMARY KEY CLUSTERED 
(
	[RtStateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TareaComando]    Script Date: 03/08/2021 18:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TareaComando](
	[TareaComando_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[EquipoGenHorasId] [int] NOT NULL,
	[tar_id] [int] NOT NULL,
 CONSTRAINT [PK_TareaComando] PRIMARY KEY CLUSTERED 
(
	[TareaComando_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Timezone]    Script Date: 03/08/2021 18:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Timezone](
	[IDTimeZone] [int] IDENTITY(1,1) NOT NULL,
	[TimezoneID] [int] NOT NULL,
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
 CONSTRAINT [PK_Timezone] PRIMARY KEY CLUSTERED 
(
	[IDTimeZone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 03/08/2021 18:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
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
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Userauthorize]    Script Date: 03/08/2021 18:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Userauthorize](
	[UserauthorizeID] [int] IDENTITY(1,1) NOT NULL,
	[Pin] [varchar](50) NULL,
	[AuthorizeTimezoneID] [int] NULL,
	[AuthorizeDoorID] [int] NULL,
	[DevID] [int] NULL,
 CONSTRAINT [PK_Userauthorize] PRIMARY KEY CLUSTERED 
(
	[UserauthorizeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Empresa] ADD  CONSTRAINT [DF__empresa__vigente__09A971A2]  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[BioPhoto]  WITH CHECK ADD  CONSTRAINT [FK_BioPhoto_EquipoEmpresa] FOREIGN KEY([EquipoEmpresaID])
REFERENCES [dbo].[EquipoEmpresa] ([EquipoEmpresaID])
GO
ALTER TABLE [dbo].[BioPhoto] CHECK CONSTRAINT [FK_BioPhoto_EquipoEmpresa]
GO
ALTER TABLE [dbo].[EquipoBioData]  WITH CHECK ADD  CONSTRAINT [FK_EquipoBioData_BioData] FOREIGN KEY([BioDataID])
REFERENCES [dbo].[BioData] ([BioDataID])
GO
ALTER TABLE [dbo].[EquipoBioData] CHECK CONSTRAINT [FK_EquipoBioData_BioData]
GO
ALTER TABLE [dbo].[EquipoBioData]  WITH CHECK ADD  CONSTRAINT [FK_EquipoBioData_EquipoEmpresa] FOREIGN KEY([EquipoEmpresaID])
REFERENCES [dbo].[EquipoEmpresa] ([EquipoEmpresaID])
GO
ALTER TABLE [dbo].[EquipoBioData] CHECK CONSTRAINT [FK_EquipoBioData_EquipoEmpresa]
GO
ALTER TABLE [dbo].[EquipoGenHoras]  WITH CHECK ADD  CONSTRAINT [FK_empresa_EquipoGenHoras] FOREIGN KEY([EmpresaID])
REFERENCES [dbo].[Empresa] ([EmpresaID])
GO
ALTER TABLE [dbo].[EquipoGenHoras] CHECK CONSTRAINT [FK_empresa_EquipoGenHoras]
GO
ALTER TABLE [dbo].[EquipoGenHoras]  WITH CHECK ADD  CONSTRAINT [FK_EquipoGenHoras_EquipoEmpresa] FOREIGN KEY([EquipoEmpresaID])
REFERENCES [dbo].[EquipoEmpresa] ([EquipoEmpresaID])
GO
ALTER TABLE [dbo].[EquipoGenHoras] CHECK CONSTRAINT [FK_EquipoGenHoras_EquipoEmpresa]
GO
ALTER TABLE [dbo].[EquipoTimezone]  WITH CHECK ADD  CONSTRAINT [FK_EquipoTimezone_EquipoEmpresa] FOREIGN KEY([EquipoEmpresaID])
REFERENCES [dbo].[EquipoEmpresa] ([EquipoEmpresaID])
GO
ALTER TABLE [dbo].[EquipoTimezone] CHECK CONSTRAINT [FK_EquipoTimezone_EquipoEmpresa]
GO
ALTER TABLE [dbo].[EquipoTimezone]  WITH CHECK ADD  CONSTRAINT [FK_EquipoTimezone_Timezone] FOREIGN KEY([IDTimeZone])
REFERENCES [dbo].[Timezone] ([IDTimeZone])
GO
ALTER TABLE [dbo].[EquipoTimezone] CHECK CONSTRAINT [FK_EquipoTimezone_Timezone]
GO
ALTER TABLE [dbo].[EquipoUser]  WITH CHECK ADD  CONSTRAINT [FK_EquipoUser_EquipoEmpresa] FOREIGN KEY([EquipoEmpresaID])
REFERENCES [dbo].[EquipoEmpresa] ([EquipoEmpresaID])
GO
ALTER TABLE [dbo].[EquipoUser] CHECK CONSTRAINT [FK_EquipoUser_EquipoEmpresa]
GO
ALTER TABLE [dbo].[EquipoUser]  WITH CHECK ADD  CONSTRAINT [FK_EquipoUser_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[EquipoUser] CHECK CONSTRAINT [FK_EquipoUser_User]
GO
ALTER TABLE [dbo].[EquipoUserauthorize]  WITH CHECK ADD  CONSTRAINT [FK_EquipoUserauthorize_EquipoEmpresa] FOREIGN KEY([EquipoEmpresaID])
REFERENCES [dbo].[EquipoEmpresa] ([EquipoEmpresaID])
GO
ALTER TABLE [dbo].[EquipoUserauthorize] CHECK CONSTRAINT [FK_EquipoUserauthorize_EquipoEmpresa]
GO
ALTER TABLE [dbo].[EquipoUserauthorize]  WITH CHECK ADD  CONSTRAINT [FK_EquipoUserauthorize_Userauthorize] FOREIGN KEY([UserauthorizeID])
REFERENCES [dbo].[Userauthorize] ([UserauthorizeID])
GO
ALTER TABLE [dbo].[EquipoUserauthorize] CHECK CONSTRAINT [FK_EquipoUserauthorize_Userauthorize]
GO
ALTER TABLE [dbo].[Rtlog]  WITH CHECK ADD  CONSTRAINT [FK_Rtlog_EquipoEmpresa] FOREIGN KEY([EquipoEmpresaID])
REFERENCES [dbo].[EquipoEmpresa] ([EquipoEmpresaID])
GO
ALTER TABLE [dbo].[Rtlog] CHECK CONSTRAINT [FK_Rtlog_EquipoEmpresa]
GO
ALTER TABLE [dbo].[RtState]  WITH CHECK ADD  CONSTRAINT [FK_RtState_EquipoEmpresa] FOREIGN KEY([EquipoEmpresaID])
REFERENCES [dbo].[EquipoEmpresa] ([EquipoEmpresaID])
GO
ALTER TABLE [dbo].[RtState] CHECK CONSTRAINT [FK_RtState_EquipoEmpresa]
GO
ALTER TABLE [dbo].[TareaComando]  WITH CHECK ADD  CONSTRAINT [FK_TareaComando_EquipoGenHoras] FOREIGN KEY([EquipoGenHorasId])
REFERENCES [dbo].[EquipoGenHoras] ([EquipoGenHorasID])
GO
ALTER TABLE [dbo].[TareaComando] CHECK CONSTRAINT [FK_TareaComando_EquipoGenHoras]
GO
