using DAL.Entities;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Services
{
    public class PersonneService
    {
        private string _connectionStringMMSMLog;
        public string ConnectionStringMMSMLog
        {
            get { return _connectionStringMMSMLog = "server=5239;database=ADO_exo1;User Id=sa;Password=formation"; }
        }
        public IEnumerable<Personne> GetAll()
        {
            using (SqlConnection connection = new SqlConnection(ConnectionStringMMSMLog))
            {
                connection.Open();
                SqlCommand command = connection.CreateCommand();
                command.CommandText = "SELECT * FROM Personne";
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    Personne personne = new Personne()
                    {
                        Id = (int)reader["Id"],
                        Prenom = (string)reader["Prenom"],
                        Nom = (string)reader["Nom"]
                    };
                    yield return personne;
                }
            }
        }
        public Personne GetbyId(int id)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionStringMMSMLog))
            {
                connection.Open();
                SqlCommand command = connection.CreateCommand();
                command.CommandText = $"SELECT * FROM Personne WHERE Id = {id}";
                SqlDataReader reader = command.ExecuteReader();
                if (reader.Read())
                {
                    Personne personne = new Personne()
                    {
                        Id = (int)reader["Id"],
                        Prenom = (string)reader["Prenom"],
                        Nom = (string)reader["Nom"]
                    };
                    return personne;
                }
                return null;
            }
        }
        public int AddPersonne(Personne personne)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionStringMMSMLog))
            {
                connection.Open();
                SqlCommand command = connection.CreateCommand();
                command.CommandText = $"INSERT INTO Personne(Prenom, Nom, DateNaiss) " +
                                      $"VALUES(@prenom, @nom, @dateNaiss)";
                command.Parameters.AddWithValue("nom", personne.Nom);
                command.Parameters.AddWithValue("prenom", personne.Prenom);
                command.Parameters.AddWithValue("dateNaiss", personne.DateNaiss.ToString("yyyy-MM-dd"));
                return command.ExecuteNonQuery();
            }
        }
        public int DelPersonne(int id)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionStringMMSMLog))
            {
                connection.Open();
                SqlCommand command = connection.CreateCommand();
                command.CommandText = $"DELETE FROM Personne WHERE Id = @Id";
                command.Parameters.AddWithValue("Id", id);
                return command.ExecuteNonQuery();
            }
        }
    }
}
