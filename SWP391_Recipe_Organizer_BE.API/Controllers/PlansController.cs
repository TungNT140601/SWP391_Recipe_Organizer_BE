using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient.Server;
using SWP391_Recipe_Organizer_BE.API.ViewModel;
using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using SWP391_Recipe_Organizer_BE.Service.Interface;
using SWP391_Recipe_Organizer_BE.Service.Services;
using System.Security.Claims;

namespace SWP391_Recipe_Organizer_BE.API.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class PlansController : ControllerBase
    {
        private readonly IPlanService planService;
        private readonly IMapper mapper;

        public PlansController(IPlanService planService, IMapper mapper)
        {
            this.planService = planService;
            this.mapper = mapper;
        }

        [HttpGet]
        public async Task<IActionResult> GetPlan(string date)
        {
            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role == "Guest")
                    {
                        var userId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
                        DateTime dateTime = DateTime.ParseExact(date, "mm/dd/yyyy", null);
                        var plan = planService.GetPlanOfWeek(userId, dateTime);
                        if (plan != null)
                        {
                            var planReturn = mapper.Map<PlanVM>(plan);
                            planReturn.PlanDetailVMs.Clear();
                            foreach (var planDetail in plan.PlanDetails)
                            {
                                planReturn.PlanDetailVMs.Add(mapper.Map<PlanDetailVM>(planDetail));
                            }
                            return Ok(new
                            {
                                Status = 1,
                                Message = "Success",
                                Data = planReturn
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
        [HttpPut]
        public async Task<IActionResult> CreatePlan(PlanVM planVM)
        {
            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role == "Guest")
                    {
                        var plan = mapper.Map<Plan>(planVM);
                        plan.PlanDetails.Clear();
                        foreach (var planDetail in planVM.PlanDetailVMs)
                        {
                            plan.PlanDetails.Add(mapper.Map<PlanDetail>(planDetail));
                        }
                        //var check = planService.Add(plan);
                        return true ? Ok(new
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
        [HttpPost]
        public async Task<IActionResult> UpdatePlan(string id,PlanUpdateVM planVM)
        {
            try
            {
                var role = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role)?.Value;
                if (!string.IsNullOrEmpty(role))
                {
                    if (role == "Guest")
                    {
                        //var plan = mapper.Map<Plan>(planVM);
                        //plan.PlanDetails.Clear();
                        //foreach (var planDetail in planVM.PlanDetails)
                        //{
                        //    plan.PlanDetails.Add(mapper.Map<PlanDetail>(planDetail));
                        //}
                        //var check = planService.Add(plan);
                        return true ? Ok(new
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
    }
}
