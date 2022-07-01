/*
Script de déploiement pour ADO_exo1

Ce code a été généré par un outil.
La modification de ce fichier peut provoquer un comportement incorrect et sera perdue si
le code est régénéré.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "ADO_exo1"
:setvar DefaultFilePrefix "ADO_exo1"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Détectez le mode SQLCMD et désactivez l'exécution du script si le mode SQLCMD n'est pas pris en charge.
Pour réactiver le script une fois le mode SQLCMD activé, exécutez ce qui suit :
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'Le mode SQLCMD doit être activé de manière à pouvoir exécuter ce script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Création de la base de données $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Impossible de modifier les paramètres de base de données. Vous devez être administrateur système pour appliquer ces paramètres.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Impossible de modifier les paramètres de base de données. Vous devez être administrateur système pour appliquer ces paramètres.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Création de Table [dbo].[Categorie]...';


GO
CREATE TABLE [dbo].[Categorie] (
    [Id]  INT          IDENTITY (1, 1) NOT NULL,
    [Nom] VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_Categorie] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de Table [dbo].[Personne]...';


GO
CREATE TABLE [dbo].[Personne] (
    [Id]        INT           IDENTITY (1, 1) NOT NULL,
    [Prenom]    VARCHAR (50)  NOT NULL,
    [Nom]       VARCHAR (50)  NOT NULL,
    [DateNaiss] DATETIME2 (7) NOT NULL,
    [Adresse]   INT           NULL,
    CONSTRAINT [PK_Personne] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de Table [dbo].[Tache]...';


GO
CREATE TABLE [dbo].[Tache] (
    [Id]           INT           IDENTITY (1, 1) NOT NULL,
    [Nom]          VARCHAR (50)  NOT NULL,
    [CategorieId]  INT           NOT NULL,
    [Descr]        VARCHAR (50)  NOT NULL,
    [DateCreation] DATETIME2 (7) NOT NULL,
    [DateFinEstim] DATETIME2 (7) NOT NULL,
    [DateFinEff]   DATETIME2 (7) NULL,
    [PersonneId]   INT           NOT NULL,
    CONSTRAINT [PK_Tache] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de Clé étrangère [dbo].[FK_Tache_Personne]...';


GO
ALTER TABLE [dbo].[Tache]
    ADD CONSTRAINT [FK_Tache_Personne] FOREIGN KEY ([PersonneId]) REFERENCES [dbo].[Personne] ([Id]);


GO
PRINT N'Création de Clé étrangère [dbo].[FK_Tache_Categorie]...';


GO
ALTER TABLE [dbo].[Tache]
    ADD CONSTRAINT [FK_Tache_Categorie] FOREIGN KEY ([CategorieId]) REFERENCES [dbo].[Categorie] ([Id]);


GO
PRINT N'Création de Contrainte de validation [dbo].[CK_Tache_DateFinEff]...';


GO
ALTER TABLE [dbo].[Tache]
    ADD CONSTRAINT [CK_Tache_DateFinEff] CHECK (DateFinEff > DateCreation);


GO
USE ADO_exo1

ALTER TABLE Tache DROP CONSTRAINT FK_Tache_Personne;
ALTER TABLE Tache DROP CONSTRAINT FK_Tache_Categorie;
TRUNCATE TABLE Tache;
TRUNCATE TABLE Personne;
TRUNCATE TABLE Categorie;
ALTER TABLE Tache ADD CONSTRAINT FK_Tache_Personne FOREIGN KEY (PersonneId) REFERENCES Personne(Id);
ALTER TABLE Tache ADD CONSTRAINT FK_Tache_Categorie FOREIGN KEY (CategorieId) REFERENCES Categorie(Id);

INSERT INTO Categorie VALUES ('Jardinage');
INSERT INTO Categorie VALUES ('Bricolage');
INSERT INTO Categorie VALUES ('Ménage');
INSERT INTO Categorie VALUES ('Autre');

INSERT INTO Personne (Prenom, Nom, DateNaiss) VALUES
('Jésus', 'de Nazareth', '3000-01-01 00:00:00'),
('Elizabeth II', 'Alexandra Mary', '1926-04-21 00:00:00'),
('Cassius', 'Clay', '1942-01-17 00:00:00'),
('Yoko', 'Ono', '1933-02-18 00:00:00');


INSERT INTO Tache (Nom, CategorieId, Descr, DateCreation, DateFinEstim, PersonneId) VALUES
('Tache 1', 0, 'La première tâche', '2022-27-06 00:00:00', '2022-28-06 00:00:00' , 1),
('Tache 2', 1, 'La deuxième tâche', '2022-27-06 00:00:00', '2022-29-06 00:00:00' , 0),
('Tache 3', 2, 'La troisième tâche', '2022-27-06 00:00:00', '2023-31-01 00:00:00' , 2),
('Tache 4', 1, 'La quatirème tâche', '2022-27-06 00:00:00', '2024-28-06 00:00:00' , 3),
('Tache 5', 3, 'La cinquième tâche', '2022-27-06 00:00:00', '2022-04-10 00:00:00' , 2)
;

GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Mise à jour terminée.';


GO
