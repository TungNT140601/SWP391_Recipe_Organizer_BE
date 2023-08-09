using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Service.Interface
{
    public interface IPlanDetailService
    {
        PlanDetail Get(string id);
        IEnumerable<PlanDetail> GetAll();
        bool Add(PlanDetail item);
        bool Remove(PlanDetail item);
        bool Update(PlanDetail item);
    }
}
