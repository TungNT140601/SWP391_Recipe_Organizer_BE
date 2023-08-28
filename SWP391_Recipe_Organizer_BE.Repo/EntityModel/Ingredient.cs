﻿using System;
using System.Collections.Generic;

namespace SWP391_Recipe_Organizer_BE.Repo.EntityModel
{
    public partial class Ingredient
    {
        public Ingredient()
        {
            IngredientOfRecipes = new HashSet<IngredientOfRecipe>();
        }

        public string IngredientId { get; set; } = null!;
        public string? IngredientName { get; set; }
        public string? Measure { get; set; }
        public double? Carbohydrate { get; set; }
        public double? Protein { get; set; }
        public double? Fat { get; set; }
        public double? Calories { get; set; }
        public bool? IsDelete { get; set; }

        public virtual ICollection<IngredientOfRecipe> IngredientOfRecipes { get; set; }
    }
}
