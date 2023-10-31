using Microsoft.EntityFrameworkCore;
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

        public async Task<bool> RemoveRange(List<PlanDetail> planDetails)
        {
            try
            {
                foreach (var item in planDetails)
                {
                    dbSet.Remove(item);
                }
                await dBContext.SaveChangesAsync();
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public async Task<bool> AddRange(List<PlanDetail> planDetails)
        {
            try
            {
                foreach (var item in planDetails)
                {
                    dbSet.Add(item);
                }
                await dBContext.SaveChangesAsync();
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public async Task<IEnumerable<PlanDetail>> GetPlanDetailsOfPlan(string planId)
        {
            try
            {
                return await dbSet.Where(x => x.PlanId == planId).ToListAsync();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
