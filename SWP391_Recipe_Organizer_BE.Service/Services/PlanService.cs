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
                var plan = planRepository.GetAll(x => x.UserId == item.UserId && x.IsDelete == false).FirstOrDefault();
                if(plan == null)
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
                else
                {
                    plan.UpdateTime = DateTime.Now;
                    plan.IsDelete = false;
                    planRepository.Update(plan);
                    foreach (var planDetail in item.PlanDetails)
                    {
                        if (string.IsNullOrEmpty(planDetail.PlanDetailId))
                        {
                            planDetail.PlanDetailId = GenerateId.AutoGenerateId();
                            planDetail.PlanId = item.PlanId;
                            planDetailRepository.Add(planDetail);
                        }
                        else
                        {
                            var planDT = planDetailRepository.Get(x => x.PlanDetailId == planDetail.PlanDetailId);
                            if(planDT != null)
                            {
                                planDT.MealOfDate = planDetail.MealOfDate;
                                planDT.Date = planDetail.Date;
                                planDT.RecipeId = planDetail.RecipeId;
                                planDetailRepository.Update(planDT);
                            }
                            else
                            {
                                planDetail.PlanDetailId = GenerateId.AutoGenerateId();
                                planDetail.PlanId = item.PlanId;
                                planDetailRepository.Add(planDetail);
                            }
                        }
                    }
                    return true;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public bool AddPlanDetail(PlanDetail item)
        {
            try
            {
                var plan = planRepository.Get(x => x.PlanId == item.PlanId);
                if(plan != null)
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
        public PlanDetail GetDetail(string id)
        {
            try
            {
                var plan = planDetailRepository.Get(x => x.PlanDetailId == id, new System.Linq.Expressions.Expression<Func<PlanDetail, object>>[]
                {
                    x => x.Plan
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
                        planDetailRepository.Remove(itemDetail.PlanDetailId);
                        itemDetail.PlanDetailId = GenerateId.AutoGenerateId();
                        itemDetail.PlanId = plan.PlanId;
                        planDetailRepository.Add(itemDetail);
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
    }
}
