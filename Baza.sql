USE [master]
GO
/****** Object:  Database [Biblioteka]    Script Date: 20.05.2019 19:31:31 ******/
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
/****** Object:  Table [dbo].[Biblioteka]    Script Date: 20.05.2019 19:31:31 ******/
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
/****** Object:  Table [dbo].[Czytelnik]    Script Date: 20.05.2019 19:31:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Czytelnik](
	[Imie] [varchar](50) NULL,
	[Nazwisko] [varchar](50) NULL,
	[Id] [int] NOT NULL,
 CONSTRAINT [PK_Czytelnik] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ksiazka]    Script Date: 20.05.2019 19:31:31 ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 20.05.2019 19:31:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[User_name] [varchar](20) NOT NULL,
	[Actual_role] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[User_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Wypozyczenie]    Script Date: 20.05.2019 19:31:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Wypozyczenie](
	[Id] [int] NOT NULL,
	[Id_czytelnika] [int] NULL,
	[User_name] [varchar](20) NULL,
	[Data_wypozyczenia] [date] NULL,
	[Data_oddania] [date] NULL,
	[Id ksiazki] [int] NULL,
	[Id biblioteki] [int] NULL,
 CONSTRAINT [PK_Wypozyczenie] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Biblioteka] ([Id], [Miejscowosc], [Nazwa], [Ulica]) VALUES (1, N'Gdansk', N'Numer 1', N'Miszewskiego')
INSERT [dbo].[Czytelnik] ([Imie], [Nazwisko], [Id]) VALUES (N'Michal', N'Kowalski', 1)
INSERT [dbo].[Czytelnik] ([Imie], [Nazwisko], [Id]) VALUES (N'Anna', N'Maria', 2)
INSERT [dbo].[Czytelnik] ([Imie], [Nazwisko], [Id]) VALUES (N'Julian', N'Nowak', 3)
INSERT [dbo].[Ksiazka] ([Tytul], [Rok_wydania], [Autor], [Id_ksiazki]) VALUES (N'Szklanka', CAST(N'2008-02-01' AS Date), N'Adam ', 1)
INSERT [dbo].[Ksiazka] ([Tytul], [Rok_wydania], [Autor], [Id_ksiazki]) VALUES (N'Laptop', CAST(N'2001-05-02' AS Date), N'Julia', 2)
INSERT [dbo].[Ksiazka] ([Tytul], [Rok_wydania], [Autor], [Id_ksiazki]) VALUES (N'Slomka', CAST(N'2000-05-01' AS Date), N'Marek3', 3)
INSERT [dbo].[Ksiazka] ([Tytul], [Rok_wydania], [Autor], [Id_ksiazki]) VALUES (N'Slomka', CAST(N'2000-05-01' AS Date), N'asd', 5)
INSERT [dbo].[Ksiazka] ([Tytul], [Rok_wydania], [Autor], [Id_ksiazki]) VALUES (N'Cebula', CAST(N'2001-05-02' AS Date), N'Adamjan37', 7)
INSERT [dbo].[Ksiazka] ([Tytul], [Rok_wydania], [Autor], [Id_ksiazki]) VALUES (N'Cebula', CAST(N'2001-05-02' AS Date), N'Andrej', 8)
INSERT [dbo].[Ksiazka] ([Tytul], [Rok_wydania], [Autor], [Id_ksiazki]) VALUES (N'Cebula', CAST(N'2001-05-02' AS Date), N'Andrej', 9)
INSERT [dbo].[User] ([User_name], [Actual_role]) VALUES (N'login', N'Admin')
ALTER TABLE [dbo].[Wypozyczenie]  WITH CHECK ADD  CONSTRAINT [Biblioteka_Wypozyczenie] FOREIGN KEY([Id biblioteki])
REFERENCES [dbo].[Biblioteka] ([Id])
GO
ALTER TABLE [dbo].[Wypozyczenie] CHECK CONSTRAINT [Biblioteka_Wypozyczenie]
GO
ALTER TABLE [dbo].[Wypozyczenie]  WITH CHECK ADD  CONSTRAINT [Czytelnik_Wypozyczenie] FOREIGN KEY([Id_czytelnika])
REFERENCES [dbo].[Czytelnik] ([Id])
GO
ALTER TABLE [dbo].[Wypozyczenie] CHECK CONSTRAINT [Czytelnik_Wypozyczenie]
GO
ALTER TABLE [dbo].[Wypozyczenie]  WITH CHECK ADD  CONSTRAINT [Ksiazka_Wypozyczenie] FOREIGN KEY([Id ksiazki])
REFERENCES [dbo].[Ksiazka] ([Id_ksiazki])
GO
ALTER TABLE [dbo].[Wypozyczenie] CHECK CONSTRAINT [Ksiazka_Wypozyczenie]
GO
ALTER TABLE [dbo].[Wypozyczenie]  WITH CHECK ADD  CONSTRAINT [User_Wypozyczenie] FOREIGN KEY([User_name])
REFERENCES [dbo].[User] ([User_name])
GO
ALTER TABLE [dbo].[Wypozyczenie] CHECK CONSTRAINT [User_Wypozyczenie]
GO
USE [master]
GO
ALTER DATABASE [Biblioteka] SET  READ_WRITE 
GO
