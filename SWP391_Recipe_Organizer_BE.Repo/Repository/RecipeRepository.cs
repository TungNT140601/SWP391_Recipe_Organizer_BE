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
    public class RecipeRepository : GenericRepository<Recipe>, IRecipeRepository
    {
        public RecipeRepository(RecipeOrganizerDBContext dBContext) : base(dBContext)
        {
        }
        public override bool Add(Recipe item)
        {
            try
            {
                dBContext.Recipes.Add(item);
                dBContext.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public void RemoveAddFail(string recipeId)
        {
            try
            {
                var recipe = Get(x => x.RecipeId == recipeId);
                if (recipe != null)
                {
                    dbSet.Remove(recipe);
                    dBContext.SaveChanges();
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
