using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Entities
{
    public class Categorie
    {
        #region fields
        private int _id;
        private string _nom;
        #endregion

        #region properties
        public int Id
        {
            get { return _id; }
            set { _id = value; }
        }
        public string Nom
        {
            get { return _nom; }
            set { _nom = value; }
        } 
        #endregion
    }
}
