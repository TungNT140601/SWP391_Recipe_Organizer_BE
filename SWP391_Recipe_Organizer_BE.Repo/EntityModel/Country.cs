using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Repo.EntityModel
{
    public class Country
    {
        public Country()
        {
            Recipes = new HashSet<Recipe>();
        }
        public string CountryId { get; set; }
        public string CountryName { get; set; }
        public bool HasRecipe { get; set; } = false;
        public virtual IEnumerable<Recipe> Recipes { get; set; }
    }
}
