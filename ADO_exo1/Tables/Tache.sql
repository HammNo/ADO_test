CREATE TABLE [dbo].[Tache]
(
	[Id] INT NOT NULL IDENTITY,
	[Nom] VARCHAR(50) NOT NULL,
	[CategorieId] int NOT NULL,
	[Descr] VARCHAR(50) NOT NULL,
	[DateCreation] DATETIME2 NOT NULL,
	[DateFinEstim] DATETIME2 NOT NULL,
	[DateFinEff] DATETIME2 NULL,
	[PersonneId] int NOT NULL,
	CONSTRAINT [PK_Tache] PRIMARY KEY ([Id]),
    CONSTRAINT [CK_Tache_DateFinEff] CHECK (DateFinEff > DateCreation),
	CONSTRAINT [FK_Tache_Personne] FOREIGN KEY ([PersonneId]) REFERENCES [Personne]([Id]),
    CONSTRAINT [FK_Tache_Categorie] FOREIGN KEY ([CategorieId]) REFERENCES [Categorie]([Id])
)