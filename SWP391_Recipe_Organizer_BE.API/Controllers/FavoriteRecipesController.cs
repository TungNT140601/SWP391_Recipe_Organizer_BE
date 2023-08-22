using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SWP391_Recipe_Organizer_BE.API.ViewModel;
using SWP391_Recipe_Organizer_BE.Repo;
using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using SWP391_Recipe_Organizer_BE.Service.Interface;
using SWP391_Recipe_Organizer_BE.Service.Services;
using System.ComponentModel.DataAnnotations;
using System.Security.Claims;

namespace SWP391_Recipe_Organizer_BE.API.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class FavoriteRecipesController : ControllerBase
    {
        private readonly IRecipeService recipeService;
        private readonly IFavoriteRecipeService favoriteRecipeService;
        private readonly IReviewService reviewService;
        private readonly IMapper mapper;
        public FavoriteRecipesController(IRecipeService recipeService, IFavoriteRecipeService favoriteRecipeService, IMapper mapper, IReviewService reviewService)
        {
            this.recipeService = recipeService;
            this.favoriteRecipeService = favoriteRecipeService;
            this.mapper = mapper;
            this.reviewService = reviewService;
        }

        [HttpPost]
        public async Task<IActionResult> AddFavorite([Required] string id)
        {
            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (role != null)
                {
                    if (role == CommonValues.USER)
                    {
                        var userId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
                        var recipe = recipeService.Get(id);
                        if (recipe != null)
                        {
                            return favoriteRecipeService.Add(new FavoriteRecipe
                            {
                                RecipeId = id,
                                UserId = userId
                            }) ? Ok(new
                            {
                                Status = 1,
                                Message = "Success"
                            }) : Ok(new
                            {
                                Status = 0,
                                Message = "Fail"
                            });
                        }
                        else
                        {
                            return Ok(new
                            {
                                Status = 0,
                                Message = "Not Found Recipe"
                            });
                        }
                    }
                    else
                    {
                        return Ok(new
                        {
                            Status = -1,
                            Message = "Role Denied"
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
        public async Task<IActionResult> DeleteFavorite([Required] string id)
        {
            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (role != null)
                {
                    if (role == CommonValues.USER)
                    {
                        var userId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
                        var recipe = recipeService.Get(id);
                        if (recipe != null)
                        {
                            return favoriteRecipeService.Remove(new FavoriteRecipe
                            {
                                RecipeId = id,
                                UserId = userId
                            }) ? Ok(new
                            {
                                Status = 1,
                                Message = "Success"
                            }) : Ok(new
                            {
                                Status = 0,
                                Message = "Fail"
                            });
                        }
                        else
                        {
                            return Ok(new
                            {
                                Status = 0,
                                Message = "Not Found Recipe"
                            });
                        }
                    }
                    else
                    {
                        return Ok(new
                        {
                            Status = -1,
                            Message = "Role Denied"
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
        public async Task<IActionResult> GetAllFavorite()
        {

            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (role != null)
                {
                    if (role == CommonValues.USER)
                    {
                        var userId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
                        var favorLst = favoriteRecipeService.GetAll(userId);
                        var lstRecipe = new List<string>();
                        foreach (var favor in favorLst)
                        {
                            lstRecipe.Add(favor.RecipeId);
                        }
                        var result = recipeService.GetAll(lstRecipe);
                        var data = new List<RecipeVM>();
                        foreach (var item in result)
                        {
                            var recipe = mapper.Map<RecipeVM>(item);
                            recipe.MealVMs = mapper.Map<MealVM>(item.Meal);
                            recipe.UserAccountVMs = mapper.Map<UserAccountVM>(item.User);
                            recipe.TotalReview = item.Reviews.Count();
                            recipe.AveVote = reviewService.GetAveReview(recipe.RecipeId);
                            recipe.TotalFavorite = item.FavoriteRecipes.Count();
                            recipe.IsFavorite = true;
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
                            Status = -1,
                            Message = "Role Denied"
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
        [HttpPost]
        public async Task<IActionResult> SearchFavoriteRecipe([FromBody] RecipeSearch? recipeSearch)
        {
            try
            {

                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (role != null)
                {
                    if (role == CommonValues.USER)
                    {
                        var userId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
                        var favorLst = favoriteRecipeService.GetAll(userId);
                        var lstRecipe = new List<string>();
                        foreach (var favor in favorLst)
                        {
                            lstRecipe.Add(favor.RecipeId);
                        }
                        var result = recipeService.SearchFavoriteRecipe(
                            lstRecipe,
                            recipeSearch.RecipeName,
                            recipeSearch.CountryId,
                            recipeSearch.MealId,
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
                            recipe.IsFavorite = true;
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
                            Status = -1,
                            Message = "Role Denied"
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
    }
}
