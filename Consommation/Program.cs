using DAL.Entities;
using DAL.Services;
using System;
using System.Collections.Generic;

namespace Consommation
{
    internal class Program
    {
        static void AddTache()
        {
            Console.CursorVisible = true;
            Console.Write("Nom : ");
            string nom = Console.ReadLine();
            Console.Write("Description : ");
            string description = Console.ReadLine();
            Console.Write("Catégorie id : ");
            int categorieId = int.Parse(Console.ReadLine());
            Console.Write("Personne id : ");
            int personneId = int.Parse(Console.ReadLine());
            TacheService tacheConnection = new TacheService();
            Tache tacheAdd = new Tache()
            {
                Nom = nom,
                Description = description,
                CategorieId = categorieId,
                DateCreation = DateTime.Now,
                DateFinEstim = DateTime.Now.AddYears(100),
                DateFinEff = null,
                PersonneId = personneId
            };
            if (tacheConnection.AddTache(tacheAdd) > 0) Console.WriteLine("Tâche ajoutée");
        }       
        static void AddPersonne()
        {
            Console.CursorVisible = true;
            Console.Write("Nom : ");
            string nom = Console.ReadLine();
            Console.Write("Prenom : ");
            string prenom = Console.ReadLine();
            PersonneService personneConnection = new PersonneService();
            Personne personneAdd = new Personne()
            {
                Nom = nom,
                Prenom = prenom,
                DateNaiss = DateTime.Now
            };
            if (personneConnection.AddPersonne(personneAdd) > 0) Console.WriteLine("Personne ajoutée");
        }
        static void AddCategorie()
        {
            Console.CursorVisible = true;
            Console.Write("Nom : ");
            string nom = Console.ReadLine();
            CategorieService categorieConnection = new CategorieService();
            Categorie categorieAdd = new Categorie()
            {
                Nom = nom
            };
            if (categorieConnection.AddCategorie(categorieAdd) > 0) Console.WriteLine("Catégorie ajoutée");
        }
        static void DeleteTache()
        {
            Console.CursorVisible = true;
            TacheService tacheConnection = new TacheService();
            Console.Write("Tache à supprimer : ");
            int id = 0;
            if (int.TryParse(Console.ReadLine(), out id))
            {
                if (tacheConnection.DelTache(id) > 0) Console.WriteLine("Tâche surpprimée"); ;
            }
        }        
        static void DeletePersonne()
        {
            Console.CursorVisible = true;
            PersonneService personneConnection = new PersonneService();
            Console.Write("Personne à supprimer : ");
            int id = 0;
            if (int.TryParse(Console.ReadLine(), out id))
            {
                if (personneConnection.DelPersonne(id) > 0) Console.WriteLine("Personne supprimée"); ;
            }
        }        
        static void DeleteCategorie()
        {
            Console.CursorVisible = true;
            CategorieService categorieConnection = new CategorieService();
            Console.Write("Catégorie à supprimer : ");
            int id = 0;
            if (int.TryParse(Console.ReadLine(), out id))
            {
                if (categorieConnection.DelCategorie(id) > 0) Console.WriteLine("Catégorie supprimée");
            }
        }
        static void MarkEndTache()
        {
            Console.CursorVisible = true;
            TacheService tacheConnection = new TacheService();
            Console.Write("Tâche à finir : ");
            int id = 0;
            if (int.TryParse(Console.ReadLine(), out id))
            {
                if (tacheConnection.EndTask(id) > 0) Console.WriteLine("Tâche finie"); ;
            }
        }
        static void ShowTaches(int type, int id)
        {
            TacheService tacheConnection = new TacheService();
            PersonneService personneConnection = new PersonneService();
            CategorieService categorieConnection = new  CategorieService();
            IEnumerable<Tache> taches = null;
            switch (type)
            {
                case 0:
                    taches = tacheConnection.GetbyCategory(id);
                    break;
                case 1:
                    taches = tacheConnection.GetbyPersonne(id);
                    break;
                case 2:
                    taches = tacheConnection.GetAll();
                    break;
                case 3:
                    taches = tacheConnection.GetNotFinished();
                    break;
            }
            int x = 0;
            int y = 0;
            Console.WriteLine("Liste des tâches :\n");
            foreach (Tache tache in taches)
            {
                Personne personne = personneConnection.GetbyId(tache.PersonneId);
                Categorie categorie = categorieConnection.GetbyId(tache.CategorieId);
                x = Console.GetCursorPosition().ToTuple().Item1;
                y = Console.GetCursorPosition().ToTuple().Item2;
                Console.Write($"[{tache.Id}]");
                Console.SetCursorPosition(6, y);
                Console.Write(tache.Nom);
                Console.SetCursorPosition(30, y);
                Console.Write(tache.Description);
                Console.SetCursorPosition(75, y);
                Console.Write($"Créa. : {tache.DateCreation.Day}-{tache.DateCreation.Month}-{tache.DateCreation.Year}");
                Console.SetCursorPosition(97, y);
                Console.Write($"Estim. : {tache.DateFinEstim.Day}-{tache.DateFinEstim.Month}-{tache.DateFinEstim.Year}");
                Console.SetCursorPosition(120, y);
                Console.Write($"Fin : {((tache.DateFinEff is not null)? (tache.DateFinEstim.Day + "-" + tache.DateFinEstim.Month + "-" + tache.DateFinEstim.Year) : "/")}");
                Console.SetCursorPosition(140, y);
                Console.Write($"{((categorie is not null) ? categorie.Nom : "/")}");
                Console.SetCursorPosition(160, y);
                Console.Write($"{((personne is not null) ? (personne.Prenom + " " + personne.Nom) : "/")}\n");
            }
        }
        static void ShowPersonnes()
        {
            PersonneService personneConnection = new PersonneService();
            IEnumerable<Personne> personnes = personneConnection.GetAll();
            Console.WriteLine("Liste des personnes :");
            Console.WriteLine();
            foreach (Personne personne in personnes)
            {
                Console.WriteLine($"[{personne.Id}] {personne.Prenom} {personne.Nom}");
            }
        }
        static void ShowCategories()
        {
            CategorieService categorieConnection = new CategorieService();
            IEnumerable<Categorie> categories = categorieConnection.GetAll();
            Console.WriteLine("Liste des catégories :");
            Console.WriteLine();
            foreach (Categorie categorie in categories)
            {
                Console.WriteLine($"[{categorie.Id}] {categorie.Nom}");
            }
        }
        static void SubMenu(int type)
        {
            ConsoleKeyInfo key2;
            if(type == 0 || type == 1) Console.WriteLine("\nOptions : [a] Ajouter - [s] Supprimer");
            else Console.WriteLine("\nOptions : [a] Ajouter - [s] Supprimer - [f] Finir tâche\n" +
                                   "\t  [c] Afficher tâches / cat - [p] Afficher tâches / personne - [n] Afficher tâches non terminées");
            key2 = Console.ReadKey(true);
            switch (key2.Key)
            {
                case ConsoleKey.A:
                    switch (type)
                    {
                        case 0:
                            AddCategorie();
                            break;
                        case 1:
                            AddPersonne();
                            break;
                        case 2:
                            AddTache();
                            break;
                    }
                    break;
                case ConsoleKey.S:
                    switch (type)
                    {
                        case 0:
                            DeleteCategorie();
                            break;
                        case 1:
                            DeletePersonne();
                            break;
                        case 2:
                            DeleteTache();
                            break;
                    }
                    break;
                case ConsoleKey.C:
                    if (type == 2)
                    {
                        Console.CursorVisible = true;
                        Console.Write("Id de la catégorie : ");
                        int id = 0;
                        if (int.TryParse(Console.ReadLine(), out id))
                        {
                            Console.WriteLine();
                            ShowTaches(0, id);
                        }
                    }
                    break;
                case ConsoleKey.P:
                    if (type == 2)
                    {
                        Console.CursorVisible = true;
                        Console.Write("Id de la personne : ");
                        int id = 0;
                        if (int.TryParse(Console.ReadLine(), out id))
                        {
                            Console.WriteLine();
                            ShowTaches(1, id);
                        }
                    }
                    break;
                case ConsoleKey.N:
                    Console.WriteLine();
                    if(type == 2) ShowTaches(3, 0);
                    break;
                case ConsoleKey.F:
                    if (type == 2) MarkEndTache();
                    break;
            }
            if(key2.Key != ConsoleKey.Escape) Console.ReadLine();
        }
        static void Main(string[] args)
        {
            Console.SetWindowSize((int)(Console.LargestWindowWidth / 1.1), (int)(Console.LargestWindowHeight/ 1.15));
            bool cont = true;
            while (cont)
            {
                Console.Clear();
                Console.CursorVisible = false;
                ShowTaches(2, 0);
                Console.WriteLine();
                ShowPersonnes();
                Console.WriteLine();
                ShowCategories();
                Console.WriteLine("\nModifier table : [t] Taches - [p] Personnes - [c] Categories");
                ConsoleKeyInfo key = Console.ReadKey(true);
                switch (key.Key)
                {
                    case ConsoleKey.T:
                        SubMenu(2);
                        break;
                    case ConsoleKey.P:
                        SubMenu(1);
                        break;
                    case ConsoleKey.C:
                        SubMenu(0);
                        break;
                    case ConsoleKey.Escape:
                        cont = false;
                        break;
                }
            }

        }
    }
}
