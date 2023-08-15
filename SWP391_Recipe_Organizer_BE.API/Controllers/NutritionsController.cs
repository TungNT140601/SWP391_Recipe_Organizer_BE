using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using SWP391_Recipe_Organizer_BE.API.ViewModel;
using SWP391_Recipe_Organizer_BE.Repo;
using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using SWP391_Recipe_Organizer_BE.Service.Interface;
using System.Security.Claims;

namespace SWP391_Recipe_Organizer_BE.API.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class NutritionsController : ControllerBase
    {
        private readonly INutritionService nutritionService;
        private readonly IMapper mapper;
        public NutritionsController(INutritionService nutritionService, IMapper mapper)
        {
            this.nutritionService = nutritionService;
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
                    Data = nutritionService.GetAll()
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
                return Ok(new
                {
                    Status = 1,
                    Data = nutritionService.Get(id)
                });
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpPost]
        public async Task<IActionResult> AddNutrition(NutritionVM nutritionVM)
        {
            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role == CommonValues.ADMIN)
                    {
                        if (string.IsNullOrEmpty(nutritionVM.NutritionName))
                        {
                            return StatusCode(400, new
                            {
                                Message = "Nutrition name cannot be empty!!!"
                            });
                        }
                        else
                        {
                            var nutrition = mapper.Map<Nutrition>(nutritionVM);
                            var check = nutritionService.Add(nutrition);
                            return check ? Ok(new
                            {
                                Status = 1,
                                Message = "Add Nutrition Success"
                            }) : Ok(new
                            {
                                Status = 0,
                                Message = "Add Nutrition Fail"
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
        public async Task<IActionResult> UpdateNutrition(string id, NutritionVM nutritionVM)
        {
            if (id != nutritionVM.NutritionId)
            {
                return BadRequest();
            }

            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role == CommonValues.ADMIN)
                    {
                        if (string.IsNullOrEmpty(nutritionVM.NutritionName))
                        {
                            return StatusCode(400, new
                            {
                                Message = "Nutrition name cannot be empty!!!"
                            });
                        }
                        else
                        {
                            var nutrition = mapper.Map<Nutrition>(nutritionVM);
                            var check = nutritionService.Update(nutrition);
                            return check ? Ok(new
                            {
                                Status = 1,
                                Message = "Update Nutrition Success"
                            }) : Ok(new
                            {
                                Status = 0,
                                Message = "Update Nutrition Fail"
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
        public async Task<IActionResult> DeleteNutrition(string id)
        {
            if (nutritionService.Get(id) == null)
            {
                return BadRequest();
            }

            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role == CommonValues.ADMIN)
                    {
                        var check = nutritionService.Delete(id);
                        return check ? Ok(new
                        {
                            Status = 1,
                            Message = "Delete Nutrition Success"
                        }) : Ok(new
                        {
                            Status = 0,
                            Message = "Delete Nutrition Fail"
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
