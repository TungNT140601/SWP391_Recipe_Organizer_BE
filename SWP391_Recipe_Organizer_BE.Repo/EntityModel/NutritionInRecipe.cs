using System;
using System.Collections.Generic;

namespace SWP391_Recipe_Organizer_BE.Repo.EntityModel
{
    public partial class NutritionInRecipe
    {
        public string? NutritionId { get; set; }
        public string? RecipeId { get; set; }
        public int? Quantity { get; set; }

        public virtual Nutrition? Nutrition { get; set; }
        public virtual Recipe? Recipe { get; set; }
    }
}
