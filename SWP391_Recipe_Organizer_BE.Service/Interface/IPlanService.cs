using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Service.Interface
{
    public interface IPlanService
    {
        PlanDetail GetDetail(string userId, string id);
        IEnumerable<PlanDetail> GetPlanOfWeek(string userId, DateTime dateTime);
        IEnumerable<PlanDetail> GetPlanOfDate(string userId, DateTime dateTime);
        Task<bool> AddPlanDetail(string userId, List<string> breakfast, List<string> lunch, List<string> dinner,DateTime date);
        bool DeletePlanDetail(string id);
        bool UpdatePlanDetail(PlanDetail item);
        Task<bool> DeletePlanOfDate(string userId,DateTime dateTime);
    }
}
