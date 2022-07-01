using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Entities
{
    public class Personne
    {
        #region fields
        private int _id;
        private string _prenom;
        private string _nom;
        private DateTime _dateNaiss;
        private string _adresse;
        #endregion

        #region properties
        public int Id
        {
            get { return _id; }
            set { _id = value; }
        }
        public string Prenom
        {
            get { return _prenom; }
            set { _prenom = value; }
        }
        public string Nom
        {
            get { return _nom; }
            set { _nom = value; }
        }
        public DateTime DateNaiss
        {
            get { return _dateNaiss; }
            set { _dateNaiss = value; }
        }
        public string Adresse
        {
            get { return _adresse; }
            set { _adresse = value; }
        } 
        #endregion
    }
}
