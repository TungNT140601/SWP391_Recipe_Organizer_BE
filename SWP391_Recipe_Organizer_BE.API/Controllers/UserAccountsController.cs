using System;
using System.Collections.Generic;
using System.Data;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using SWP391_Recipe_Organizer_BE.Repo.DataAccess;
using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using SWP391_Recipe_Organizer_BE.Repo.ViewModel;
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

        public UserAccountsController(IConfiguration configuration, IUserAccountService userAccountService,IMapper mapper)
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
                return Ok(new
                {
                    Status = -1,
                    Message = $"Server Error: {ex.Message}",
                    Role = "",
                    Token = ""
                });
            }
        }
        [HttpPost]
        public async Task<IActionResult> CheckLoginEmail([FromBody] LoginEmailVM loginVM)
        {
            try
            {
                var user = userAccountService.CheckLoginByEmail(loginVM.Email, loginVM.GGToken);
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
                return Ok(new
                {
                    Status = -1,
                    Message = $"Server Error: {ex.Message}",
                    Role = "",
                    Token = ""
                });
            }
        }
        [HttpPost]
        public async Task<IActionResult> RegisByEmail([FromBody] LoginEmailVM loginVM)
        {
            try
            {
                var user = userAccountService.RegisWithEmail(loginVM.Email, loginVM.GGToken);
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
            catch (Exception ex)
            {
                return Ok(new
                {
                    Status = -1,
                    Message = $"Server Error: {ex.Message}"
                });
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
            }catch(Exception ex)
            {
                return Ok(new
                {
                    Status = -1,
                    Message = "Server Error",
                    Data = new { }
                });
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
