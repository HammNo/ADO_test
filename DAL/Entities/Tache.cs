using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Entities
{
    public class Tache
    {
        #region fields
        private int _id;
        private int _categorieId;
        private string _nom;
        private int _personneId;
        private string _description;
        private DateTime _dateCreation;
        private DateTime _dateFinEstim;
        private DateTime? _dateFinEff;
        #endregion

        #region properties
        public int Id
        {
            get { return _id; }
            set { _id = value; }
        }
        public int CategorieId
        {
            get { return _categorieId; }
            set { _categorieId = value; }
        }
        public int PersonneId
        {
            get { return _personneId; }
            set { _personneId = value; }
        }
        public string Description
        {
            get { return _description; }
            set { _description = value; }
        }
        public string Nom
        {
            get { return _nom; }
            set { _nom = value; }
        }
        public DateTime DateCreation
        {
            get { return _dateCreation; }
            set { _dateCreation = value; }
        }
        public DateTime DateFinEstim
        {
            get { return _dateFinEstim; }
            set { _dateFinEstim = value; }
        }
        public DateTime? DateFinEff
        {
            get { return _dateFinEff; }
            set { _dateFinEff = value; }
        } 
        #endregion
    }
}
