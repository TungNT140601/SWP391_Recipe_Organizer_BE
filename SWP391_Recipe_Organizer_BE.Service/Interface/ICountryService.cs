using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Service.Interface
{
    public interface ICountryService
    {
        Country Get(string id);
        IEnumerable<Country> GetAll();
        bool Add(Country item);
        bool Remove(Country item);
        bool Update(Country item);
    }
}
