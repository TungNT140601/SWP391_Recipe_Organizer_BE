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
        IEnumerable<Plan> GetAll();
        bool Add(Plan item);
        bool Remove(Plan item);
        bool Update(Plan item);
    }
}
