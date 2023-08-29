using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using SWP391_Recipe_Organizer_BE.API.ViewModel;
using SWP391_Recipe_Organizer_BE.Repo;
using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using SWP391_Recipe_Organizer_BE.Service.Interface;
using SWP391_Recipe_Organizer_BE.Service.Services;
using System.Drawing.Printing;
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
        public async Task<IActionResult> GetAllByAdmin(int movePage, int itemPerPage)
        {
            try
            {
                var lst = ingredientService.GetAll();
                var ingredients = new List<IngredientVM>();
                foreach (var item in lst)
                {
                    ingredients.Add(mapper.Map<IngredientVM>(item));
                }
                if (itemPerPage == 0 && movePage == 0)
                {
                    return Ok(new
                    {
                        Status = 1,
                        Message = "Success",
                        TotalPage = 0,
                        MoveToPage = 0,
                        itemPerPage = 0,
                        TotalData = ingredients.Count(),
                        Data = ingredients,
                    });
                }
                else
                {
                    var totalPage = (int)Math.Ceiling((double)ingredients.Count() / itemPerPage);
                    if (movePage > totalPage || movePage == 0)
                    {
                        movePage = 1;
                    }
                    return Ok(new
                    {
                        Status = 1,
                        Message = "Success",
                        TotalPage = totalPage,
                        MoveToPage = movePage,
                        ItemPerPage = itemPerPage,
                        TotalData = ingredients.Count(),
                        Data = ingredients.Skip((movePage - 1) * itemPerPage).Take(itemPerPage).ToArray(),
                    });
                }
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
                    if (role == CommonValues.ADMIN)
                    {
                        var ingredient = Validate(ingredientVM);
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
                    if (role == CommonValues.ADMIN)
                    {
                        var ingredient = Validate(ingredientVM);
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
                    if (role == CommonValues.ADMIN)
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
        private Ingredient Validate(IngredientVM ingredientVM)
        {
            if (string.IsNullOrEmpty(ingredientVM.IngredientName.Trim()))
            {
                throw new Exception("Ingredient Name cannot be empty!!!");
            }
            if (string.IsNullOrEmpty(ingredientVM.Measure.Trim()))
            {
                throw new Exception("Measure cannot be empty!!!");
            }
            if (ingredientVM.Protein <= 0)
            {
                throw new Exception("Ingredient Protein cannot be a negative number!!!");
            }
            if (ingredientVM.Fat <= 0)
            {
                throw new Exception("Ingredient Protein cannot be a negative number!!!");
            }
            if (ingredientVM.Carbohydrate <= 0)
            {
                throw new Exception("Ingredient Protein cannot be a negative number!!!");
            }
            ingredientVM.Calories = ingredientVM.Fat * 9 + ingredientVM.Carbohydrate * 4 + ingredientVM.Protein * 4;
            return mapper.Map<Ingredient>(ingredientVM);
        }
    }
}
