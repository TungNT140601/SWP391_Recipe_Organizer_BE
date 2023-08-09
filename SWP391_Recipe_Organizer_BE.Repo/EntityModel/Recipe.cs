using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Repo.EntityModel
{
    public class Recipe
    {
        public Recipe()
        {
            FavoriteRecipes = new HashSet<FavoriteRecipe>();
            Reviews = new HashSet<Review>();
            Photos = new HashSet<Photo>();
            Directions = new HashSet<Direction>();
            IngredientOfRecipes = new HashSet<IngredientOfRecipe>();
            NutritionInRecipes = new HashSet<NutritionInRecipe>();
        }
        public string RecipeId { get; set; }
        public string RecipeName { get; set; }
        public string UserId { get; set; }
        public string CountryId { get; set; }
        public string MealId { get; set; }
        public string Description { get; set; }
        public int PrepTime { get; set; }
        public int CookTime { get; set; }
        public int StandTime { get; set; }
        public int TotalTime { get; set; }
        public int Servings { get; set; }
        public DateTime CreateTime { get; set; }
        public DateTime UpdateTime { get; set; }
        public DateTime DeleteTime { get; set; }
        public bool IsDelete { get; set; }
        public virtual UserAccount? UserAccount { get; set; }
        public virtual Meal? Meal { get; set; }
        public virtual Country? Country { get; set; }
        public virtual PlanDetail? PlanDetail { get; set; }
        public virtual IEnumerable<FavoriteRecipe> FavoriteRecipes { get; set; }
        public virtual IEnumerable<Review> Reviews { get; set; }
        public virtual IEnumerable<Photo> Photos { get; set; }
        public virtual IEnumerable<Direction> Directions { get; set; }
        public virtual IEnumerable<IngredientOfRecipe> IngredientOfRecipes { get; set; }
        public virtual IEnumerable<NutritionInRecipe> NutritionInRecipes { get; set; }
    }
}
