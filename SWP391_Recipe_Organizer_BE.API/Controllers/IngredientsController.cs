using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using SWP391_Recipe_Organizer_BE.API.ViewModel;
using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using SWP391_Recipe_Organizer_BE.Service.Interface;
using SWP391_Recipe_Organizer_BE.Service.Services;
using System.Security.Claims;

namespace SWP391_Recipe_Organizer_BE.API.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class IngredientsController : ControllerBase
    {

        private readonly IIngredientService ingredientService;
        private readonly IMapper mapper;
        public IngredientsController(IIngredientService ingredientService, IMapper mapper)
        {
            this.ingredientService = ingredientService;
            this.mapper = mapper;
        }
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            try
            {
                var lst = ingredientService.GetAll();
                var ingredients = new List<IngredientVM>();
                foreach (var item in lst)
                {
                    ingredients.Add(mapper.Map<IngredientVM>(item));
                }
                return Ok(new
                {
                    Status = 1,
                    Message = "Success",
                    Data = ingredients
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
                    Data = mapper.Map<IngredientVM>(ingredientService.Get(id))
                });
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpPost]
        public async Task<IActionResult> AddIngredient(IngredientVM ingredientVM)
        {
            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role == "Admin")
                    {
                        if (string.IsNullOrEmpty(ingredientVM.IngredientName))
                        {
                            return StatusCode(400, new
                            {
                                Message = "Ingredient name cannot be empty!!!"
                            });
                        }
                        else
                        {
                            var ingredient = mapper.Map<Ingredient>(ingredientVM);
                            var check = ingredientService.Add(ingredient);
                            return check ? Ok(new
                            {
                                Status = 1,
                                Message = "Add Ingredient Success"
                            }) : Ok(new
                            {
                                Status = 0,
                                Message = "Add Ingredient Fail"
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
        public async Task<IActionResult> UpdateIngredient(string id, IngredientVM ingredientVM)
        {
            if (id != ingredientVM.IngredientId)
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
                        if (string.IsNullOrEmpty(ingredientVM.IngredientName))
                        {
                            return StatusCode(400, new
                            {
                                Message = "Ingredient name cannot be empty!!!"
                            });
                        }
                        else
                        {
                            var ingredient = mapper.Map<Ingredient>(ingredientVM);
                            var check = ingredientService.Update(ingredient);
                            return check ? Ok(new
                            {
                                Status = 1,
                                Message = "Update Ingredient Success"
                            }) : Ok(new
                            {
                                Status = 0,
                                Message = "Update Ingredient Fail"
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
        public async Task<IActionResult> DeleteIngredient(string id)
        {
            if (ingredientService.Get(id) == null)
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
                        var check = ingredientService.Delete(id);
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
