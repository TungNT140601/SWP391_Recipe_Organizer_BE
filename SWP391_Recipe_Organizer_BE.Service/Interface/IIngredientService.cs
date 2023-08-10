using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Service.Interface
{
    public interface IIngredientService
    {
        Ingredient Get(string id);
        IEnumerable<Ingredient> GetAll();
        bool Add(Ingredient item);
        bool Delete(string id);
        bool Update(Ingredient item);
    }
}
