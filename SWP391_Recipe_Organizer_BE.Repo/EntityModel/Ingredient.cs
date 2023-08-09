using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Repo.EntityModel
{
    public class Ingredient
    {
        public Ingredient()
        {
            IngredientOfRecipes = new HashSet<IngredientOfRecipe>();
        }
        public string IngredientId { get; set; }
        public string IngredientName { get; set; }
        public virtual IEnumerable<IngredientOfRecipe> IngredientOfRecipes { get; set; }
    }
}
