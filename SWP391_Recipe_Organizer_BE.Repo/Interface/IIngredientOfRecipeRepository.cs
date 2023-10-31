using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Repo.Interface
{
    public interface IIngredientOfRecipeRepository : IGenericRepository<IngredientOfRecipe>
    {
        bool Remove(string recipeId, string ingredientId);
        void RemoveAll(string recipeId);
        Task<bool> AddRange(List<IngredientOfRecipe> ingredientOfRecipes, string recipeId);
        Task<IEnumerable<IngredientOfRecipe>> GetIngredientOfRecipe(string id);
    }
}
