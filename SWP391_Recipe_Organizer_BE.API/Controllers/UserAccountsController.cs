using System.Data;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using SWP391_Recipe_Organizer_BE.API.ViewModel;
using SWP391_Recipe_Organizer_BE.Repo;
using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
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
                    return Ok(new
                    {
                        Status = 1,
                        Message = "Login Success",
                        Fullname = user.FullName,
                        Email = user.Email,
                        Photo = user.AvatarName,
                        Role = CommonValues.ADMIN,
                        Token = GenerateJwtToken(user.UserId, CommonValues.ADMIN)
                    });
                }
                else
                {
                    return Ok(new
                    {
                        Status = 0,
                        Message = "Login Fail",
                        Fullname = "",
                        Email = "",
                        Photo = "",
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
                            role = CommonValues.ADMIN;
                            break;
                        case 1:
                            role = CommonValues.USER;
                            break;
                        case 2:
                            role = CommonValues.COOKER;
                            break;
                    }
                    return Ok(new
                    {
                        Status = 1,
                        Message = "Login Success",
                        Fullname = user.FullName,
                        Email = user.Email,
                        Photo = user.AvatarName,
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
                        Fullname = "",
                        Email = "",
                        Photo = "",
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
                    if (role == CommonValues.ADMIN)
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
        public async Task<IActionResult> GetAllUser(int movePage, int itemPerPage)
        {
            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role == CommonValues.ADMIN)
                    {
                        var lst = userAccountService.GetAllAdmin();
                        var users = new List<UserAccountAdminVM>();
                        foreach (var item in lst)
                        {
                            if (item.Role != 0)
                            {
                                var user = mapper.Map<UserAccountAdminVM>(item);
                                if (item.IsDelete.Value)
                                {
                                    user.Status = "Inactive";
                                }
                                else
                                {
                                    user.Status = "Active";
                                }
                                switch (item.Role)
                                {
                                    case 0:
                                        user.RoleName = CommonValues.ADMIN;
                                        break;
                                    case 1:
                                        user.RoleName = CommonValues.USER;
                                        break;
                                    case 2:
                                        user.RoleName = CommonValues.COOKER;
                                        break;
                                }
                                users.Add(user);
                            }
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
                                TotalData = users.Count(),
                                Data = users,
                            });
                        }
                        else
                        {
                            var totalPage = (int)Math.Ceiling((double)users.Count() / itemPerPage);
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
                                TotalData = users.Count(),
                                Data = users.Skip((movePage - 1) * itemPerPage).Take(itemPerPage).ToArray(),
                            });
                        }
                    }
                    else
                    {
                        return Ok(new
                        {
                            Status = 0,
                            Message = "Role Denied",
                            TotalPage = 0,
                            MoveToPage = 0,
                            TotalData = 0,
                            Data = new { },
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
                    if (role == CommonValues.ADMIN)
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
        [HttpDelete]
        public async Task<IActionResult> BanUser(string userId)
        {
            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role == CommonValues.ADMIN)
                    {
                        if (userAccountService.BanUser(userId))
                        {
                            var lst = userAccountService.GetAllAdmin();
                            var users = new List<UserAccountAdminVM>();
                            foreach (var item in lst)
                            {
                                if (item.Role != 0)
                                {
                                    var user = mapper.Map<UserAccountAdminVM>(item);
                                    if (item.IsDelete.Value)
                                    {
                                        user.Status = "Inactive";
                                    }
                                    else
                                    {
                                        user.Status = "Active";
                                    }
                                    switch (item.Role)
                                    {
                                        case 0:
                                            user.RoleName = CommonValues.ADMIN;
                                            break;
                                        case 1:
                                            user.RoleName = CommonValues.USER;
                                            break;
                                        case 2:
                                            user.RoleName = CommonValues.COOKER;
                                            break;
                                    }
                                    users.Add(user);
                                }
                            }
                            return Ok(new
                            {
                                Status = 1,
                                Message = "Success",
                                Data = users
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
        [HttpPut]
        public async Task<IActionResult> UnBanUser(string userId)
        {
            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role == CommonValues.ADMIN)
                    {
                        if (userAccountService.UnBanUser(userId))
                        {
                            var lst = userAccountService.GetAllAdmin();
                            var users = new List<UserAccountAdminVM>();
                            foreach (var item in lst)
                            {
                                if (item.Role != 0)
                                {
                                    var user = mapper.Map<UserAccountAdminVM>(item);
                                    if (item.IsDelete.Value)
                                    {
                                        user.Status = "Inactive";
                                    }
                                    else
                                    {
                                        user.Status = "Active";
                                    }
                                    switch (item.Role)
                                    {
                                        case 0:
                                            user.RoleName = CommonValues.ADMIN;
                                            break;
                                        case 1:
                                            user.RoleName = CommonValues.USER;
                                            break;
                                        case 2:
                                            user.RoleName = CommonValues.COOKER;
                                            break;
                                    }
                                    users.Add(user);
                                }
                            }
                            return Ok(new
                            {
                                Status = 1,
                                Message = "Success",
                                Data = users
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
        public async Task<IActionResult> UpdateInfo(UserAccountVM user)
        {
            try
            {
                var userId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
                if (!string.IsNullOrEmpty(userId))
                {
                    var userInfo = userAccountService.Get(userId);
                    if (userInfo == null)
                    {
                        return Ok(new
                        {
                            Status = 0,
                            Message = "Not Found User!!!"
                        });
                    }
                    else
                    {
                        if (string.IsNullOrEmpty(user.FullName))
                        {
                            return Ok(new
                            {
                                Status = 0,
                                Message = "You must input Fullname!!!!"
                            });
                        }
                        else
                        {
                            userInfo.FullName = user.FullName;
                        }
                        if (!string.IsNullOrEmpty(user.PhoneNum))
                        {
                            if (user.PhoneNum.Length != 10)
                            {
                                return Ok(new
                                {
                                    Status = 0,
                                    Message = "Phone must have 10 numbs!!!!"
                                });
                            }
                            else
                            {
                                userInfo.PhoneNum = user.PhoneNum;
                            }
                        }
                        else
                        {
                            userInfo.PhoneNum = "";
                        }
                        if (!string.IsNullOrEmpty(user.Email) && user.Email != userInfo.Email)
                        {
                            return Ok(new
                            {
                                Status = 0,
                                Message = "Email Error!!!!"
                            });
                        }
                        if (!string.IsNullOrEmpty(user.Address))
                        {
                            userInfo.Address = user.Address;
                        }
                        else
                        {
                            userInfo.Address = "";
                        }
                        if (!string.IsNullOrEmpty(user.UserInfo))
                        {
                            userInfo.UserInfo = user.UserInfo;
                        }
                        else
                        {
                            userInfo.UserInfo = "";
                        }

                        return userAccountService.Update(userInfo) ? Ok(new
                        {
                            Status = 1,
                            Message = "Success"
                        }) : Ok(new
                        {
                            Status = 0,
                            Message = "Fail"
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
