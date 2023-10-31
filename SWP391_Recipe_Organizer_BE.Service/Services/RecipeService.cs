using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using SWP391_Recipe_Organizer_BE.Repo.Interface;
using SWP391_Recipe_Organizer_BE.Service.Interface;
using SWP391_Recipe_Organizer_BE.Ultility;
using System;
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
        private readonly IUserAccountRepository userAccountRepository;
        public RecipeService(IRecipeRepository recipeRepository,
            IPhotoRepository photoRepository,
            IDirectionRepository directionRepository,
            IIngredientOfRecipeRepository ingredientOfRecipeRepository,
            ICountryService countryService,
            IIngredientRepository ingredientRepository,
            IUserAccountRepository userAccountRepository)
        {
            this.recipeRepository = recipeRepository;
            this.photoRepository = photoRepository;
            this.directionRepository = directionRepository;
            this.ingredientOfRecipeRepository = ingredientOfRecipeRepository;
            this.countryService = countryService;
            this.ingredientRepository = ingredientRepository;
            this.userAccountRepository = userAccountRepository;
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
                if (item.CountryId == "")
                {
                    item.CountryId = null;
                }
                if (item.MealId == "")
                {
                    item.MealId = null;
                }
                item.Directions.Clear();
                item.Photos.Clear();
                item.IngredientOfRecipes.Clear();
                var checkRecipe = recipeRepository.Add(item);
                var checkPhoto = await AddPhotos(photos, item.UserId, item.RecipeId);
                var checkDirection = await AddDirections(directions, item.RecipeId);
                var checkIngredientOfRecipe = await AddIngredients(lstIngredientOfRecipes, item.RecipeId);
                if (checkRecipe && checkPhoto && checkDirection && checkIngredientOfRecipe)
                {
                    if (item.CountryId != null)
                    {
                        countryService.CheckCountryHasRecipe(item.CountryId);
                    }
                }
                else
                {
                    await Fail(id, item.UserId, null, null, null);
                    await recipeRepository.RemoveAddFail(id);
                }
                return checkRecipe && checkPhoto && checkDirection && checkIngredientOfRecipe;
            }
            catch (Exception ex)
            {
                await Fail(id, item.UserId, null, null, null);
                throw new Exception(ex.Message);
            }
        }
        public Recipe Get(string id)
        {
            try
            {
                var recipes = recipeRepository.Get(x => x.RecipeId == id, new System.Linq.Expressions.Expression<Func<Recipe, object>>[]
                {
                    x => x.Directions,
                    x => x.FavoriteRecipes,
                    x => x.IngredientOfRecipes,
                    x => x.PlanDetails,
                    x => x.Reviews,
                    x => x.Photos,
                    x => x.Meal,
                    x => x.User,
                    x => x.Country
                });
                if (recipes != null)
                {
                    recipes.Protein = 0;
                    recipes.Carbohydrate = 0;
                    recipes.Fat = 0;
                    recipes.Calories = 0;
                    foreach (var ingre in recipes.IngredientOfRecipes)
                    {
                        ingre.Ingredient = ingredientRepository.Get(x => x.IngredientId == ingre.IngredientId);
                        recipes.Protein += (int)Math.Round((decimal)(ingre.Ingredient.Protein * (int)Math.Round(ingre.Quantity.Value, 0)), 0);
                        recipes.Carbohydrate += (int)Math.Round((decimal)(ingre.Ingredient.Carbohydrate * (int)Math.Round(ingre.Quantity.Value, 0)), 0);
                        recipes.Fat += (int)Math.Round((decimal)(ingre.Ingredient.Fat * (int)Math.Round(ingre.Quantity.Value, 0)), 0);
                        recipes.Calories += (int)Math.Round((decimal)(ingre.Ingredient.Calories * (int)Math.Round(ingre.Quantity.Value, 0)), 0);
                    }
                }

                return recipes;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public Recipe GetUpdate(string id)
        {
            try
            {
                var recipes = recipeRepository.Get(x => x.RecipeId == id, new System.Linq.Expressions.Expression<Func<Recipe, object>>[]
                {
                    x => x.Directions,
                    x => x.IngredientOfRecipes,
                    x => x.Photos,
                    x => x.Meal,
                    x => x.Country
                });
                if (recipes != null)
                {
                    foreach (var ingre in recipes.IngredientOfRecipes)
                    {
                        ingre.Ingredient = ingredientRepository.Get(x => x.IngredientId == ingre.IngredientId);
                    }
                }
                return recipes;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public Recipe GetInPlanWeek(string id)
        {
            try
            {
                //var recipes = recipeRepository.Get(x => x.RecipeId == id, new System.Linq.Expressions.Expression<Func<Recipe, object>>[]
                //{
                //    x => x.IngredientOfRecipes
                //});
                var recipes = recipeRepository.Get(id).Result;
                if (recipes != null)
                {
                    recipes.Protein = 0;
                    recipes.Carbohydrate = 0;
                    recipes.Fat = 0;
                    recipes.Calories = 0;
                    recipes.IngredientOfRecipes = ingredientOfRecipeRepository.GetIngredientOfRecipe(recipes.RecipeId).Result.ToList();
                    recipes.Photos = photoRepository.Get(recipes.RecipeId).Result.ToList();
                    foreach (var ingre in recipes.IngredientOfRecipes)
                    {
                        ingre.Ingredient = ingredientRepository.Get(ingre.IngredientId).Result;
                        recipes.Protein += (int)Math.Round((decimal)(ingre.Ingredient.Protein * (int)Math.Round(ingre.Quantity.Value, 0)), 0);
                        recipes.Carbohydrate += (int)Math.Round((decimal)(ingre.Ingredient.Carbohydrate * (int)Math.Round(ingre.Quantity.Value, 0)), 0);
                        recipes.Fat += (int)Math.Round((decimal)(ingre.Ingredient.Fat * (int)Math.Round(ingre.Quantity.Value, 0)), 0);
                        recipes.Calories += (int)Math.Round((decimal)(ingre.Ingredient.Calories * (int)Math.Round(ingre.Quantity.Value, 0)), 0);
                    }
                }

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
                    x => x.FavoriteRecipes,
                    x => x.Photos,
                    x => x.Reviews,
                    //x => x.Meal,
                    //x => x.User,
                    x => x.Country
                });
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
                    x => x.FavoriteRecipes,
                    x => x.Photos,
                    x => x.Reviews,
                    x => x.Meal,
                    //x => x.User,
                    x => x.Country
                });
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
                var recipes = recipeRepository.GetAll(x => recipeIds.Contains(x.RecipeId), new System.Linq.Expressions.Expression<Func<Recipe, object>>[]
                {
                    x => x.FavoriteRecipes,
                    x => x.Photos,
                    x => x.Reviews,
                    //x => x.Meal,
                    //x => x.User,
                    x => x.Country
                });
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
                    x.IsDelete == false
                    && (string.IsNullOrEmpty(name) || x.RecipeName.ToLower().Trim().Contains(name.Trim().ToLower()))
                    && (string.IsNullOrEmpty(countryId) || (x.CountryId != null && x.CountryId.Trim().Equals(countryId.Trim())))
                    && (string.IsNullOrEmpty(mealId) || (x.MealId != null && x.MealId.Trim().Equals(mealId.Trim())))
                    && ((!minTime.HasValue || !maxTime.HasValue) || (x.TotalTime >= minTime.Value && x.TotalTime <= maxTime.Value))
                    && ((!minServing.HasValue || !maxServing.HasValue) || (x.Servings >= minServing.Value && x.Servings <= maxServing.Value))
                    , new Expression<Func<Recipe, object>>[]
                    {
                        x => x.FavoriteRecipes,
                        x => x.Photos,
                        x => x.Reviews,
                        //x => x.Meal,
                        //x => x.User,
                        x => x.Country
                    }
                );

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

                var recipes = recipeRepository.GetAll(x =>
                    recipeIds.Contains(x.RecipeId)
                    && (string.IsNullOrEmpty(name) || x.RecipeName.ToLower().Trim().Contains(name.Trim().ToLower()))
                    && (string.IsNullOrEmpty(countryId) || (x.CountryId != null && x.CountryId.Trim().Equals(countryId.Trim())))
                    && (string.IsNullOrEmpty(mealId) || (x.MealId != null && x.MealId.Trim().Equals(mealId.Trim())))
                    && ((!minTime.HasValue || !maxTime.HasValue) || (x.TotalTime >= minTime.Value && x.TotalTime <= maxTime.Value))
                    && ((!minServing.HasValue || !maxServing.HasValue) || (x.Servings >= minServing.Value && x.Servings <= maxServing.Value))
                    , new Expression<Func<Recipe, object>>[]
                    {
                        x => x.FavoriteRecipes,
                        x => x.Photos,
                        x => x.Reviews,
                        //x => x.Meal,
                        //x => x.User,
                        x => x.Country
                    });
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
                        if (recipe.CountryId != null)
                        {
                            countryService.CheckCountryHasRecipe(recipe.CountryId);
                        }
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
        public async Task<bool> Update(Recipe item, List<Photo> photos, List<Direction> directions, List<IngredientOfRecipe> lstIngredientOfRecipes)
        {
            var recipe = recipeRepository.Get(x => x.RecipeId == item.RecipeId && x.IsDelete == false, new Expression<Func<Recipe, object>>[]
            {
                x => x.IngredientOfRecipes,
                x => x.Photos,
                x => x.Directions,
            });
            var bkIngre = new List<IngredientOfRecipe>();
            var bkPhoto = new List<Photo>();
            var bkDirect = new List<Direction>();
            if (recipe != null)
            {
                bkDirect = recipe.Directions.ToList();
                bkPhoto = recipe.Photos.ToList();
                bkIngre = recipe.IngredientOfRecipes.ToList();
            }
            try
            {
                if (recipe != null)
                {
                    recipe.RecipeName = item.RecipeName;
                    if (string.IsNullOrEmpty(item.CountryId))
                    {
                        recipe.CountryId = null;
                    }
                    else
                    {
                        recipe.CountryId = item.CountryId;
                    }
                    if (string.IsNullOrEmpty(item.MealId))
                    {
                        recipe.MealId = null;
                    }
                    else
                    {
                        recipe.MealId = item.MealId;
                    }
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
                    ingredientOfRecipeRepository.RemoveAll(recipe.RecipeId);
                    directionRepository.RemoveAll(recipe.RecipeId);
                    var checkPhoto = await AddPhotos(photos, recipe.UserId, recipe.RecipeId);
                    var checkDirection = await AddDirections(directions, recipe.RecipeId);
                    var ingredients = ingredientRepository.GetAll(x => 1 == 1);
                    foreach (var ingredientOfRecipe in lstIngredientOfRecipes)
                    {
                        var ingredient = new Ingredient();
                        foreach (var iOr in bkIngre)
                        {
                            var ingre = ingredientRepository.Get(x => x.IngredientId == iOr.IngredientId);
                            if (ingre.IngredientName == ingredientOfRecipe.Ingredient.IngredientName)
                            {
                                ingredient = ingre;
                            }
                        }
                        if (ingredient.IngredientId != null)
                        {
                            ingredientOfRecipe.IngredientId = ingredient.IngredientId;
                        }
                        else
                        {
                            var ingre = ingredientRepository.Get(x => x.IngredientName == ingredientOfRecipe.Ingredient.IngredientName && x.IsDelete == false);
                            ingredientOfRecipe.IngredientId = ingre.IngredientId;
                        }
                    }
                    var checkIngredientOfRecipe = await AddIngredients(lstIngredientOfRecipes, recipe.RecipeId);
                    if (checkRecipe && checkPhoto && checkDirection && checkIngredientOfRecipe)
                    {
                        if (recipe.CountryId != null)
                        {
                            countryService.CheckCountryHasRecipe(recipe.CountryId);
                        }
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
                await Fail(recipe.RecipeId, recipe.UserId, bkIngre, bkPhoto, bkDirect);
                throw new Exception(ex.Message);
            }
        }
        private async Task<bool> AddPhotos(List<Photo> photos, string userId, string recipeId)
        {
            try
            {
                if (await photoRepository.AddRangePhoto(photos, userId, recipeId) == false)
                {
                    throw new Exception();
                }
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        private async Task<bool> AddDirections(List<Direction> directions, string recipeId)
        {
            try
            {
                if (await directionRepository.AddRange(directions, recipeId) == false)
                {
                    throw new Exception();
                }
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        private async Task<bool> AddIngredients(List<IngredientOfRecipe> ingredientOfRecipes, string recipeId)
        {
            try
            {
                if (await ingredientOfRecipeRepository.AddRange(ingredientOfRecipes, recipeId) == false)
                {
                    throw new Exception();
                }
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        private async Task Fail(string recipeId, string userId, List<IngredientOfRecipe> bkIngre, List<Photo> bkPhoto, List<Direction> bkDirect)
        {
            ingredientOfRecipeRepository.RemoveAll(recipeId);
            directionRepository.RemoveAll(recipeId);
            photoRepository.RemoveAll(recipeId);
            if (bkPhoto != null && bkPhoto.Count() > 0)
            {
                await photoRepository.AddRangePhoto(bkPhoto, userId, recipeId);
            }
            if (bkDirect != null && bkDirect.Count() > 0)
            {
                await directionRepository.AddRange(bkDirect, recipeId);
            }
            if (bkIngre != null && bkIngre.Count() > 0)
            {
                await ingredientOfRecipeRepository.AddRange(bkIngre, recipeId);
            }
            recipeRepository.Remove(recipeId);
        }
    }
}
