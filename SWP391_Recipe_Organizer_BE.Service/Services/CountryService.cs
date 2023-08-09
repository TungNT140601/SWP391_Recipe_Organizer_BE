using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using SWP391_Recipe_Organizer_BE.Service.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Service.Services
{
    public class CountryService : ICountryService
    {
        private readonly ICountryService countryService;
        public CountryService(ICountryService countryService)
        {
            this.countryService = countryService;
        }

        public bool Add(Country item)
        {
            return countryService.Add(item);
        }

        public Country Get(string id)
        {
            return countryService.Get(id);
        }

        public IEnumerable<Country> GetAll()
        {
            return countryService.GetAll();
        }

        public bool Remove(Country item)
        {
            return countryService.Remove(item);
        }

        public bool Update(Country item)
        {
            return countryService.Update(item);
        }
    }
}
