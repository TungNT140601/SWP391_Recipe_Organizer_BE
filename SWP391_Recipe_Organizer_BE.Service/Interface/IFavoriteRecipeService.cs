using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Service.Interface
{
    public interface IFavoriteRecipeService
    {
        FavoriteRecipe Get(string id);
        IEnumerable<FavoriteRecipe> GetAll();
        bool Add(FavoriteRecipe item);
        bool Remove(FavoriteRecipe item);
        bool Update(FavoriteRecipe item);
    }
}
