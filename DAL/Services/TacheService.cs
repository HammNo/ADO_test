using DAL.Entities;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Services
{
    public class TacheService
    {
        private string _connectionStringMMSMLog;
        public string ConnectionStringMMSMLog
        {
            get { return _connectionStringMMSMLog = "server=5239;database=ADO_exo1;User Id=sa;Password=formation"; }
        }
        public IEnumerable<Tache> GetRangeTaches(int type, int id)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionStringMMSMLog))
            {
                connection.Open();
                SqlCommand command = connection.CreateCommand();
                if (type == 0) command.CommandText = "SELECT * FROM Tache WHERE CategorieId = @id";
                else if (type == 1) command.CommandText = "SELECT * FROM Tache WHERE PersonneId = @id";
                else if (type == 3) command.CommandText = "SELECT * FROM Tache WHERE DateFinEff IS NULL";
                else command.CommandText = "SELECT * FROM Tache";
                command.Parameters.AddWithValue("id", id);
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    Tache tache = new Tache()
                    {
                        Id = (int)reader["Id"],
                        Nom = (string)reader["Nom"],
                        CategorieId = (int)reader["CategorieId"],
                        Description = (string)reader["Descr"],
                        DateCreation = (DateTime)reader["DateCreation"],
                        DateFinEstim = (DateTime)reader["DateFinEstim"],
                        DateFinEff = (reader["DateFinEff"] != DBNull.Value)? (DateTime?) reader["DateFinEff"] : null,
                        PersonneId = (int)reader["PersonneId"]
                    };
                    yield return tache;
                }
            }
        }
        public Tache GetbyId(int id)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionStringMMSMLog))
            {
                connection.Open();
                SqlCommand command = connection.CreateCommand();
                command.CommandText = $"SELECT * FROM Tache WHERE Id = @id";
                command.Parameters.AddWithValue("id", id);
                SqlDataReader reader = command.ExecuteReader();
                if (reader.Read())
                {
                    Tache tache = new Tache()
                    {
                        Id = (int)reader["Id"],
                        Nom = (string)reader["Nom"],
                        CategorieId = (int)reader["CategorieId"],
                        Description = (string)reader["Descr"],
                        DateCreation = (DateTime)reader["DateCreation"],
                        DateFinEstim = (DateTime)reader["DateFinEstim"],
                        PersonneId = (int)reader["PersonneId"]
                    };
                    return tache;
                }
                return null;
            }
        }
        public int AddTache(Tache tache)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionStringMMSMLog))
            {
                connection.Open();
                SqlCommand command = connection.CreateCommand();
                command.CommandText = $"INSERT INTO Tache(Nom, CategorieId, Descr, DateCreation, DateFinEstim, PersonneId) " +
                                      $"VALUES(@nom, @categorieId, @description, @dateCreation, @dateFinEstim, @personneId)";
                command.Parameters.AddWithValue("nom", tache.Nom);
                command.Parameters.AddWithValue("categorieId", tache.CategorieId);
                command.Parameters.AddWithValue("description", tache.Description);
                command.Parameters.AddWithValue("dateCreation", tache.DateCreation.ToString("yyyy-MM-dd"));
                command.Parameters.AddWithValue("dateFinEstim", tache.DateFinEstim.ToString("yyyy-MM-dd"));
                command.Parameters.AddWithValue("personneId", tache.PersonneId);
                return command.ExecuteNonQuery();
            }
        }
        public int EndTask(int id)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionStringMMSMLog))
            {
                connection.Open();
                SqlCommand command = connection.CreateCommand();
                command.CommandText = $"UPDATE Tache SET DateFinEff = @dateFinEff WHERE Id = @id";
                command.Parameters.AddWithValue("id", id);
                command.Parameters.AddWithValue("dateFinEff", DateTime.Now.ToString("yyyy-MM-dd"));
                return command.ExecuteNonQuery();
            }
        }
        public int DelTache(int id)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionStringMMSMLog))
            {
                connection.Open();
                SqlCommand command = connection.CreateCommand();
                command.CommandText = $"DELETE FROM Tache WHERE Id = @Id";
                command.Parameters.AddWithValue("Id", id);
                return command.ExecuteNonQuery();
            }
        }
        public TacheService()
        {
        }
    }
}
