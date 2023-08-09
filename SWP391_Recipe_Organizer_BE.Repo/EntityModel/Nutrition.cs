using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Repo.EntityModel
{
    public class Nutrition
    {
        public Nutrition() { }
        public string NutritionId { get; set; }
        public string NutritionName { get; set; }
        public virtual IEnumerable<NutritionInRecipe> NutritionInRecipes { get; set; }
    }
}
