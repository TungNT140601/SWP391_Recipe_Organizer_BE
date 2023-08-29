using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using SWP391_Recipe_Organizer_BE.Repo.Interface;
using SWP391_Recipe_Organizer_BE.Service.Interface;
using SWP391_Recipe_Organizer_BE.Ultility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Service.Services
{
    public class PlanService : IPlanService
    {
        private readonly IPlanRepository planRepository;
        private readonly IRecipeService recipeService;
        private readonly IPlanDetailRepository planDetailRepository;

        public PlanService(IPlanRepository planRepository, IPlanDetailRepository planDetailRepository, IRecipeService recipeService)
        {
            this.planRepository = planRepository;
            this.planDetailRepository = planDetailRepository;
            this.recipeService = recipeService;
        }
        public async Task<bool> AddPlanDetail(string userId, List<string> breakfast, List<string> lunch, List<string> dinner, DateTime date)
        {
            var plan = planRepository.Get(x => x.UserId == userId);
            var bkPlanDT = new List<PlanDetail>();
            if (plan != null)
            {
                bkPlanDT = planDetailRepository.GetAll(x => x.PlanId == plan.PlanId && x.Date.Value.Date == date.Date).ToList();
            }
            else
            {
                plan = new Plan
                {
                    CreateTime = DateTime.Now,
                    UserId = userId,
                    IsDelete = false,
                    PlanDescription = "",
                    PlanId = GenerateId.AutoGenerateId(),
                    PlanName = "",
                    UpdateTime = DateTime.Now,
                };
                planRepository.Add(plan);
            }
            var planDetails = new List<PlanDetail>();
            foreach (var item in breakfast)
            {
                planDetails.Add(new PlanDetail
                {
                    PlanDetailId = GenerateId.AutoGenerateId(),
                    Date = date,
                    MealOfDate = 1,
                    PlanId = plan.PlanId,
                    RecipeId = item
                });
            }
            foreach (var item in lunch)
            {
                planDetails.Add(new PlanDetail
                {
                    PlanDetailId = GenerateId.AutoGenerateId(),
                    Date = date,
                    MealOfDate = 2,
                    PlanId = plan.PlanId,
                    RecipeId = item
                });
            }
            foreach (var item in dinner)
            {
                planDetails.Add(new PlanDetail
                {
                    PlanDetailId = GenerateId.AutoGenerateId(),
                    Date = date,
                    MealOfDate = 3,
                    PlanId = plan.PlanId,
                    RecipeId = item
                });
            }
            try
            {
                await planDetailRepository.RemoveRange(bkPlanDT);
                return await planDetailRepository.AddRange(planDetails);
            }
            catch (Exception ex)
            {
                await planDetailRepository.AddRange(bkPlanDT);
                throw new Exception(ex.Message);
            }
        }
        public PlanDetail GetDetail(string userId, string id)
        {
            try
            {
                var plan = planRepository.Get(x => x.UserId == userId && x.IsDelete == false, new System.Linq.Expressions.Expression<Func<Plan, object>>[]
                {
                    x => x.PlanDetails
                });
                if (plan != null)
                {
                    var planDetai = plan.PlanDetails.Where(x => x.PlanDetailId == id).FirstOrDefault();
                    return planDetai;
                }
                else
                {
                    return null;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public IEnumerable<PlanDetail> GetPlanOfWeek(string userId, DateTime dateTime)
        {
            try
            {
                var plan = planRepository.Get(x => x.UserId == userId && x.IsDelete == false, new System.Linq.Expressions.Expression<Func<Plan, object>>[]
                {
                    x => x.PlanDetails
                });
                if (plan != null)
                {
                    var planReturn = new List<PlanDetail>();
                    foreach (var planDetail in plan.PlanDetails)
                    {
                        if (planDetail.Date.Value.Date >= dateTime.Date && planDetail.Date.Value.Date <= dateTime.AddDays(6).Date)
                        {
                            planReturn.Add(planDetail);
                        }
                    }
                    return planReturn;
                }
                else
                {
                    plan = new Plan
                    {
                        PlanId = GenerateId.AutoGenerateId(),
                        CreateTime = DateTime.Now,
                        UpdateTime = DateTime.Now,
                        PlanName = "",
                        PlanDescription = "",
                        IsDelete = false,
                        UserId = userId,
                    };
                    planRepository.Add(plan);
                    plan.PlanDetails = new List<PlanDetail>();
                    return plan.PlanDetails;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public IEnumerable<PlanDetail> GetPlanOfDate(string userId, DateTime dateTime)
        {
            try
            {
                var plan = planRepository.Get(x => x.UserId == userId && x.IsDelete == false, new System.Linq.Expressions.Expression<Func<Plan, object>>[]
                {
                    x => x.PlanDetails
                });
                if (plan != null)
                {
                    var planReturn = new List<PlanDetail>();
                    foreach (var planDetail in plan.PlanDetails)
                    {
                        if (planDetail.Date.Value.Date == dateTime.Date)
                        {
                            planDetail.Recipe = recipeService.Get(planDetail.RecipeId);
                            planReturn.Add(planDetail);
                        }
                    }
                    return planReturn;
                }
                else
                {
                    return null;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public IEnumerable<PlanDetail> SearchPlanOfDate(string userId, DateTime dateTime)
        {
            try
            {
                var plan = planRepository.Get(x => x.UserId == userId && x.IsDelete == false, new System.Linq.Expressions.Expression<Func<Plan, object>>[]
                {
                    x => x.PlanDetails
                });
                if (plan != null)
                {
                    var planReturn = new List<PlanDetail>();
                    foreach (var planDetail in plan.PlanDetails)
                    {
                        if (planDetail.Date.Value.Date == dateTime.Date)
                        {
                            planDetail.Recipe = recipeService.Get(planDetail.RecipeId);
                            planReturn.Add(planDetail);
                        }
                    }
                    return planReturn;
                }
                else
                {
                    return null;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public bool DeletePlanDetail(string id)
        {
            try
            {
                var plan = planDetailRepository.Get(x => x.PlanDetailId == id, new System.Linq.Expressions.Expression<Func<PlanDetail, object>>[]
                {
                    x => x.Plan
                });
                if (plan != null)
                {
                    planDetailRepository.Remove(id);
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public bool UpdatePlanDetail(PlanDetail item)
        {
            try
            {
                var planDetail = planDetailRepository.Get(x => x.PlanDetailId == item.PlanDetailId, new System.Linq.Expressions.Expression<Func<PlanDetail, object>>[]
                {
                    x => x.Plan
                });
                if (planDetail != null)
                {
                    planDetail.Date = item.Date;
                    planDetail.MealOfDate = item.MealOfDate;
                    planDetail.RecipeId = item.RecipeId;
                    return planDetailRepository.Update(planDetail);
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public async Task<bool> DeletePlanOfDate(string userId, DateTime dateTime)
        {
            try
            {
                var plan = planRepository.Get(x => x.UserId == userId, new System.Linq.Expressions.Expression<Func<Plan, object>>[]
                {
                    x => x.PlanDetails
                });
                if (plan != null)
                {
                    if (plan.PlanDetails != null && plan.PlanDetails.Count() > 0)
                    {
                        var planToRemove = plan.PlanDetails.Where(x => x.Date.Value.Date == dateTime.Date).ToList();
                        if (planToRemove != null && planToRemove.Count() > 0)
                        {
                            return await planDetailRepository.RemoveRange(planToRemove);
                        }
                    }
                }
                return false;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
