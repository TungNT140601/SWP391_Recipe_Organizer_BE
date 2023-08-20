using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using SWP391_Recipe_Organizer_BE.Repo.Interface;
using SWP391_Recipe_Organizer_BE.Service.Interface;
using SWP391_Recipe_Organizer_BE.Ultility;
using System.ComponentModel;
using System.Linq.Expressions;

namespace SWP391_Recipe_Organizer_BE.Service.Services
{
    public class RecipeService : IRecipeService
    {
        private readonly IRecipeRepository recipeRepository;
        private readonly IPhotoRepository photoRepository;
        private readonly IDirectionRepository directionRepository;
        private readonly IIngredientOfRecipeRepository ingredientOfRecipeRepository;
        private readonly IIngredientRepository ingredientRepository;
        private readonly ICountryService countryService;
        public RecipeService(IRecipeRepository recipeRepository,
            IPhotoRepository photoRepository,
            IDirectionRepository directionRepository,
            IIngredientOfRecipeRepository ingredientOfRecipeRepository,
            ICountryService countryService,
            IIngredientRepository ingredientRepository)
        {
            this.recipeRepository = recipeRepository;
            this.photoRepository = photoRepository;
            this.directionRepository = directionRepository;
            this.ingredientOfRecipeRepository = ingredientOfRecipeRepository;
            this.countryService = countryService;
            this.ingredientRepository = ingredientRepository;
        }
        public async Task<bool> AddAsync(Recipe item, List<Photo> photos, List<Direction> directions, List<IngredientOfRecipe> lstIngredientOfRecipes)
        {
            var id = "";
            try
            {
                item.RecipeId = GenerateId.AutoGenerateId();
                id = item.RecipeId;
                item.CreateTime = DateTime.Now;
                item.UpdateTime = DateTime.Now;
                item.IsDelete = false;
                var checkRecipe = recipeRepository.Add(item);
                var checkPhoto = photoRepository.AddRangePhoto(photos, item.UserId, item.RecipeId);
                var checkDirection = directionRepository.AddRange(directions, item.RecipeId);
                var checkIngredientOfRecipe = ingredientOfRecipeRepository.AddRange(lstIngredientOfRecipes, item.RecipeId);
                if (checkRecipe && checkPhoto && checkDirection && checkIngredientOfRecipe)
                {
                    countryService.CheckCountryHasRecipe(item.CountryId);
                }
                else
                {
                    directionRepository.RemoveAll(id);
                    ingredientOfRecipeRepository.RemoveAll(id);
                    photoRepository.RemoveAll(id);
                    await recipeRepository.RemoveAddFail(id);
                }
                return checkRecipe && checkPhoto && checkDirection && checkIngredientOfRecipe;
            }
            catch (Exception ex)
            {
                directionRepository.RemoveAll(id);
                ingredientOfRecipeRepository.RemoveAll(id);
                photoRepository.RemoveAll(id);
                await recipeRepository.RemoveAddFail(id);
                throw new Exception(ex.Message);
            }
        }

