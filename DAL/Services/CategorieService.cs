using DAL.Entities;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Services
{
    public class CategorieService
    {
        private string _connectionStringMMSMLog;
        public string ConnectionStringMMSMLog
        {
            get { return _connectionStringMMSMLog = "server=5239;database=ADO_exo1;User Id=sa;Password=formation"; }
        }
        public IEnumerable<Categorie> GetAll()
        {
            using (SqlConnection connection = new SqlConnection(ConnectionStringMMSMLog))
            {
                connection.Open();
                SqlCommand command = connection.CreateCommand();
                command.CommandText = "SELECT * FROM Categorie";
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    Categorie categorie = new Categorie()
                    {
                        Id = (int)reader["Id"],
                        Nom = (string)reader["Nom"]
                    };
                    yield return categorie;
                }

            }
        }
        public Categorie GetbyId(int id)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionStringMMSMLog))
            {
                connection.Open();
                SqlCommand command = connection.CreateCommand();
                command.CommandText = $"SELECT * FROM Categorie WHERE Id = {id}";
                SqlDataReader reader = command.ExecuteReader();
                if (reader.Read())
                {
                    Categorie categorie = new Categorie()
                    {
                        Id = (int)reader["Id"],
                        Nom = (string)reader["Nom"]
                    };
                    return categorie;
                }
                return null;
            }
        }
        public int AddCategorie(Categorie categorie)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionStringMMSMLog))
            {
                connection.Open();
                SqlCommand command = connection.CreateCommand();
                command.CommandText = $"INSERT INTO Categorie(Nom) " +
                                      $"VALUES(@nom)";
                command.Parameters.AddWithValue("nom", categorie.Nom);
                return command.ExecuteNonQuery();
            }
        }
        public int DelCategorie(int id)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionStringMMSMLog))
            {
                connection.Open();
                SqlCommand command = connection.CreateCommand();
                command.CommandText = $"DELETE FROM Categorie WHERE Id = @Id";
                command.Parameters.AddWithValue("Id", id);
                return command.ExecuteNonQuery();
            }
        }
    }
}
