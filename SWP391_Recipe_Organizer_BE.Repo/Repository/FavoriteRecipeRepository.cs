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
    public class FavoriteRecipeRepository : GenericRepository<FavoriteRecipe>, IFavoriteRecipeRepository
    {
        public FavoriteRecipeRepository(RecipeOrganizerDBContext dBContext) : base(dBContext)
        {
        }
        public override bool Add(FavoriteRecipe item)
        {
            try
            {
                var favor = dbSet.Where(x => x.UserId == item.UserId && x.RecipeId == item.RecipeId).FirstOrDefault();
                if (favor != null)
                {
                    return true;
                }
                else
                {
                    dbSet.Add(item);
                    dBContext.SaveChanges();
                    return true;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
