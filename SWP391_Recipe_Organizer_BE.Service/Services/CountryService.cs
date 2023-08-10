using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using SWP391_Recipe_Organizer_BE.Repo.Interface;
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
        private readonly ICountryRepository countryRepository;
        public CountryService(ICountryRepository countryRepository)
        {
            this.countryRepository = countryRepository;
        }

        public bool Add(Country item)
        {
            return countryRepository.Add(item);
        }

        public Country Get(string id)
        {
            return countryRepository.Get(id);
        }

        public IEnumerable<Country> GetAll()
        {
            
            return countryRepository.GetAll();
        }

        public bool Remove(Country item)
        {
            return countryRepository.Remove(item);
        }

        public bool Update(Country item)
        {
            return countryRepository.Update(item);
        }
    }
}
