using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using SWP391_Recipe_Organizer_BE.Repo.Interface;
using SWP391_Recipe_Organizer_BE.Service.Interface;
using SWP391_Recipe_Organizer_BE.Ultility;
using System.ComponentModel;

namespace SWP391_Recipe_Organizer_BE.Service.Services
{
    public class RecipeService : IRecipeService
    {
        private readonly IRecipeRepository recipeRepository;
        public RecipeService(IRecipeRepository recipeRepository)
        {
            this.recipeRepository = recipeRepository;
        }
        public bool Add(Recipe item)
        {
            try
            {
                item.RecipeId = GenerateId.AutoGenerateId();
                item.CreateTime = DateTime.Now;
                item.UpdateTime = DateTime.Now;
                item.IsDelete = false;
                return recipeRepository.Add(item);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public Recipe Get(string id)
        {
            try
            {
                var recipe = recipeRepository.Get(x => x.RecipeId == id && x.IsDelete == false, new System.Linq.Expressions.Expression<Func<Recipe, object>>[]
                {
                    x => x.Directions,
                    x => x.FavoriteRecipes,
                    x => x.Photos,
                    x => x.PlanDetails,
                    x => x.Reviews,
                });
                return recipe;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public IEnumerable<Recipe> GetAll()
        {
            try
            {
                return recipeRepository.GetAll(x => x.IsDelete == false, new System.Linq.Expressions.Expression<Func<Recipe, object>>[]
                {
                    x => x.Directions,
                    x => x.FavoriteRecipes,
                    x => x.Photos,
                    x => x.PlanDetails,
                    x => x.Reviews });
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public bool Delete(string id)
        {
            try
            {
                var recipe = recipeRepository.Get(x => x.RecipeId == id && x.IsDelete == false);
                if (recipe != null)
                {
                    recipe.DeleteTime = DateTime.Now;
                    recipe.IsDelete = true;
                    return recipeRepository.Update(recipe);
                }
                else
                {
                    throw new Exception("Not Found Recipe");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public bool Update(Recipe item)
        {
            try
            {
                var recipe = recipeRepository.Get(x => x.RecipeId == item.RecipeId && x.IsDelete == false);
                if (recipe != null)
                {
                    recipe.RecipeName = item.RecipeName;
                    recipe.CountryId = item.CountryId;
                    recipe.MealId = item.MealId;
                    recipe.Description = item.Description;
                    recipe.PrepTime = item.PrepTime;
                    recipe.CookTime = item.CookTime;
                    recipe.StandTime = item.StandTime;
                    recipe.TotalTime = item.TotalTime;
                    recipe.Servings = item.Servings;
                    recipe.IsDelete = false;
                    return recipeRepository.Update(item);
                }
                else
                {
                    throw new Exception("Not Found Recipe");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
