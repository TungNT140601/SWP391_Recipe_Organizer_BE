using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Repo.Interface
{
    public interface IRecipeRepository : IGenericRepository<Recipe>
    {
        void RemoveAddFail(string recipeId);
    }
}
