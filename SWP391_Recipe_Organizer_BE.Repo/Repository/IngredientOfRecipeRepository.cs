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
    public class IngredientOfRecipeRepository : GenericRepository<IngredientOfRecipe>, IIngredientOfRecipeRepository
    {
        public IngredientOfRecipeRepository(RecipeOrganizerDBContext dBContext) : base(dBContext)
        {
        }

        public bool Remove(string recipeId, string ingredientId)
        {
            try
            {
                var item = dbSet.Where(x => x.IngredientId == ingredientId && x.RecipeId == recipeId).FirstOrDefault();
                if (item != null)
                {
                    dbSet.Remove(item);
                    dBContext.SaveChanges();
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
        public override bool Add(IngredientOfRecipe ingredientOfRecipe)
        {
            try
            {
                var item = dbSet.Where(x => x.IngredientId == ingredientOfRecipe.IngredientId && x.RecipeId == ingredientOfRecipe.RecipeId).FirstOrDefault();
                if (item == null)
                {
                    dbSet.Add(ingredientOfRecipe);
                    dBContext.SaveChanges();
                    return true;
                }
                else
                {
                    dBContext.Attach(item).State = Microsoft.EntityFrameworkCore.EntityState.Detached;
                    dbSet.Update(ingredientOfRecipe);
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
