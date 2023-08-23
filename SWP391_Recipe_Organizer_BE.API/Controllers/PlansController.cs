using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient.Server;
using SWP391_Recipe_Organizer_BE.API.ViewModel;
using SWP391_Recipe_Organizer_BE.Repo;
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
        private readonly IIngredientService ingredientService;
        private readonly IMapper mapper;

        public PlansController(IPlanService planService, IMapper mapper, IRecipeService recipeService, IIngredientService ingredientService)
        {
            this.planService = planService;
            this.mapper = mapper;
            this.recipeService = recipeService;
            this.ingredientService = ingredientService;
        }
        [HttpGet]
        public async Task<IActionResult> GetPlainDetail(string planDetailId)
        {
            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role == CommonValues.USER)
                    {
                        var userId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
                        var planDetail = planService.GetDetail(userId, planDetailId);
                        return planDetail != null ? Ok(new
                        {
                            Status = 1,
                            Message = "Success",
                            Data = mapper.Map<PlanDetailVM>(planDetail)
                        }) : Ok(new
                        {
                            Status = 0,
                            Message = "Fail",
                            Data = new { }
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
        [HttpGet()]
        public async Task<IActionResult> GetPlanWeek(string date)
        {
            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role == CommonValues.USER)
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
                                    if (item != null)
                                    {
                                        var planDate = new PlanDetailDateOfWeekVM
                                        {
                                            MealOfDate = 1,
                                            PlanDetailId = planDetail.PlanDetailId,
                                            RecipeId = item.RecipeId,
                                            RecipeName = item.RecipeName,
                                            RecipeCalo = item.Calories
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
        [HttpGet]
        public async Task<IActionResult> GetPlanDate(string date)
        {
            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role == CommonValues.USER)
                    {
                        var userId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
                        DateTime dateTime = DateTime.ParseExact(date, "MM/dd/yyyy", null);
                        var planDetails = planService.GetPlanOfDate(userId, dateTime);
                        if (planDetails != null)
                        {
                            int calories = 0;
                            int fat = 0;
                            int carbs = 0;
                            int protein = 0;
                            var ingredient = new List<IngredientOfRecipe>();
                            var breakfast = new List<PlanDetailDateVM>();
                            var lunch = new List<PlanDetailDateVM>();
                            var dinner = new List<PlanDetailDateVM>();
                            foreach (var planDetail in planDetails)
                            {
                                var recipe = planDetail.Recipe;
                                if (planDetail != null && recipe != null && recipe.IngredientOfRecipes != null)
                                {
                                    ingredient.AddRange(recipe.IngredientOfRecipes);
                                    if (planDetail.MealOfDate == 1 || planDetail.MealOfDate == 2 || planDetail.MealOfDate == 3)
                                    {
                                        calories += recipe.Calories.GetValueOrDefault();
                                        fat += recipe.Fat.GetValueOrDefault();
                                        carbs += recipe.Carbohydrate.GetValueOrDefault();
                                        protein += recipe.Protein.GetValueOrDefault();
                                        ingredient.AddRange(recipe.IngredientOfRecipes);
                                    }
                                    if (planDetail.MealOfDate == 1)
                                    {
                                        breakfast.Add(new PlanDetailDateVM
                                        {
                                            PlanDetailId = planDetail.PlanDetailId,
                                            Photos = recipe.Photos.FirstOrDefault().PhotoName,
                                            RecipeId = recipe.RecipeId,
                                            RecipeName = recipe.RecipeName,
                                            TotalIngredient = recipe.IngredientOfRecipes.Count(),
                                            TotalTime = recipe.TotalTime,
                                            Calories = recipe.Calories.GetValueOrDefault(),
                                            Fat = recipe.Fat.GetValueOrDefault(),
                                            Carbohydrate = recipe.Carbohydrate.GetValueOrDefault(),
                                            Protein = recipe.Protein.GetValueOrDefault(),
                                        });
                                    }
                                    if (planDetail.MealOfDate == 2)
                                    {
                                        lunch.Add(new PlanDetailDateVM
                                        {
                                            PlanDetailId = planDetail.PlanDetailId,
                                            Photos = recipe.Photos.FirstOrDefault().PhotoName,
                                            RecipeId = recipe.RecipeId,
                                            RecipeName = recipe.RecipeName,
                                            TotalIngredient = recipe.IngredientOfRecipes.Count(),
                                            TotalTime = recipe.TotalTime,
                                            Calories = recipe.Calories.GetValueOrDefault(),
                                            Fat = recipe.Fat.GetValueOrDefault(),
                                            Carbohydrate = recipe.Carbohydrate.GetValueOrDefault(),
                                            Protein = recipe.Protein.GetValueOrDefault(),
                                        });
                                    }
                                    if (planDetail.MealOfDate == 3)
                                    {
                                        dinner.Add(new PlanDetailDateVM
                                        {
                                            PlanDetailId = planDetail.PlanDetailId,
                                            Photos = recipe.Photos.FirstOrDefault().PhotoName,
                                            RecipeId = recipe.RecipeId,
                                            RecipeName = recipe.RecipeName,
                                            TotalIngredient = recipe.IngredientOfRecipes.Count(),
                                            TotalTime = recipe.TotalTime,
                                            Calories = recipe.Calories.GetValueOrDefault(),
                                            Fat = recipe.Fat.GetValueOrDefault(),
                                            Carbohydrate = recipe.Carbohydrate.GetValueOrDefault(),
                                            Protein = recipe.Protein.GetValueOrDefault(),
                                        });
                                    }
                                }
                            }
                            var groupedIngredients = ingredient
                                .Join(ingredientService.GetAll(),
                                i => i.IngredientId,
                                info => info.IngredientId,
                                (i, info) => new
                                {
                                    i.IngredientId,
                                    info.IngredientName,
                                    info.Measure,
                                    i.Quantity
                                })
                                .GroupBy(i => i.IngredientId)
                                .Select(group => new
                                {
                                    IngredientId = group.Key,
                                    IngredientName = group.First().IngredientName,
                                    TotalQuantity = group.Sum(i => i.Quantity ?? 0),
                                    Measure = group.First().Measure
                                });
                            return Ok(new
                            {
                                Status = 1,
                                Message = "Success",
                                Data = new
                                {
                                    Calories = calories,
                                    Fat = fat,
                                    Carbs = carbs,
                                    Protein = protein,
                                    Ingredient = groupedIngredients,
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
        [HttpGet]
        public async Task<IActionResult> DeletePlanOfDate(string date)
        {
            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role == CommonValues.USER)
                    {
                        var userId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
                        DateTime dateTime = DateTime.ParseExact(date, "MM/dd/yyyy", null);
                        return planService.DeletePlanOfDate(userId, dateTime) ? Ok(new
                        {
                            Status = 1,
                            Message = "Success",
                            Data = new { }
                        }) : Ok(new
                        {
                            Status = 0,
                            Message = "Fail",
                            Data = new { }
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
        [HttpPost]
        public async Task<IActionResult> CreatePlanDetail(PlanDetailUpdateVM planDetailVM)
        {
            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role == CommonValues.USER)
                    {
                        var userId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
                        var planDetail = mapper.Map<PlanDetail>(planDetailVM);
                        planDetail.Date = DateTime.ParseExact(planDetailVM.DateSt, "MM/dd/yyyy", null);
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
                    if (role == CommonValues.USER)
                    {
                        if (id == planDetailVM.PlanDetailId)
                        {
                            var userId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
                            var planDetail = mapper.Map<PlanDetail>(planDetailVM);
                            planDetail.Date = DateTime.ParseExact(planDetailVM.DateSt, "MM/dd/yyyy", null);
                            var planDT = planService.GetDetail(userId, planDetailVM.PlanDetailId);
                            if (planDT != null)
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
                    if (role == CommonValues.USER)
                    {
                        var userId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
                        var planDetail = planService.GetDetail(userId, id);
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
