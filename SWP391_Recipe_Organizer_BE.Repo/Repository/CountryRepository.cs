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
    public class CountryRepository : GeneralRepository<Country>, ICountryRepository
    {
        public CountryRepository(RecipeOrganizerDBContext dBContext) : base(dBContext)
        {
        }
    }
}
