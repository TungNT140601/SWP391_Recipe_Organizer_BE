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
        private readonly IPlanDetailRepository planDetailRepository;

        public PlanService(IPlanRepository planRepository, IPlanDetailRepository planDetailRepository)
        {
            this.planRepository = planRepository;
            this.planDetailRepository = planDetailRepository;
        }

        public bool Add(Plan item)
        {
            try
            {
                item.PlanId = GenerateId.AutoGenerateId();
                item.CreateTime = DateTime.Now;
                item.UpdateTime = DateTime.Now;
                item.IsDelete = false;
                planRepository.Add(item);
                var planDetails = item.PlanDetails;
                foreach (var planDetail in planDetails)
                {
                    planDetail.PlanDetailId = GenerateId.AutoGenerateId();
                    planDetail.PlanId = item.PlanId;
                    planDetailRepository.Add(planDetail);
                }
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public Plan Get(string id)
        {
            try
            {
                var plan = planRepository.Get(x => x.PlanId == id && x.IsDelete == false, new System.Linq.Expressions.Expression<Func<Plan, object>>[]
                {
                    x => x.PlanDetails
                });
                return plan;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public Plan GetPlanOfWeek(string userId, DateTime dateTime)
        {
            try
            {
                var plans = planRepository.GetAll(x => x.UserId == userId && x.IsDelete == false, new System.Linq.Expressions.Expression<Func<Plan, object>>[]
                {
                    x => x.PlanDetails
                });
                var planReturn = new Plan();
                foreach (var plan in plans)
                {
                    foreach (var planDetail in plan.PlanDetails)
                    {
                        if (planDetail.Date.Value.Date >= dateTime.Date && planDetail.Date.Value.Date <= dateTime.AddDays(7).Date)
                        {
                            planReturn.PlanId = plan.PlanId;
                            planReturn.PlanName = plan.PlanName;
                            planReturn.PlanDescription = plan.PlanDescription;
                            planReturn.CreateTime = plan.CreateTime;
                            planReturn.PlanDetails.Add(planDetail);
                        }
                    }
                }
                return planReturn;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public IEnumerable<Plan> GetAll()
        {
            try
            {
                var plan = planRepository.GetAll(x => x.IsDelete == false, new System.Linq.Expressions.Expression<Func<Plan, object>>[]
                {
                    x => x.PlanDetails
                });
                return plan;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public bool Delete(string id)
        {
            try
            {
                var plan = planRepository.Get(x => x.PlanId == id && x.IsDelete == false, new System.Linq.Expressions.Expression<Func<Plan, object>>[]
                {
                    x => x.PlanDetails
                });
                if (plan != null)
                {
                    plan.IsDelete = true;
                    plan.DeleteTime = DateTime.Now;
                    planRepository.Update(plan);
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

        public bool Update(Plan item)
        {
            try
            {
                var plan = planRepository.Get(x => x.PlanId == item.PlanId && x.IsDelete == false, new System.Linq.Expressions.Expression<Func<Plan, object>>[]
                {
                    x => x.PlanDetails
                });
                if (plan != null)
                {
                    plan.PlanDescription = item.PlanDescription;
                    plan.PlanName = item.PlanName;
                    planRepository.Update(plan);
                    foreach (var itemDetail in plan.PlanDetails)
                    {
                        var planDetail = planDetailRepository.Get(x => x.PlanDetailId == itemDetail.PlanDetailId);
                        planDetail.MealOfDate = itemDetail.MealOfDate;
                        planDetail.Date = itemDetail.Date;
                        planDetail.RecipeId = itemDetail.RecipeId;
                        planDetailRepository.Update(planDetail);
                    }
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
    }
}
