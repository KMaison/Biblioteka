USE [master]
GO
/****** Object:  Database [Biblioteka]    Script Date: 09.05.2019 15:29:32 ******/
CREATE DATABASE [Biblioteka]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Biblioteka', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Biblioteka.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Biblioteka_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Biblioteka_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Biblioteka] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Biblioteka].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Biblioteka] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Biblioteka] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Biblioteka] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Biblioteka] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Biblioteka] SET ARITHABORT OFF 
GO
ALTER DATABASE [Biblioteka] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Biblioteka] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Biblioteka] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Biblioteka] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Biblioteka] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Biblioteka] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Biblioteka] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Biblioteka] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Biblioteka] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Biblioteka] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Biblioteka] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Biblioteka] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Biblioteka] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Biblioteka] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Biblioteka] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Biblioteka] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Biblioteka] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Biblioteka] SET RECOVERY FULL 
GO
ALTER DATABASE [Biblioteka] SET  MULTI_USER 
GO
ALTER DATABASE [Biblioteka] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Biblioteka] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Biblioteka] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Biblioteka] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Biblioteka] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Biblioteka', N'ON'
GO
ALTER DATABASE [Biblioteka] SET QUERY_STORE = OFF
GO
USE [Biblioteka]
GO
/****** Object:  Table [dbo].[Biblioteka]    Script Date: 09.05.2019 15:29:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Biblioteka](
	[Id] [int] NOT NULL,
	[Miejscowosc] [varchar](20) NULL,
	[Nazwa] [varchar](20) NULL,
	[Ulica] [varchar](20) NULL,
 CONSTRAINT [PK_Biblioteka] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Czytelnik]    Script Date: 09.05.2019 15:29:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Czytelnik](
	[Imie] [varchar](50) NULL,
	[Nazwisko] [varchar](50) NULL,
	[ID] [int] NOT NULL,
 CONSTRAINT [PK_Czytelnik] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ksiazka]    Script Date: 09.05.2019 15:29:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ksiazka](
	[Tytul] [varchar](50) NULL,
	[Rok_wydania] [date] NULL,
	[Autor] [varchar](50) NULL,
	[Id_ksiazki] [int] NOT NULL,
 CONSTRAINT [PK_Ksiazka] PRIMARY KEY CLUSTERED 
(
	[Id_ksiazki] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Permission]    Script Date: 09.05.2019 15:29:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permission](
	[Id] [int] NOT NULL,
	[Type] [varchar](30) NULL,
 CONSTRAINT [PK_Permission] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 09.05.2019 15:29:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [int] NOT NULL,
	[Name] [varchar](20) NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role_permission]    Script Date: 09.05.2019 15:29:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role_permission](
	[Id] [int] NOT NULL,
	[Id_role] [int] NULL,
	[Id_permission] [int] NULL,
 CONSTRAINT [PK_Role_permission] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 09.05.2019 15:29:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] NOT NULL,
	[Name] [varchar](20) NULL,
	[Password] [varchar](20) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User_Role]    Script Date: 09.05.2019 15:29:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Role](
	[Id] [int] NOT NULL,
	[Id_role] [int] NULL,
	[Id_User] [int] NULL,
 CONSTRAINT [PK_User_Role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[wypozyczenie]    Script Date: 09.05.2019 15:29:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[wypozyczenie](
	[ID_czytelnika] [int] NOT NULL,
	[Data wyp] [date] NULL,
	[Data oddania] [date] NULL,
	[ID ksiazki] [int] NULL,
	[Id biblioteki] [int] NULL,
 CONSTRAINT [PK_wypozyczenie] PRIMARY KEY CLUSTERED 
(
	[ID_czytelnika] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Biblioteka] ([Id], [Miejscowosc], [Nazwa], [Ulica]) VALUES (1, N'Gdansk', N'Numer 1', N'Miszewskiego')
INSERT [dbo].[Czytelnik] ([Imie], [Nazwisko], [ID]) VALUES (N'Michal', N'Kowalski', 1)
INSERT [dbo].[Czytelnik] ([Imie], [Nazwisko], [ID]) VALUES (N'Anna', N'Maria', 2)
INSERT [dbo].[Czytelnik] ([Imie], [Nazwisko], [ID]) VALUES (N'Julian', N'Nowak', 3)
INSERT [dbo].[Ksiazka] ([Tytul], [Rok_wydania], [Autor], [Id_ksiazki]) VALUES (N'Szklanka', CAST(N'2008-02-01' AS Date), N'Adam ', 1)
INSERT [dbo].[Ksiazka] ([Tytul], [Rok_wydania], [Autor], [Id_ksiazki]) VALUES (N'Laptop', CAST(N'2001-05-02' AS Date), N'Julia', 2)
INSERT [dbo].[Ksiazka] ([Tytul], [Rok_wydania], [Autor], [Id_ksiazki]) VALUES (N'Slomka', CAST(N'2000-05-01' AS Date), N'Marek', 3)
INSERT [dbo].[Permission] ([Id], [Type]) VALUES (1, N'Read')
INSERT [dbo].[Permission] ([Id], [Type]) VALUES (2, N'Update')
INSERT [dbo].[Role] ([Id], [Name]) VALUES (1, N'Bibliotekarz')
INSERT [dbo].[Role] ([Id], [Name]) VALUES (2, N'Kierownik biblioteki')
INSERT [dbo].[User] ([Id], [Name], [Password]) VALUES (1, N'Ania', N'test')
INSERT [dbo].[User_Role] ([Id], [Id_role], [Id_User]) VALUES (1, 1, 1)
INSERT [dbo].[User_Role] ([Id], [Id_role], [Id_User]) VALUES (2, 2, 1)
INSERT [dbo].[wypozyczenie] ([ID_czytelnika], [Data wyp], [Data oddania], [ID ksiazki], [Id biblioteki]) VALUES (2, CAST(N'2000-01-02' AS Date), CAST(N'2001-04-01' AS Date), 1, 1)
INSERT [dbo].[wypozyczenie] ([ID_czytelnika], [Data wyp], [Data oddania], [ID ksiazki], [Id biblioteki]) VALUES (3, CAST(N'2001-04-01' AS Date), CAST(N'2001-04-05' AS Date), 2, 1)
ALTER TABLE [dbo].[Role_permission]  WITH CHECK ADD  CONSTRAINT [permission_Permission] FOREIGN KEY([Id_permission])
REFERENCES [dbo].[Permission] ([Id])
GO
ALTER TABLE [dbo].[Role_permission] CHECK CONSTRAINT [permission_Permission]
GO
ALTER TABLE [dbo].[Role_permission]  WITH CHECK ADD  CONSTRAINT [role_Role_permission] FOREIGN KEY([Id_role])
REFERENCES [dbo].[Role] ([Id])
GO
ALTER TABLE [dbo].[Role_permission] CHECK CONSTRAINT [role_Role_permission]
GO
ALTER TABLE [dbo].[User_Role]  WITH CHECK ADD  CONSTRAINT [role1] FOREIGN KEY([Id_role])
REFERENCES [dbo].[Role] ([Id])
GO
ALTER TABLE [dbo].[User_Role] CHECK CONSTRAINT [role1]
GO
ALTER TABLE [dbo].[User_Role]  WITH CHECK ADD  CONSTRAINT [user2] FOREIGN KEY([Id_User])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[User_Role] CHECK CONSTRAINT [user2]
GO
ALTER TABLE [dbo].[wypozyczenie]  WITH CHECK ADD  CONSTRAINT [biblioteka-wypozyczenie] FOREIGN KEY([Id biblioteki])
REFERENCES [dbo].[Biblioteka] ([Id])
GO
ALTER TABLE [dbo].[wypozyczenie] CHECK CONSTRAINT [biblioteka-wypozyczenie]
GO
ALTER TABLE [dbo].[wypozyczenie]  WITH CHECK ADD  CONSTRAINT [czytelnik-wypozyczenie] FOREIGN KEY([ID_czytelnika])
REFERENCES [dbo].[Czytelnik] ([ID])
GO
ALTER TABLE [dbo].[wypozyczenie] CHECK CONSTRAINT [czytelnik-wypozyczenie]
GO
ALTER TABLE [dbo].[wypozyczenie]  WITH CHECK ADD  CONSTRAINT [ksiazka-wypozyczenie] FOREIGN KEY([ID ksiazki])
REFERENCES [dbo].[Ksiazka] ([Id_ksiazki])
GO
ALTER TABLE [dbo].[wypozyczenie] CHECK CONSTRAINT [ksiazka-wypozyczenie]
GO
USE [master]
GO
ALTER DATABASE [Biblioteka] SET  READ_WRITE 
GO
