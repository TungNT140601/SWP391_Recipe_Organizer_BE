using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Repo.EntityModel
{
    public class IngredientOfRecipe
    {
        public IngredientOfRecipe()
        {

        }
        public string IngredientId { get; set; }
        public string RecipeId { get; set; }
        public string Description { get; set; }
        public virtual Ingredient Ingredient { get; set; }
        public virtual Recipe Recipe { get; set; }
    }
}
