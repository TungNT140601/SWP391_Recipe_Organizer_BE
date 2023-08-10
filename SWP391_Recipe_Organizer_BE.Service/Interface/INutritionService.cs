using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Service.Interface
{
    public interface INutritionService
    {
        Nutrition Get(string id);
        IEnumerable<Nutrition> GetAll();
        bool Add(Nutrition item);
        bool Delete(string id);
        bool Update(Nutrition item);
    }
}
