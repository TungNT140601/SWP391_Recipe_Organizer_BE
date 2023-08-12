using System;
using System.Collections.Generic;

namespace SWP391_Recipe_Organizer_BE.Repo.EntityModel
{
    public partial class IngredientOfRecipe
    {
        public string IngredientId { get; set; } = null!;
        public string RecipeId { get; set; } = null!;
        public string? Description { get; set; }

        public virtual Ingredient Ingredient { get; set; } = null!;
        public virtual Recipe Recipe { get; set; } = null!;
    }
}
