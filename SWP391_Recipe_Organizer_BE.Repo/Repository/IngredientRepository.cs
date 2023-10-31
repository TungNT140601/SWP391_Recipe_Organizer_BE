using SWP391_Recipe_Organizer_BE.Repo.DataAccess;
using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using SWP391_Recipe_Organizer_BE.Repo.Interface;
using SWP391_Recipe_Organizer_BE.Ultility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Repo.Repository
{
    public class IngredientRepository : GenericRepository<Ingredient>, IIngredientRepository
    {
        public IngredientRepository(RecipeOrganizerDBContext dBContext) : base(dBContext)
        {
        }
        public override bool Add(Ingredient item)
        {
            try
            {
                var ingredient = dbSet.Where(x => x.IngredientName.ToLower().Trim() == item.IngredientName.ToLower().Trim() && x.IsDelete == false).FirstOrDefault();
                if (ingredient == null)
                {
                    item.IngredientId = GenerateId.AutoGenerateId();
                    item.IsDelete = false;
                    dbSet.Add(item);
                    dBContext.SaveChanges();
                    return true;
                }
                else
                {
                    throw new Exception("Ingredient Name Exist!!!");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public override bool Update(Ingredient item)
        {
            try
            {
                var ingredient = dbSet.Where(x => x.IsDelete == false && x.IngredientId == item.IngredientId).FirstOrDefault();
                if (ingredient != null)
                {
                    if(dbSet.Where(x => x.IngredientName.ToLower().Trim() == item.IngredientName.ToLower().Trim() && x.IsDelete == false && x.IngredientId != item.IngredientId).FirstOrDefault() == null)
                    {
                        dBContext.Entry(ingredient).State = Microsoft.EntityFrameworkCore.EntityState.Detached;
                        dbSet.Update(item);
                        dBContext.SaveChanges();
                        return true;
                    }
                    else
                    {
                        throw new Exception("Ingredient Name Exist!!!");
                    }
                }
                else
                {
                    throw new Exception("Ingredient Not Found!!!");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public async Task<Ingredient> Get(string id)
        {
            try
            {
                return await dbSet.FindAsync(id);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
