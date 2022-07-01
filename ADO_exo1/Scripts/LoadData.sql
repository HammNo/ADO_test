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
('Yoko', 'Ono', '1933-02-18 00:00:00'),
('Christophe', 'Colomb', '1451-01-01 00:00:00'),
('Marilyn', 'Monroe', '1926-06-01 00:00:00'),
('Tokien', 'J.R.R.', '1892-01-31 00:00:00'),
('Galadriel', 'reine des elfes', '5000-12-31 00:00:00');


INSERT INTO Tache (Nom, CategorieId, Descr, DateCreation, DateFinEstim, PersonneId) VALUES
('Repasser linge', 3, 'Le linge aime être repassé', CAST(GETDATE() as datetime2), '2022-06-28 00:00:00' , 8),
('Nettoyer gouttière', 2, 'Il ne faudrait pas que ça déborde', CAST(GETDATE() as datetime2), '2022-06-29 00:00:00' , 1),
('Tailler ronces', 1, 'Aie ça pique', CAST(GETDATE() as datetime2), '2022-10-04 00:00:00', 4),
('Entretenir potager', 1, 'Beaucoup d eau...', CAST(GETDATE() as datetime2), '2024-06-08 00:00:00' , 7),
('Réparer toiture', 2, 'Et puis le déluge', CAST(GETDATE() as datetime2), '2022-10-04 00:00:00' , 6),
('Réparer porte chambre', 2, 'Qui l a cassée?', CAST(GETDATE() as datetime2), '2022-10-04 00:00:00' , 3),
('Arroser les camélias', 1, 'Même si c est pas beau', CAST(GETDATE() as datetime2), '2022-10-04 00:00:00' , 4),
('Préparer thé', 4, 'Pour se détendre', CAST(GETDATE() as datetime2), '2022-10-04 00:00:00' , 3),
('Manger pastèque', 4, 'Mais proprement', CAST(GETDATE() as datetime2), '2022-10-04 00:00:00' , 2);

