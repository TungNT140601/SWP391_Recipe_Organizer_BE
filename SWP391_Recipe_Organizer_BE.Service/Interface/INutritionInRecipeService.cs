using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Service.Interface
{
    public interface INutritionInRecipeService
    {
        NutritionInRecipe Get(string id);
        IEnumerable<NutritionInRecipe> GetAll();
        bool Add(NutritionInRecipe item);
        bool Remove(NutritionInRecipe item);
        bool Update(NutritionInRecipe item);
    }
}