        public Recipe Get(string id)
        {
            try
            {
                var recipes = recipeRepository.Get(x => x.RecipeId == id && x.IsDelete == false, new System.Linq.Expressions.Expression<Func<Recipe, object>>[]
                {
                    x => x.Directions,
                    x => x.FavoriteRecipes,
                    x => x.PlanDetails,
                    x => x.Reviews,
                    x => x.Photos,
                    x => x.Meal,
                    x => x.User,
                    x => x.Country
                });
                recipes.IngredientOfRecipes = ingredientOfRecipeRepository.GetAll(x => x.RecipeId == recipes.RecipeId, new System.Linq.Expressions.Expression<Func<IngredientOfRecipe, object>>[]
                {
                    x => x.Ingredient
                }).ToList();
                return recipes;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public IEnumerable<Recipe> GetByCooker(string id)
        {
            try
            {
                var recipes = recipeRepository.GetAll(x => x.UserId == id && x.IsDelete == false, new System.Linq.Expressions.Expression<Func<Recipe, object>>[]
                {
                    x => x.Directions,
                    x => x.FavoriteRecipes,
                    x => x.PlanDetails,
                    x => x.Reviews,
                    x => x.Photos,
                    x => x.Meal,
                    x => x.User,
                    x => x.Country
                });
                foreach (var recipe in recipes)
                {
                    recipe.IngredientOfRecipes = ingredientOfRecipeRepository.GetAll(x => x.RecipeId == recipe.RecipeId, new System.Linq.Expressions.Expression<Func<IngredientOfRecipe, object>>[]
                    {
                    x => x.Ingredient
                    }).ToList();
                }
                return recipes.OrderByDescending(x => x.CreateTime);
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
                var recipes = recipeRepository.GetAll(x => x.IsDelete == false, new System.Linq.Expressions.Expression<Func<Recipe, object>>[]
                {
                    x => x.Directions,
                    x => x.FavoriteRecipes,
                    x => x.PlanDetails,
                    x => x.Reviews,
                    x => x.Photos,
                    x => x.Meal,
                    x => x.User,
                    x => x.Country
                });

                foreach (var recipe in recipes)
                {
                    recipe.IngredientOfRecipes = ingredientOfRecipeRepository.GetAll(x => x.RecipeId == recipe.RecipeId, new System.Linq.Expressions.Expression<Func<IngredientOfRecipe, object>>[]
                    {
                    x => x.Ingredient
                    }).ToList();
                }
                return recipes.OrderByDescending(x => x.CreateTime);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public IEnumerable<Recipe> GetAll(List<string> recipeIds)
        {
            try
            {
                var recipes = recipeRepository.GetAll(x => x.IsDelete == false && recipeIds.Contains(x.RecipeId), new System.Linq.Expressions.Expression<Func<Recipe, object>>[]
                {
                    x => x.Directions,
                    x => x.FavoriteRecipes,
                    x => x.Photos,
                    x => x.PlanDetails,
                    x => x.Reviews,
                    x => x.Meal,
                    x => x.User,
                    x => x.Country
                });

                foreach (var recipe in recipes)
                {
                    recipe.IngredientOfRecipes = ingredientOfRecipeRepository.GetAll(x => x.RecipeId == recipe.RecipeId, new System.Linq.Expressions.Expression<Func<IngredientOfRecipe, object>>[]
                    {
                    x => x.Ingredient
                    }).ToList();
                }
                return recipes.OrderByDescending(x => x.CreateTime);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public IEnumerable<Recipe> SearchRecipe(string? name, string? countryId, string? mealId, int? minTime, int? maxTime, int? minServing, int? maxServing)
        {
            try
            {
                var recipes = recipeRepository.GetAll(x =>
                    x.IsDelete == false &&
                    (string.IsNullOrEmpty(name) || x.RecipeName.ToLower().Trim().Contains(name.Trim().ToLower())) &&
                    (string.IsNullOrEmpty(countryId) || x.CountryId.Trim().Equals(countryId.Trim())) &&
                    (string.IsNullOrEmpty(mealId) || x.MealId.Trim().Equals(mealId.Trim())) &&
                    (!minTime.HasValue || !maxTime.HasValue || (x.TotalTime >= minTime && x.TotalTime <= maxTime)) &&
                    (!minServing.HasValue || !maxServing.HasValue || (x.Servings >= minServing && x.Servings <= maxServing)),
                    new Expression<Func<Recipe, object>>[]
                    {
                        x => x.Directions,
                        x => x.FavoriteRecipes,
                        x => x.Photos,
                        x => x.PlanDetails,
                        x => x.Reviews,
                        x => x.Meal,
                        x => x.User,
                        x => x.Country
                    }
                );

                foreach (var recipe in recipes)
                {
                    recipe.IngredientOfRecipes = ingredientOfRecipeRepository.GetAll(x => x.RecipeId == recipe.RecipeId, new Expression<Func<IngredientOfRecipe, object>>[]
                    {
                        x => x.Ingredient
                    }).ToList();
                }

                return recipes;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public IEnumerable<Recipe> SearchFavoriteRecipe(List<string> recipeIds, string? name, string? countryId, string? mealId, int? minTime, int? maxTime, int? minServing, int? maxServing)
        {
            try
            {

                var recipes = recipeRepository.GetAll(x => x.IsDelete == false && recipeIds.Contains(x.RecipeId)
                && ((!string.IsNullOrEmpty(name) && x.RecipeName.ToLower().Trim().Contains(name.Trim().ToLower()))
                || (!string.IsNullOrEmpty(countryId) && x.CountryId.ToLower().Trim().Contains(countryId.Trim().ToLower()))
                || (!string.IsNullOrEmpty(mealId) && x.MealId.ToLower().Trim().Contains(mealId.Trim().ToLower()))
                || (minTime != null && maxTime != null && x.TotalTime >= minTime && x.TotalTime <= maxTime)
                || (minServing != null && maxServing != null && x.Servings >= minServing && x.TotalTime <= maxServing))
                , new System.Linq.Expressions.Expression<Func<Recipe, object>>[]
                {
                    x => x.Directions,
                    x => x.FavoriteRecipes,
                    x => x.Photos,
                    x => x.PlanDetails,
                    x => x.Reviews,
                    x => x.Meal,
                    x => x.User,
                    x => x.Country
                });
                foreach (var recipe in recipes)
                {
                    recipe.IngredientOfRecipes = ingredientOfRecipeRepository.GetAll(x => x.RecipeId == recipe.RecipeId, new System.Linq.Expressions.Expression<Func<IngredientOfRecipe, object>>[]
                    {
                    x => x.Ingredient
                    }).ToList();
                }
                return recipes.OrderByDescending(x => x.CreateTime);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public IEnumerable<string> GetSuggest(string search)
        {
            try
            {
                var lst = recipeRepository.GetAll(x => x.RecipeName.ToLower().Trim().Contains(search.Trim().ToLower()) && x.IsDelete == false);
                var strings = new List<string>();
                foreach (var item in lst)
                {
                    strings.Add(item.RecipeName);
                }
                return strings;
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
                    if (recipeRepository.Update(recipe))
                    {
                        countryService.CheckCountryHasRecipe(recipe.CountryId);
                        return true;
                    }
                    else
                    {
                        return false;
                    }
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

        public bool Update(Recipe item, List<Photo> photos, List<Direction> directions, List<IngredientOfRecipe> lstIngredientOfRecipes)
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
                    recipe.Carbohydrate = item.Carbohydrate;
                    recipe.Protein = item.Protein;
                    recipe.Fat = item.Fat;
                    recipe.Calories = item.Calories;
                    recipe.IsDelete = false;
                    var checkRecipe = recipeRepository.Update(recipe);
                    photoRepository.RemoveAll(recipe.RecipeId);
                    var checkPhoto = photoRepository.AddRangePhoto(photos, recipe.UserId, recipe.RecipeId);
                    directionRepository.RemoveAll(recipe.RecipeId);
                    var checkDirection = directionRepository.AddRange(directions, recipe.RecipeId);
                    ingredientOfRecipeRepository.RemoveAll(recipe.RecipeId);
                    var checkIngredientOfRecipe = ingredientOfRecipeRepository.AddRange(lstIngredientOfRecipes, recipe.RecipeId);
                    if (checkRecipe && checkPhoto && checkDirection && checkIngredientOfRecipe)
                    {
                        countryService.CheckCountryHasRecipe(recipe.CountryId);
                        return true;
                    }
                    else
                    {
                        return false;
                    }
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
