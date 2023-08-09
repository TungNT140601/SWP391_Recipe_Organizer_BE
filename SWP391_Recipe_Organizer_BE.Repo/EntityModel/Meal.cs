using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Repo.EntityModel
{
    public class Meal
    {
        public Meal()
        {
            Recipes = new HashSet<Recipe>();
        }
        public string MealId { get; set; }
        public string MealName { get; set; }
        public virtual IEnumerable<Recipe> Recipes { get; set; }
    }
}
