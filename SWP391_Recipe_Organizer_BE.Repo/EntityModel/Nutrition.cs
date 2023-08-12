using System;
using System.Collections.Generic;

namespace SWP391_Recipe_Organizer_BE.Repo.EntityModel
{
    public partial class Nutrition
    {
        public Nutrition()
        {
            NutritionInRecipes = new HashSet<NutritionInRecipe>();
        }

        public string NutritionId { get; set; } = null!;
        public string? NutritionName { get; set; }
        public bool? IsDelete { get; set; }

        public virtual ICollection<NutritionInRecipe> NutritionInRecipes { get; set; }
    }
}
