using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SWP391_Recipe_Organizer_BE.API.ViewModel;
using SWP391_Recipe_Organizer_BE.Repo;
using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using SWP391_Recipe_Organizer_BE.Service.Interface;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Security.Claims;

namespace SWP391_Recipe_Organizer_BE.API.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class RecipesController : ControllerBase
    {
        private readonly IRecipeService recipeService;
        private readonly IReviewService reviewService;
        private readonly IFavoriteRecipeService favoriteRecipeService;
        private readonly IMapper mapper;
        public RecipesController(IRecipeService recipeService, IMapper mapper, IReviewService reviewService, IFavoriteRecipeService favoriteRecipeService)
        {
            this.recipeService = recipeService;
            this.mapper = mapper;
            this.reviewService = reviewService;
            this.favoriteRecipeService = favoriteRecipeService;
        }
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            try
            {
                var lst = recipeService.GetAll();
                var recipes = new List<RecipeVM>();
                foreach (var item in lst)
                {
                    var recipe = mapper.Map<RecipeVM>(item);
                    recipe.MealVMs = mapper.Map<MealVM>(item.Meal);
                    recipe.UserAccountVMs = mapper.Map<UserAccountVM>(item.User);
                    recipe.TotalReview = item.Reviews.Count();
                    recipe.AveVote = reviewService.GetAveReview(recipe.RecipeId);
                    recipe.TotalFavorite = item.FavoriteRecipes.Count();
                    var userId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
                    if (userId != null)
                    {
                        if (favoriteRecipeService.Get(recipe.RecipeId, userId) != null)
                        {
                            recipe.IsFavorite = true;
                        }
                        else
                        {
                            recipe.IsFavorite = false;
                        }
                    }
                    else
                    {
                        recipe.IsFavorite = false;
                    }
                    recipe.PhotoVMs = new List<PhotoVM>();
                    foreach (var photo in item.Photos)
                    {
                        recipe.PhotoVMs.Add(mapper.Map<PhotoVM>(photo));
                    }
                    recipe.DirectionVMs = new List<DirectionVM>();
                    //foreach (var direction in item.Directions)
                    //{
                    //    recipe.DirectionVMs.Add(mapper.Map<DirectionVM>(direction));
                    //}
                    recipe.ReviewVMs = new List<ReviewVM>();
                    //foreach (var review in item.Reviews)
                    //{
                    //    recipe.ReviewVMs.Add(mapper.Map<ReviewVM>(review));
                    //}
                    recipe.IngredientOfRecipeVMs = new List<IngredientOfRecipeVM>();
                    //foreach (var ingredientOfRecipe in item.IngredientOfRecipes)
                    //{
                    //    var ingredientOfRecipeVM = mapper.Map<IngredientOfRecipeVM>(ingredientOfRecipe);
                    //    var ingredient = mapper.Map<IngredientVM>(ingredientOfRecipe.Ingredient);
                    //    ingredientOfRecipeVM.IngredientVM = ingredient;
                    //    recipe.IngredientOfRecipeVMs.Add(ingredientOfRecipeVM);
                    //}
                    recipe.NutritionInRecipeVMs = new List<NutritionInRecipeVM>();
                    //foreach (var nutritionInRecipe in item.NutritionInRecipes)
                    //{
                    //    var nutritionInRecipeVM = mapper.Map<NutritionInRecipeVM>(nutritionInRecipe);
                    //    var nutritionVM = mapper.Map<NutritionVM>(nutritionInRecipe.Nutrition);
                    //    nutritionInRecipeVM.NutritionVM = nutritionVM;
                    //    recipe.NutritionInRecipeVMs.Add(nutritionInRecipeVM);
                    //}
                    recipes.Add(recipe);
                }
                return Ok(new
                {
                    Status = 1,
                    Data = recipes
                });
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpGet]
        public async Task<IActionResult> Get(string id)
        {
            try
            {
                var item = recipeService.Get(id);
                var recipe = mapper.Map<RecipeVM>(item);
                recipe.MealVMs = mapper.Map<MealVM>(item.Meal);
                recipe.UserAccountVMs = mapper.Map<UserAccountVM>(item.User);
                recipe.TotalReview = item.Reviews.Count();
                recipe.AveVote = reviewService.GetAveReview(recipe.RecipeId);
                recipe.TotalFavorite = item.FavoriteRecipes.Count();
                var userId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
                if (userId != null)
                {
                    if (favoriteRecipeService.Get(recipe.RecipeId, userId) != null)
                    {
                        recipe.IsFavorite = true;
                    }
                    else
                    {
                        recipe.IsFavorite = false;
                    }
                }
                else
                {
                    recipe.IsFavorite = false;
                }
                recipe.PhotoVMs = new List<PhotoVM>();
                foreach (var photo in item.Photos)
                {
                    recipe.PhotoVMs.Add(mapper.Map<PhotoVM>(photo));
                }
                recipe.DirectionVMs = new List<DirectionVM>();
                foreach (var direction in item.Directions)
                {
                    recipe.DirectionVMs.Add(mapper.Map<DirectionVM>(direction));
                }
                recipe.ReviewVMs = new List<ReviewVM>();
                foreach (var review in item.Reviews)
                {
                    if(review.UserId == userId)
                    {
                        recipe.UserReview = mapper.Map<ReviewVM>(review);
                    }
                    else
                    {
                        recipe.ReviewVMs.Add(mapper.Map<ReviewVM>(review));
                    }
                }
                recipe.IngredientOfRecipeVMs = new List<IngredientOfRecipeVM>();
                foreach (var ingredientOfRecipe in item.IngredientOfRecipes)
                {
                    var ingredientOfRecipeVM = mapper.Map<IngredientOfRecipeVM>(ingredientOfRecipe);
                    var ingredient = mapper.Map<IngredientVM>(ingredientOfRecipe.Ingredient);
                    ingredientOfRecipeVM.IngredientVM = ingredient;
                    recipe.IngredientOfRecipeVMs.Add(ingredientOfRecipeVM);
                }
                recipe.NutritionInRecipeVMs = new List<NutritionInRecipeVM>();
                foreach (var nutritionInRecipe in item.NutritionInRecipes)
                {
                    var nutritionInRecipeVM = mapper.Map<NutritionInRecipeVM>(nutritionInRecipe);
                    var nutritionVM = mapper.Map<NutritionVM>(nutritionInRecipe.Nutrition);
                    nutritionInRecipeVM.NutritionVM = nutritionVM;
                    recipe.NutritionInRecipeVMs.Add(nutritionInRecipeVM);
                }
                return Ok(new
                {
                    Status = 1,
                    Data = recipe
                });
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpGet]
        public async Task<IActionResult> GetByUser(string id)
        {
            try
            {
                var lst = recipeService.GetByCooker(id);
                var data = new List<RecipeVM>();
                foreach (var item in lst)
                {
                    var recipe = mapper.Map<RecipeVM>(item);
                    recipe.MealVMs = mapper.Map<MealVM>(item.Meal);
                    recipe.UserAccountVMs = mapper.Map<UserAccountVM>(item.User);
                    recipe.TotalReview = item.Reviews.Count();
                    recipe.AveVote = reviewService.GetAveReview(recipe.RecipeId);
                    recipe.TotalFavorite = item.FavoriteRecipes.Count();
                    var userId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
                    if (userId != null)
                    {
                        if (favoriteRecipeService.Get(recipe.RecipeId, userId) != null)
                        {
                            recipe.IsFavorite = true;
                        }
                        else
                        {
                            recipe.IsFavorite = false;
                        }
                    }
                    else
                    {
                        recipe.IsFavorite = false;
                    }
                    recipe.PhotoVMs = new List<PhotoVM>();
                    foreach (var photo in item.Photos)
                    {
                        recipe.PhotoVMs.Add(mapper.Map<PhotoVM>(photo));
                    }
                    recipe.DirectionVMs = new List<DirectionVM>();
                    foreach (var direction in item.Directions)
                    {
                        recipe.DirectionVMs.Add(mapper.Map<DirectionVM>(direction));
                    }
                    recipe.ReviewVMs = new List<ReviewVM>();
                    foreach (var review in item.Reviews)
                    {
                        recipe.ReviewVMs.Add(mapper.Map<ReviewVM>(review));
                    }
                    recipe.IngredientOfRecipeVMs = new List<IngredientOfRecipeVM>();
                    foreach (var ingredientOfRecipe in item.IngredientOfRecipes)
                    {
                        var ingredientOfRecipeVM = mapper.Map<IngredientOfRecipeVM>(ingredientOfRecipe);
                        var ingredient = mapper.Map<IngredientVM>(ingredientOfRecipe.Ingredient);
                        ingredientOfRecipeVM.IngredientVM = ingredient;
                        recipe.IngredientOfRecipeVMs.Add(ingredientOfRecipeVM);
                    }
                    recipe.NutritionInRecipeVMs = new List<NutritionInRecipeVM>();
                    foreach (var nutritionInRecipe in item.NutritionInRecipes)
                    {
                        var nutritionInRecipeVM = mapper.Map<NutritionInRecipeVM>(nutritionInRecipe);
                        var nutritionVM = mapper.Map<NutritionVM>(nutritionInRecipe.Nutrition);
                        nutritionInRecipeVM.NutritionVM = nutritionVM;
                        recipe.NutritionInRecipeVMs.Add(nutritionInRecipeVM);
                    }
                    data.Add(recipe);
                }
                return Ok(new
                {
                    Status = 1,
                    Data = data
                });
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpGet]
        public async Task<IActionResult> GetByCooker()
        {
            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role == CommonValues.COOKER)
                    {
                        var id = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
                        var lst = recipeService.GetByCooker(id);
                        var data = new List<RecipeVM>();
                        foreach (var item in lst)
                        {
                            var recipe = mapper.Map<RecipeVM>(item);
                            recipe.MealVMs = mapper.Map<MealVM>(item.Meal);
                            recipe.UserAccountVMs = mapper.Map<UserAccountVM>(item.User);
                            recipe.TotalReview = item.Reviews.Count();
                            recipe.AveVote = reviewService.GetAveReview(recipe.RecipeId);
                            recipe.TotalFavorite = item.FavoriteRecipes.Count();
                            recipe.PhotoVMs = new List<PhotoVM>();
                            foreach (var photo in item.Photos)
                            {
                                recipe.PhotoVMs.Add(mapper.Map<PhotoVM>(photo));
                            }
                            recipe.DirectionVMs = new List<DirectionVM>();
                            foreach (var direction in item.Directions)
                            {
                                recipe.DirectionVMs.Add(mapper.Map<DirectionVM>(direction));
                            }
                            recipe.ReviewVMs = new List<ReviewVM>();
                            foreach (var review in item.Reviews)
                            {
                                recipe.ReviewVMs.Add(mapper.Map<ReviewVM>(review));
                            }
                            recipe.IngredientOfRecipeVMs = new List<IngredientOfRecipeVM>();
                            foreach (var ingredientOfRecipe in item.IngredientOfRecipes)
                            {
                                var ingredientOfRecipeVM = mapper.Map<IngredientOfRecipeVM>(ingredientOfRecipe);
                                var ingredient = mapper.Map<IngredientVM>(ingredientOfRecipe.Ingredient);
                                ingredientOfRecipeVM.IngredientVM = ingredient;
                                recipe.IngredientOfRecipeVMs.Add(ingredientOfRecipeVM);
                            }
                            recipe.NutritionInRecipeVMs = new List<NutritionInRecipeVM>();
                            foreach (var nutritionInRecipe in item.NutritionInRecipes)
                            {
                                var nutritionInRecipeVM = mapper.Map<NutritionInRecipeVM>(nutritionInRecipe);
                                var nutritionVM = mapper.Map<NutritionVM>(nutritionInRecipe.Nutrition);
                                nutritionInRecipeVM.NutritionVM = nutritionVM;
                                recipe.NutritionInRecipeVMs.Add(nutritionInRecipeVM);
                            }
                            data.Add(recipe);
                        }
                        return Ok(new
                        {
                            Status = 1,
                            Data = data
                        });
                    }
                    return Ok(new
                    {
                        Status = 0,
                        Data = new { }
                    });
                }
                else
                {
                    return Unauthorized();
                }

            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpPost]
        public async Task<IActionResult> AddRecipe(RecipeAddUpdateVM recipeVM)
        {
            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role == CommonValues.COOKER)
                    {
                        if (string.IsNullOrEmpty(recipeVM.RecipeName))
                        {
                            return StatusCode(400, new
                            {
                                Message = "Recipe name cannot be empty!!!"
                            });
                        }
                        else
                        {
                            var userId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
                            var recipe = mapper.Map<Recipe>(recipeVM);
                            recipe.UserId = userId;
                            recipe.TotalTime = (recipe.PrepTime != null ? recipe.PrepTime : 0)
                                + (recipe.CookTime != null ? recipe.CookTime : 0)
                                + (recipe.StandTime != null ? recipe.StandTime : 0);
                            recipe.NutritionInRecipes.Clear();
                            recipe.IngredientOfRecipes.Clear();
                            recipe.Photos.Clear();
                            recipe.Directions.Clear();
                            var lstPhoto = new List<Photo>();
                            if (recipeVM.PhotoVMs.Any())
                            {
                                foreach (var photo in recipeVM.PhotoVMs)
                                {
                                    lstPhoto.Add(new Photo
                                    {
                                        PhotoName = photo.PhotoName
                                    });
                                }
                            }
                            var lstDirection = new List<Direction>();
                            if (recipeVM.DirectionVMs.Any())
                            {
                                foreach (var direction in recipeVM.DirectionVMs)
                                {
                                    lstDirection.Add(new Direction
                                    {
                                        DirectionsNum = direction.DirectionsNum,
                                        DirectionsDesc = direction.DirectionsDesc
                                    });
                                }
                            }
                            var lstIngredientOfRecipes = new List<IngredientOfRecipe>();
                            if (recipeVM.IngredientOfRecipeVMs.Any())
                            {
                                foreach (var ingredientOfRecipe in recipeVM.IngredientOfRecipeVMs)
                                {
                                    lstIngredientOfRecipes.Add(new IngredientOfRecipe
                                    {
                                        Description = ingredientOfRecipe.Description,
                                        IngredientId = ingredientOfRecipe.IngredientId
                                    });
                                }
                            }
                            var lstNutritionInRecipes = new List<NutritionInRecipe>();
                            if (recipeVM.NutritionInRecipeVMs.Any())
                            {
                                foreach (var nutritionInRecipeVM in recipeVM.NutritionInRecipeVMs)
                                {
                                    lstNutritionInRecipes.Add(new NutritionInRecipe
                                    {
                                        NutritionId = nutritionInRecipeVM.NutritionId,
                                        Quantity = nutritionInRecipeVM.Quantity
                                    });
                                }
                            }
                            var check = recipeService.Add(recipe, lstPhoto, lstDirection, lstIngredientOfRecipes, lstNutritionInRecipes);
                            return check ? Ok(new
                            {
                                Status = 1,
                                Message = "Add Recipe Success"
                            }) : Ok(new
                            {
                                Status = 0,
                                Message = "Add Recipe Fail"
                            });
                        }
                    }
                    else
                    {
                        return Ok(new
                        {
                            Status = 0,
                            Message = "Role Denied",
                            Data = new { }
                        });
                    }
                }
                else
                {
                    return Unauthorized();
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpPut]
        public async Task<IActionResult> UpdateRecipe(string id, RecipeVM recipeVM)
        {
            if (id != recipeVM.RecipeId)
            {
                return BadRequest();
            }

            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role == CommonValues.COOKER)
                    {
                        if (string.IsNullOrEmpty(recipeVM.RecipeName))
                        {
                            return StatusCode(400, new
                            {
                                Message = "Recipe name cannot be empty!!!"
                            });
                        }
                        else
                        {
                            var userId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
                            var recipe = mapper.Map<Recipe>(recipeVM);
                            recipe.TotalTime = (recipe.PrepTime != null ? recipe.PrepTime : 0)
                                + (recipe.CookTime != null ? recipe.CookTime : 0)
                                + (recipe.StandTime != null ? recipe.StandTime : 0);
                            var lstPhoto = new List<Photo>();
                            if (recipeVM.PhotoVMs.Any())
                            {
                                foreach (var photo in recipeVM.PhotoVMs)
                                {
                                    lstPhoto.Add(new Photo
                                    {
                                        PhotoName = photo.PhotoName
                                    });
                                }
                            }
                            var lstDirection = new List<Direction>();
                            if (recipeVM.DirectionVMs.Any())
                            {
                                foreach (var direction in recipeVM.DirectionVMs)
                                {
                                    lstDirection.Add(new Direction
                                    {
                                        DirectionsNum = direction.DirectionsNum,
                                        DirectionsDesc = direction.DirectionsDesc
                                    });
                                }
                            }
                            var lstIngredientOfRecipes = new List<IngredientOfRecipe>();
                            if (recipeVM.IngredientOfRecipeVMs.Any())
                            {
                                foreach (var ingredientOfRecipe in recipeVM.IngredientOfRecipeVMs)
                                {
                                    lstIngredientOfRecipes.Add(new IngredientOfRecipe
                                    {
                                        Description = ingredientOfRecipe.Description,
                                        IngredientId = ingredientOfRecipe.IngredientId
                                    });
                                }
                            }
                            var lstNutritionInRecipes = new List<NutritionInRecipe>();
                            if (recipeVM.NutritionInRecipeVMs.Any())
                            {
                                foreach (var nutritionInRecipeVM in recipeVM.NutritionInRecipeVMs)
                                {
                                    lstNutritionInRecipes.Add(new NutritionInRecipe
                                    {
                                        NutritionId = nutritionInRecipeVM.NutritionId,
                                        Quantity = nutritionInRecipeVM.Quantity
                                    });
                                }
                            }
                            var check = recipeService.Update(recipe, lstPhoto, lstDirection, lstIngredientOfRecipes, lstNutritionInRecipes);
                            return check ? Ok(new
                            {
                                Status = 1,
                                Message = "Update Recipe Success"
                            }) : Ok(new
                            {
                                Status = 0,
                                Message = "Update Recipe Fail"
                            });
                        }
                    }
                    else
                    {
                        return Ok(new
                        {
                            Status = 0,
                            Message = "Role Denied",
                            Data = new { }
                        });
                    }
                }
                else
                {
                    return Unauthorized();
                }

            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpDelete]
        public async Task<IActionResult> DeleteRecipe(string id)
        {
            if (recipeService.Get(id) == null)
            {
                return BadRequest();
            }

            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role == CommonValues.COOKER)
                    {
                        var check = recipeService.Delete(id);
                        return check ? Ok(new
                        {
                            Status = 1,
                            Message = "Delete Recipe Success"
                        }) : Ok(new
                        {
                            Status = 0,
                            Message = "Delete Recipe Fail"
                        });

                    }
                    else
                    {
                        return Ok(new
                        {
                            Status = 0,
                            Message = "Role Denied",
                            Data = new { }
                        });
                    }
                }
                else
                {
                    return Unauthorized();
                }

            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpGet]
        public async Task<IActionResult> SearchRecipe(string search, [FromBody] RecipeSearch? recipeSearch)
        {
            try
            {
                if (!string.IsNullOrEmpty(search))
                {
                    var result = recipeService.SearchRecipe(
                        search,
                        recipeSearch.CountryId,
                        recipeSearch.MealId,
                        recipeSearch.NutritionId,
                        recipeSearch.MinTotalTime,
                        recipeSearch.MaxTotalTime,
                        recipeSearch.MinServing,
                        recipeSearch.MaxServing);
                    var data = new List<RecipeVM>();
                    foreach (var item in result)
                    {
                        var recipe = mapper.Map<RecipeVM>(item);
                        recipe.MealVMs = mapper.Map<MealVM>(item.Meal);
                        recipe.UserAccountVMs = mapper.Map<UserAccountVM>(item.User);
                        recipe.TotalReview = item.Reviews.Count();
                        recipe.AveVote = reviewService.GetAveReview(recipe.RecipeId);
                        recipe.TotalFavorite = item.FavoriteRecipes.Count();
                        recipe.PhotoVMs = new List<PhotoVM>();
                        foreach (var photo in item.Photos)
                        {
                            recipe.PhotoVMs.Add(mapper.Map<PhotoVM>(photo));
                        }
                        recipe.DirectionVMs = new List<DirectionVM>();
                        foreach (var direction in item.Directions)
                        {
                            recipe.DirectionVMs.Add(mapper.Map<DirectionVM>(direction));
                        }
                        recipe.ReviewVMs = new List<ReviewVM>();
                        foreach (var review in item.Reviews)
                        {
                            recipe.ReviewVMs.Add(mapper.Map<ReviewVM>(review));
                        }
                        recipe.IngredientOfRecipeVMs = new List<IngredientOfRecipeVM>();
                        foreach (var ingredientOfRecipe in item.IngredientOfRecipes)
                        {
                            var ingredientOfRecipeVM = mapper.Map<IngredientOfRecipeVM>(ingredientOfRecipe);
                            var ingredient = mapper.Map<IngredientVM>(ingredientOfRecipe.Ingredient);
                            ingredientOfRecipeVM.IngredientVM = ingredient;
                            recipe.IngredientOfRecipeVMs.Add(ingredientOfRecipeVM);
                        }
                        recipe.NutritionInRecipeVMs = new List<NutritionInRecipeVM>();
                        foreach (var nutritionInRecipe in item.NutritionInRecipes)
                        {
                            var nutritionInRecipeVM = mapper.Map<NutritionInRecipeVM>(nutritionInRecipe);
                            var nutritionVM = mapper.Map<NutritionVM>(nutritionInRecipe.Nutrition);
                            nutritionInRecipeVM.NutritionVM = nutritionVM;
                            recipe.NutritionInRecipeVMs.Add(nutritionInRecipeVM);
                        }
                        data.Add(recipe);
                    }
                    return Ok(new
                    {
                        Status = 1,
                        Data = data
                    });
                }
                else
                {
                    return Ok(new
                    {
                        Status = 0,
                        Message = "Fail",
                        Data = new { }
                    });
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpGet]
        public async Task<IActionResult> SuggestRecipe([Required][MinLength(3)] string search)
        {
            try
            {
                if (!string.IsNullOrEmpty(search) && search.Length >= 3)
                {
                    var suggest = recipeService.GetSuggest(search);
                    return Ok(new
                    {
                        Status = 1,
                        Message = "Success",
                        Data = suggest
                    });
                }
                else
                {
                    return Ok(new
                    {
                        Status = 0,
                        Message = "Fail",
                        Data = new { }
                    });
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}
