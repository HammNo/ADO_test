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
USE [$(DatabaseName)];


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
('Tache 1', 0, 'La première tâche', '2022-06-27 00:00:00', '2022-06-28 00:00:00' , 1),
('Tache 2', 1, 'La deuxième tâche', '2022-06-27 00:00:00', '2022-06-29 00:00:00' , 0),
('Tache 3', 2, 'La troisième tâche', '2022-06-27 00:00:00', '2023-01-31 00:00:00' , 2),
('Tache 4', 1, 'La quatirème tâche', '2022-06-27 00:00:00', '2024-06-08 00:00:00' , 3),
('Tache 5', 3, 'La cinquième tâche', '2022-06-27 00:00:00', '2022-10-04 00:00:00' , 2)
;

GO

GO
PRINT N'Mise à jour terminée.';


GO
