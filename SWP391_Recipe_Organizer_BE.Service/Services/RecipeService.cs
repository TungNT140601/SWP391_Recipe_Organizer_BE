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
        public RecipeService(IRecipeRepository recipeRepository, IPhotoRepository photoRepository, IDirectionRepository directionRepository, IIngredientOfRecipeRepository ingredientOfRecipeRepository, INutritionInRecipeRepository nutritionInRecipeRepository)
        {
            this.recipeRepository = recipeRepository;
            this.photoRepository = photoRepository;
            this.directionRepository = directionRepository;
            this.ingredientOfRecipeRepository = ingredientOfRecipeRepository;
            this.nutritionInRecipeRepository = nutritionInRecipeRepository;
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
                return checkRecipe && checkPhoto && checkDirection && checkIngredientOfRecipe && checkNutritionInRecipe;
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
                    return checkRecipe && checkPhoto && checkDirection && checkIngredientOfRecipe && checkNutritionInRecipe;
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
