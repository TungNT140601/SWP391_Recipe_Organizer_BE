using System;
using System.Collections.Generic;

namespace SWP391_Recipe_Organizer_BE.Repo.EntityModel
{
    public partial class Recipe
    {
        public Recipe()
        {
            Directions = new HashSet<Direction>();
            FavoriteRecipes = new HashSet<FavoriteRecipe>();
            IngredientOfRecipes = new HashSet<IngredientOfRecipe>();
            NutritionInRecipes = new HashSet<NutritionInRecipe>();
            Photos = new HashSet<Photo>();
            PlanDetails = new HashSet<PlanDetail>();
            Reviews = new HashSet<Review>();
        }

        public string RecipeId { get; set; } = null!;
        public string? RecipeName { get; set; }
        public string? UserId { get; set; }
        public string? CountryId { get; set; }
        public string? MealId { get; set; }
        public string? Description { get; set; }
        public int? PrepTime { get; set; }
        public int? CookTime { get; set; }
        public int? StandTime { get; set; }
        public int? TotalTime { get; set; }
        public int? Servings { get; set; }
        public DateTime? CreateTime { get; set; }
        public DateTime? UpdateTime { get; set; }
        public DateTime? DeleteTime { get; set; }
        public bool? IsDelete { get; set; }

        public virtual Country? Country { get; set; }
        public virtual Meal? Meal { get; set; }
        public virtual UserAccount? User { get; set; }
        public virtual ICollection<Direction> Directions { get; set; }
        public virtual ICollection<FavoriteRecipe> FavoriteRecipes { get; set; }
        public virtual ICollection<IngredientOfRecipe> IngredientOfRecipes { get; set; }
        public virtual ICollection<NutritionInRecipe> NutritionInRecipes { get; set; }
        public virtual ICollection<Photo> Photos { get; set; }
        public virtual ICollection<PlanDetail> PlanDetails { get; set; }
        public virtual ICollection<Review> Reviews { get; set; }
    }
}


