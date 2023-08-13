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
        private readonly IPhotoRepository photoRepository;
        private readonly IDirectionRepository directionRepository;
        private readonly IIngredientOfRecipeRepository ingredientOfRecipeRepository;
        private readonly INutritionInRecipeRepository nutritionInRecipeRepository;
        private readonly ICountryService countryService;
        public RecipeService(IRecipeRepository recipeRepository, IPhotoRepository photoRepository, IDirectionRepository directionRepository, IIngredientOfRecipeRepository ingredientOfRecipeRepository, INutritionInRecipeRepository nutritionInRecipeRepository, ICountryService countryService)
        {
            this.recipeRepository = recipeRepository;
            this.photoRepository = photoRepository;
            this.directionRepository = directionRepository;
            this.ingredientOfRecipeRepository = ingredientOfRecipeRepository;
            this.nutritionInRecipeRepository = nutritionInRecipeRepository;
            this.countryService = countryService;
        }
        public bool Add(Recipe item, List<Photo> photos, List<Direction> directions, List<IngredientOfRecipe> lstIngredientOfRecipes, List<NutritionInRecipe> lstNutritionInRecipes)
        {
            try
            {
                item.RecipeId = GenerateId.AutoGenerateId();
                item.CreateTime = DateTime.Now;
                item.UpdateTime = DateTime.Now;
                item.IsDelete = false;
                var checkRecipe = recipeRepository.Add(item);
                var checkPhoto = true;
                foreach (var photo in photos)
                {
                    photo.PhotoId = GenerateId.AutoGenerateId();
                    photo.RecipeId = item.RecipeId;
                    photo.UserId = item.UserId;
                    photo.UploadTime = DateTime.Now;
                    photo.IsDelete = false;
                    if (!photoRepository.Add(photo))
                    {
                        checkPhoto = false;
                    }
                }
                var checkDirection = true;
                foreach (var direction in directions)
                {
                    direction.DirectionsId = GenerateId.AutoGenerateId();
                    direction.RecipeId = item.RecipeId;
                    if (!directionRepository.Add(direction))
                    {
                        checkDirection = false;
                    }
                }
                var checkIngredientOfRecipe = true;
                foreach (var ingredientOfRecipe in lstIngredientOfRecipes)
                {
                    ingredientOfRecipe.RecipeId = item.RecipeId;
                    if (!ingredientOfRecipeRepository.Add(ingredientOfRecipe))
                    {
                        checkIngredientOfRecipe = false;
                    }
                }
                var checkNutritionInRecipe = true;
                foreach (var nutritionInRecipe in lstNutritionInRecipes)
                {
                    nutritionInRecipe.RecipeId = item.RecipeId;
                    if (!nutritionInRecipeRepository.Add(nutritionInRecipe))
                    {
                        checkNutritionInRecipe = false;
                    }
                }
                if (checkRecipe && checkPhoto && checkDirection && checkIngredientOfRecipe && checkNutritionInRecipe)
                {
                    countryService.CheckCountryHasRecipe(item.CountryId);
                    return true;
                }
                else
                {
                    return false;
                }
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
                    x => x.IngredientOfRecipes,
                    x => x.NutritionInRecipes,
                    x => x.Meal,
                    x => x.User,
                });
                return recipe;
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
                var recipe = recipeRepository.GetAll(x => x.UserId == id && x.IsDelete == false, new System.Linq.Expressions.Expression<Func<Recipe, object>>[]
                {
                    x => x.Directions,
                    x => x.FavoriteRecipes,
                    x => x.Photos,
                    x => x.PlanDetails,
                    x => x.Reviews,
                    x => x.IngredientOfRecipes,
                    x => x.NutritionInRecipes,
                    x => x.Meal,
                    x => x.User,
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
                    x => x.Reviews,
                    x => x.IngredientOfRecipes,
                    x => x.NutritionInRecipes,
                    x => x.Meal,
                    x => x.User,
                });
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public IEnumerable<Recipe> SearchRecipe(string? name, string? countryId, string? mealId, string? nutritionId, int? minTime, int? maxTime, int? minServing, int? maxServing)
        {
            try
            {
                return recipeRepository.GetAll(x => x.IsDelete == false
                || (!string.IsNullOrEmpty(name) && x.RecipeName.ToLower().Trim().Contains(name.Trim().ToLower()))
                || (!string.IsNullOrEmpty(countryId) && x.CountryId.ToLower().Trim().Contains(countryId.Trim().ToLower()))
                || (!string.IsNullOrEmpty(mealId) && x.MealId.ToLower().Trim().Contains(mealId.Trim().ToLower()))
                || (!string.IsNullOrEmpty(nutritionId) && x.NutritionInRecipes.Where(nx => nx.Nutrition.NutritionId.ToLower().Trim().Contains(nutritionId.Trim().ToLower())).Any())
                || (minTime != null && maxTime != null && x.TotalTime >= minTime && x.TotalTime <= maxTime)
                || (minServing != null && maxServing != null && x.Servings >= minServing && x.TotalTime <= maxServing)
                , new System.Linq.Expressions.Expression<Func<Recipe, object>>[]
                {
                    x => x.Directions,
                    x => x.FavoriteRecipes,
                    x => x.Photos,
                    x => x.PlanDetails,
                    x => x.Reviews,
                    x => x.IngredientOfRecipes,
                    x => x.NutritionInRecipes,
                    x => x.Meal,
                    x => x.User,
                });
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
                var lst = recipeRepository.GetAll(x => x.RecipeName.ToLower().Trim().Contains(search.Trim().ToLower()) && x.IsDelete == false, new System.Linq.Expressions.Expression<Func<Recipe, object>>[]
                {
                    x => x.Directions,
                    x => x.FavoriteRecipes,
                    x => x.Photos,
                    x => x.PlanDetails,
                    x => x.Reviews,
                    x => x.IngredientOfRecipes,
                    x => x.NutritionInRecipes,
                    x => x.Meal,
                    x => x.User,
                });
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

        public bool Update(Recipe item, List<Photo> photos, List<Direction> directions, List<IngredientOfRecipe> lstIngredientOfRecipes, List<NutritionInRecipe> lstNutritionInRecipes)
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
                    var checkRecipe = recipeRepository.Update(recipe);
                    var checkPhoto = true;
                    foreach (var photo in photos)
                    {
                        if (string.IsNullOrEmpty(photo.PhotoId))
                        {
                            photo.PhotoId = GenerateId.AutoGenerateId();
                            photo.RecipeId = recipe.RecipeId;
                            photo.UserId = recipe.UserId;
                            photo.UploadTime = DateTime.Now;
                            photo.IsDelete = false;
                            if (!photoRepository.Add(photo))
                            {
                                checkPhoto = false;
                            }
                        }
                        else
                        {
                            photo.RecipeId = recipe.RecipeId;
                            photo.UserId = recipe.UserId;
                            photo.UploadTime = DateTime.Now;
                            photo.IsDelete = false;
                            if (!photoRepository.Update(photo))
                            {
                                checkPhoto = false;
                            }
                        }
                    }
                    var checkDirection = true;
                    foreach (var direction in directions)
                    {
                        directionRepository.Remove(direction.DirectionsId);
                        direction.DirectionsId = GenerateId.AutoGenerateId();
                        direction.RecipeId = recipe.RecipeId;
                        if (!directionRepository.Add(direction))
                        {
                            checkDirection = false;
                        }
                    }
                    var checkIngredientOfRecipe = true;
                    foreach (var ingredientOfRecipe in lstIngredientOfRecipes)
                    {
                        ingredientOfRecipeRepository.Remove(ingredientOfRecipe.RecipeId, ingredientOfRecipe.IngredientId);
                        ingredientOfRecipe.RecipeId = recipe.RecipeId;
                        if (!ingredientOfRecipeRepository.Add(ingredientOfRecipe))
                        {
                            checkIngredientOfRecipe = false;
                        }
                    }
                    var checkNutritionInRecipe = true;
                    foreach (var nutritionInRecipe in lstNutritionInRecipes)
                    {
                        nutritionInRecipeRepository.Remove(nutritionInRecipe.NutritionId, nutritionInRecipe.RecipeId);
                        nutritionInRecipe.RecipeId = item.RecipeId;
                        if (!nutritionInRecipeRepository.Add(nutritionInRecipe))
                        {
                            checkNutritionInRecipe = false;
                        }
                    }
                    if (checkRecipe && checkPhoto && checkDirection && checkIngredientOfRecipe && checkNutritionInRecipe)
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
