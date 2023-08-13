using System.Security.Claims;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using SWP391_Recipe_Organizer_BE.API.ViewModel;
using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using SWP391_Recipe_Organizer_BE.Service.Interface;

namespace SWP391_Recipe_Organizer_BE.API.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class CountriesController : ControllerBase
    {
        private readonly ICountryService countryService;
        private readonly IMapper mapper;

        public CountriesController(ICountryService countryService, IMapper mapper)
        {
            this.countryService = countryService;
            this.mapper = mapper;
        }

        [HttpGet]
        public async Task<IActionResult> GetCountriesAdd()
        {
            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role == "Cooker" || role == "Admin")
                    {
                        var lst = countryService.GetAllAdd();
                        var countries = new List<CountryVM>();
                        foreach (var item in lst)
                        {
                            countries.Add(mapper.Map<CountryVM>(item));
                        }
                        return Ok(new
                        {
                            Status = 1,
                            Message = "Success",
                            Data = countries
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
        public async Task<IActionResult> GetCountriesFilter()
        {
            try
            {
                var lst = countryService.GetAllFilter();
                var countries = new List<CountryVM>();
                foreach (var item in lst)
                {
                    countries.Add(mapper.Map<CountryVM>(item));
                }
                return Ok(new
                {
                    Status = 1,
                    Message = "Success",
                    Data = countries
                });
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpGet("{id}")]
        public async Task<IActionResult> GetCountry(string id)
        {
            try
            {
                return Ok(new
                {
                    Status = 1,
                    Message = "Success",
                    Data = mapper.Map<CountryVM>(countryService.Get(id))
                });
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateCountry(string id, CountryVM countryVM)
        {
            if (id != countryVM.CountryId)
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
                        if (string.IsNullOrEmpty(countryVM.CountryName))
                        {
                            return StatusCode(400, new
                            {
                                Message = "Country name cannot be empty!!!"
                            });
                        }
                        else
                        {
                            var country = mapper.Map<Country>(countryVM);
                            var check = countryService.Update(country);
                            return check ? Ok(new
                            {
                                Status = 1,
                                Message = "Update Country Success"
                            }) : Ok(new
                            {
                                Status = 0,
                                Message = "Update Country Fail"
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
        [HttpPost]
        public async Task<IActionResult> AddCountry(CountryVM countryVM)
        {
            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role == "Admin")
                    {
                        if (string.IsNullOrEmpty(countryVM.CountryName))
                        {
                            return StatusCode(400, new
                            {
                                Message = "Country name cannot be empty!!!"
                            });
                        }
                        else
                        {
                            var country = mapper.Map<Country>(countryVM);
                            var check = countryService.Add(country);
                            return check ? Ok(new
                            {
                                Status = 1,
                                Message = "Add Country Success"
                            }) : Ok(new
                            {
                                Status = 0,
                                Message = "Add Country Fail"
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
        public async Task<IActionResult> DeleteCountry(string id)
        {
            if (countryService.Get(id) == null)
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
                        var check = countryService.Delete(id);
                        return check ? Ok(new
                        {
                            Status = 1,
                            Message = "Delete Country Success"
                        }) : Ok(new
                        {
                            Status = 0,
                            Message = "Delete Country Fail"
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
