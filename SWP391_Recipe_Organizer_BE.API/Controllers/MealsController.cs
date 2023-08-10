using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using SWP391_Recipe_Organizer_BE.API.ViewModel;
using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using SWP391_Recipe_Organizer_BE.Service.Interface;
using System.Security.Claims;

namespace SWP391_Recipe_Organizer_BE.API.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class MealsController : ControllerBase
    {
        private readonly IMealService mealService;
        private readonly IMapper mapper;
        public MealsController(IMealService mealService,IMapper mapper)
        {
            this.mealService = mealService;
            this.mapper = mapper;
        }
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            try
            {
                return Ok(new
                {
                    Status = 1,
                    Data = mealService.GetAll()
                });
            }catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpGet("{id}")]
        public async Task<IActionResult> Get(string id)
        {
            try
            {
                return Ok(new
                {
                    Status = 1,
                    Data = mealService.Get(id)
                });
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpPost]
        public async Task<IActionResult> AddMeal(MealVM mealVM)
        {
            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role == "Admin")
                    {
                        if (string.IsNullOrEmpty(mealVM.MealName))
                        {
                            return StatusCode(400, new
                            {
                                Message = "Meal name cannot be empty!!!"
                            });
                        }
                        else
                        {
                            var meal = mapper.Map<Meal>(mealVM);
                            var check = mealService.Add(meal);
                            return check ? Ok(new
                            {
                                Status = 1,
                                Message = "Add Meal Success"
                            }) : Ok(new
                            {
                                Status = 0,
                                Message = "Add Meal Fail"
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
        public async Task<IActionResult> UpdateMeal(string id, MealVM mealVM)
        {
            if (id != mealVM.MealId)
            {
                return BadRequest();
            }

            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role == "Admin")
                    {
                        if (string.IsNullOrEmpty(mealVM.MealName))
                        {
                            return StatusCode(400, new
                            {
                                Message = "Meal name cannot be empty!!!"
                            });
                        }
                        else
                        {
                            var meal = mapper.Map<Meal>(mealVM);
                            var check = mealService.Update(meal);
                            return check ? Ok(new
                            {
                                Status = 1,
                                Message = "Update Meal Success"
                            }) : Ok(new
                            {
                                Status = 0,
                                Message = "Update Meal Fail"
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
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteMeal(string id)
        {
            if (mealService.Get(id) == null)
            {
                return BadRequest();
            }

            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role == "Admin")
                    {
                        var check = mealService.Delete(id);
                        return check ? Ok(new
                        {
                            Status = 1,
                            Message = "Delete Meal Success"
                        }) : Ok(new
                        {
                            Status = 0,
                            Message = "Delete Meal Fail"
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
    }
}
