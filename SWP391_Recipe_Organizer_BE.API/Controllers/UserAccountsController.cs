using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using SWP391_Recipe_Organizer_BE.API.ViewModel;
using SWP391_Recipe_Organizer_BE.Service.Interface;

namespace SWP391_Recipe_Organizer_BE.API.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class UserAccountsController : ControllerBase
    {
        private readonly IConfiguration configuration;
        private readonly IUserAccountService userAccountService;
        private readonly IMapper mapper;

        public UserAccountsController(IConfiguration configuration, IUserAccountService userAccountService, IMapper mapper)
        {
            this.configuration = configuration;
            this.userAccountService = userAccountService;
            this.mapper = mapper;
        }
        [HttpPost]
        public async Task<IActionResult> CheckLogin([FromBody] LoginVM loginVM)
        {
            try
            {
                var user = userAccountService.CheckLoginByUserName(loginVM.Username, loginVM.Password);
                if (user != null)
                {
                    string role = "";
                    switch (user.Role)
                    {
                        case 0:
                            role = "Admin";
                            break;
                        case 1:
                            role = "Guest";
                            break;
                        case 2:
                            role = "Cooker";
                            break;
                    }
                    return Ok(new
                    {
                        Status = 1,
                        Message = "Login Success",
                        Role = role,
                        Token = GenerateJwtToken(user.UserId, role)
                    });
                }
                else
                {
                    return Ok(new
                    {
                        Status = 0,
                        Message = "Login Fail",
                        Role = "",
                        Token = ""
                    });
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpPost]
        public async Task<IActionResult> CheckLoginEmail([FromBody] LoginEmailVM loginVM)
        {
            try
            {
                var user = userAccountService.CheckLoginByEmail(loginVM.Email, loginVM.GGToken, loginVM.Fullname, loginVM.Image);
                if (user != null)
                {
                    string role = "";
                    switch (user.Role)
                    {
                        case 0:
                            role = "Admin";
                            break;
                        case 1:
                            role = "Guest";
                            break;
                        case 2:
                            role = "Cooker";
                            break;
                    }
                    return Ok(new
                    {
                        Status = 1,
                        Message = "Login Success",
                        Role = "",
                        Token = GenerateJwtToken(user.UserId, role)
                    });
                }
                else
                {
                    return Ok(new
                    {
                        Status = 0,
                        Message = "Login Fail",
                        Role = "",
                        Token = ""
                    });
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        //[HttpPost]
        //public async Task<IActionResult> RegisByEmail([FromBody] LoginEmailVM loginVM)
        //{
        //    try
        //    {
        //        var user = userAccountService.RegisWithEmail(loginVM.Email, loginVM.GGToken);
        //        if (user != null)
        //        {
        //            return Ok(new
        //            {
        //                Status = 1,
        //                Message = "Regis Success"
        //            });
        //        }
        //        else
        //        {
        //            return Ok(new
        //            {
        //                Status = 0,
        //                Message = "Regis Fail"
        //            });
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        return BadRequest(ex.Message);
        //    }
        //}
        [HttpPost]
        public async Task<IActionResult> RegisByUsername([FromBody] LoginVM loginVM)
        {
            try
            {

                var check = userAccountService.CheckUsernameExist(loginVM.Username);
                if (check)
                {
                    return StatusCode(400, new
                    {
                        Message = "Username has been used!!!"
                    });
                }
                else
                {
                    var user = userAccountService.RegisWithUsername(loginVM.Username, loginVM.Password);
                    if (user != null)
                    {
                        return Ok(new
                        {
                            Status = 1,
                            Message = "Regis Success"
                        });
                    }
                    else
                    {
                        return Ok(new
                        {
                            Status = 0,
                            Message = "Regis Fail"
                        });
                    }
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpGet]
        public async Task<IActionResult> GetUserInfo()
        {
            try
            {
                string userId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
                if (!string.IsNullOrEmpty(userId))
                {
                    var user = userAccountService.GetUserInfo(userId);
                    var userVM = mapper.Map<UserAccountVM>(user);
                    if (user != null)
                    {
                        return Ok(new
                        {
                            Status = 1,
                            Message = "Success",
                            Data = userVM
                        });
                    }
                    else
                    {
                        return Ok(new
                        {
                            Status = 0,
                            Message = "Not Found User",
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
        public async Task<IActionResult> GetUserInfoByAdmin(string id)
        {
            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role == "Admin")
                    {
                        var user = userAccountService.GetUserInfo(id);
                        var userVM = mapper.Map<UserAccountVM>(user);
                        if (user != null)
                        {
                            return Ok(new
                            {
                                Status = 1,
                                Message = "Success",
                                Data = userVM
                            });
                        }
                        else
                        {
                            return Ok(new
                            {
                                Status = 0,
                                Message = "Not Found User",
                                Data = new { }
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
        [HttpGet]
        public async Task<IActionResult> GetAllUser()
        {
            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role == "Admin")
                    {
                        var lst = userAccountService.GetAll();
                        var users = new List<UserAccountVM>();
                        foreach (var item in lst)
                        {
                            users.Add(mapper.Map<UserAccountVM>(item));
                        }
                        return Ok(new
                        {
                            Status = 1,
                            Message = "Success",
                            Data = users.ToList()
                        }); ;
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
        public async Task<IActionResult> ChangeRole(string id, string roleChange)
        {
            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role == "Admin")
                    {
                        return userAccountService.ChangeRole(id, roleChange) ? Ok(new
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
        private string GenerateJwtToken(string id, string role)
        {
            var jwtSettings = configuration.GetSection("JwtSettings");
            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtSettings["SecretKey"]));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);
            var claims = new List<Claim>
            {
            new Claim(ClaimTypes.NameIdentifier, id),
            new Claim(ClaimTypes.Role, role)
        };
            var token = new JwtSecurityToken(
                issuer: jwtSettings["Issuer"],
                audience: jwtSettings["Audience"],
                claims: claims,
                expires: DateTime.UtcNow.AddMinutes(30),
                signingCredentials: creds
            );

            return new JwtSecurityTokenHandler().WriteToken(token);
        }
    }
}
