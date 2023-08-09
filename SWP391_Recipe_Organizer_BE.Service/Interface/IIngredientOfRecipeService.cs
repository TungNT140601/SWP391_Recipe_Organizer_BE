using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Service.Interface
{
    public interface IIngredientOfRecipeService
    {
        IngredientOfRecipe Get(string id);
        IEnumerable<IngredientOfRecipe> GetAll();
        bool Add(IngredientOfRecipe item);
        bool Remove(IngredientOfRecipe item);
        bool Update(IngredientOfRecipe item);
    }
}
