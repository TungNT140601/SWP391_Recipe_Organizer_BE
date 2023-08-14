using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient.Server;
using SWP391_Recipe_Organizer_BE.API.ViewModel;
using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using SWP391_Recipe_Organizer_BE.Service.Interface;
using SWP391_Recipe_Organizer_BE.Service.Services;
using System;
using System.Numerics;
using System.Reflection;
using System.Security.Claims;

namespace SWP391_Recipe_Organizer_BE.API.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class PlansController : ControllerBase
    {
        private readonly IPlanService planService;
        private readonly IRecipeService recipeService;
        private readonly IMapper mapper;

        public PlansController(IPlanService planService, IMapper mapper, IRecipeService recipeService)
        {
            this.planService = planService;
            this.mapper = mapper;
            this.recipeService = recipeService;

        }

        [HttpGet()]
        public async Task<IActionResult> GetPlanWeek(string date)
        {
            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role == "Guest")
                    {
                        var userId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
                        DateTime dateTime = DateTime.ParseExact(date, "MM/dd/yyyy", null);
                        var planDetails = planService.GetPlanOfWeek(userId, dateTime);
                        if (planDetails != null)
                        {
                            var food = new List<PlanDetailWeekVM>();

                            for (DateTime currentDate = dateTime; currentDate <= dateTime.AddDays(6); currentDate = currentDate.AddDays(1))
                            {
                                var breakfast = new List<PlanDetailDateOfWeekVM>();
                                var lunch = new List<PlanDetailDateOfWeekVM>();
                                var dinner = new List<PlanDetailDateOfWeekVM>();
                                var recipeOfDate = planDetails.Where(x => x.Date.Value.Date == currentDate.Date).ToList();
                                foreach (var planDetail in recipeOfDate)
                                {
                                    var item = recipeService.Get(planDetail.RecipeId);
                                    var planDate = new PlanDetailDateOfWeekVM
                                    {
                                        MealOfDate = 1,
                                        PlanDetailId = planDetail.PlanDetailId,
                                        RecipeId = item.RecipeId,
                                        RecipeName = item.RecipeName,
                                        RecipeCalo = item.NutritionInRecipes != null ? item.NutritionInRecipes.Where(x => x.NutritionId == "NUT001").First().Quantity : 0
                                    };
                                    if (planDetail.MealOfDate == 1)
                                    {
                                        breakfast.Add(planDate);
                                    }
                                    if (planDetail.MealOfDate == 2)
                                    {
                                        lunch.Add(planDate);
                                    }
                                    if (planDetail.MealOfDate == 3)
                                    {
                                        dinner.Add(planDate);
                                    }
                                }
                                food.Add(new PlanDetailWeekVM
                                {
                                    Breakfast = breakfast,
                                    Lunch = lunch,
                                    Dinner = dinner
                                });
                            }
                            return Ok(new
                            {
                                Status = 1,
                                Message = "Success",
                                Data = new
                                {
                                    Food = food
                                }
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
                    else
                    {
                        return Ok(new
                        {
                            Status = -1,
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
        [HttpGet()]
        public async Task<IActionResult> GetPlanDate(string date)
        {
            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role == "Guest")
                    {
                        var userId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
                        DateTime dateTime = DateTime.ParseExact(date, "MM/dd/yyyy", null);
                        var planDetails = planService.GetPlanOfDate(userId, dateTime);
                        if (planDetails != null)
                        {
                            var breakfast = new List<PlanDetailDateVM>();
                            var lunch = new List<PlanDetailDateVM>();
                            var dinner = new List<PlanDetailDateVM>();
                            foreach (var planDetail in planDetails)
                            {
                                #region Recipe
                                var item = recipeService.Get(planDetail.RecipeId);
                                var recipe = mapper.Map<RecipeVM>(item);
                                recipe.MealVMs = mapper.Map<MealVM>(item.Meal);
                                recipe.UserAccountVMs = null;
                                recipe.TotalReview = 0;
                                recipe.AveVote = 0;
                                recipe.TotalFavorite = 0;
                                recipe.PhotoVMs = new List<PhotoVM>();
                                foreach (var photo in item.Photos)
                                {
                                    recipe.PhotoVMs.Add(mapper.Map<PhotoVM>(photo));
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
                                #endregion

                                if (planDetail.MealOfDate == 1)
                                {
                                    breakfast.Add(new PlanDetailDateVM
                                    {
                                        PlanDetailId = planDetail.PlanDetailId,
                                        MealOfDate = planDetail.MealOfDate,
                                        Food = recipe
                                    });
                                }
                                if (planDetail.MealOfDate == 2)
                                {
                                    lunch.Add(new PlanDetailDateVM
                                    {
                                        PlanDetailId = planDetail.PlanDetailId,
                                        MealOfDate = planDetail.MealOfDate,
                                        Food = recipe
                                    });
                                }
                                if (planDetail.MealOfDate == 3)
                                {
                                    dinner.Add(new PlanDetailDateVM
                                    {
                                        PlanDetailId = planDetail.PlanDetailId,
                                        MealOfDate = planDetail.MealOfDate,
                                        Food = recipe
                                    });
                                }
                            }
                            return Ok(new
                            {
                                Status = 1,
                                Message = "Success",
                                Data = new
                                {
                                    Food = new
                                    {
                                        Breakfast = breakfast,
                                        Lunch = lunch,
                                        Dinner = dinner
                                    }
                                }
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
                    else
                    {
                        return Ok(new
                        {
                            Status = -1,
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
        [HttpPost]
        public async Task<IActionResult> CreatePlanDetail(PlanDetailUpdateVM planDetailVM)
        {
            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role == "Guest")
                    {
                        var userId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
                        var planDetail = mapper.Map<PlanDetail>(planDetailVM);
                        return planService.AddPlanDetail(planDetail, userId) ? Ok(new
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
                            Status = -1,
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
        public async Task<IActionResult> UpdatePlanDetail(string id, PlanDetailUpdateVM planDetailVM)
        {
            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role == "Guest")
                    {
                        if (id == planDetailVM.PlanDetailId)
                        {
                            var userId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
                            var planDetail = mapper.Map<PlanDetail>(planDetailVM);
                            var planDT = planService.GetDetail(planDetailVM.PlanDetailId);
                            if (planDetail.PlanId == planDT.PlanId && planDetail.PlanDetailId == planDT.PlanDetailId)
                            {
                                return planService.UpdatePlanDetail(planDetail) ? Ok(new
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
                                    Message = "Not Found"
                                });
                            }
                        }
                        else
                        {
                            return Ok(new
                            {
                                Status = 0,
                                Message = "Not Found"
                            });
                        }
                    }
                    else
                    {
                        return Ok(new
                        {
                            Status = -1,
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
        public async Task<IActionResult> DeletePlanDetail(string id)
        {
            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role == "Guest")
                    {
                        var userId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
                        var planDetail = planService.GetDetail(id);
                        if (planDetail != null && planDetail.Plan.UserId == userId)
                        {
                            return planService.DeletePlanDetail(id) ? Ok(new
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
                                Message = "Not Found PlanDetail"
                            });
                        }
                    }
                    else
                    {
                        return Ok(new
                        {
                            Status = -1,
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
    }
}
