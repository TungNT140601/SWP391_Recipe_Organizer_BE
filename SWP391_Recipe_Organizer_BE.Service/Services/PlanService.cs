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
        public bool AddPlanDetail(PlanDetail item, string userId)
        {
            try
            {
                var plan = planRepository.Get(x => x.UserId == userId);
                if (plan == null)
                {
                    var planNew = new Plan
                    {
                        PlanId = GenerateId.AutoGenerateId(),
                        CreateTime = DateTime.Now,
                        UpdateTime = DateTime.Now,
                        IsDelete = false,
                        PlanDescription = "",
                        PlanName = "",
                        UserId = userId
                    };
                    if (planRepository.Add(planNew))
                    {
                        item.PlanDetailId = GenerateId.AutoGenerateId();
                        item.PlanId = planNew.PlanId;
                        planDetailRepository.Add(item);
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
                else
                {
                    if (plan != null)
                    {
                        item.PlanDetailId = GenerateId.AutoGenerateId();
                        item.PlanId = plan.PlanId;
                        planDetailRepository.Add(item);
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
            }
            catch (Exception ex)
            {
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
                    return null;
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

        public bool DeletePlanOfDate(string userId, DateTime dateTime)
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
                            return planDetailRepository.RemoveRange(planToRemove);
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
