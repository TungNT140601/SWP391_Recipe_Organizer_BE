using SWP391_Recipe_Organizer_BE.Repo.DataAccess;
using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using SWP391_Recipe_Organizer_BE.Repo.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Repo.Repository
{
    public class PlanDetailRepository : GenericRepository<PlanDetail>, IPlanDetailRepository
    {
        public PlanDetailRepository(RecipeOrganizerDBContext dBContext) : base(dBContext)
        {
        }

        public bool RemoveRange(List<PlanDetail> planDetails)
        {
            try
            {
                foreach (var item in planDetails)
                {
                    dbSet.Remove(item);
                }
                dBContext.SaveChanges();
                return true;
            }catch(Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
