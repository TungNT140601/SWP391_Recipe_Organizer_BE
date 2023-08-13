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
        Plan Get(string id);
        PlanDetail GetDetail(string id);
        IEnumerable<Plan> GetAll();
        Plan GetPlanOfWeek(string userId, DateTime dateTime);
        bool Add(Plan item);
        bool AddPlanDetail(PlanDetail item);
        bool Delete(string id);
        bool Update(Plan item);
        bool DeletePlanDetail(string id);
        bool UpdatePlanDetail(PlanDetail item);
    }
}
