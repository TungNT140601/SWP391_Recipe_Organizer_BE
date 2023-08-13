using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using SWP391_Recipe_Organizer_BE.Repo.Interface;
using SWP391_Recipe_Organizer_BE.Service.Interface;
using SWP391_Recipe_Organizer_BE.Ultility;

namespace SWP391_Recipe_Organizer_BE.Service.Services
{
    public class CountryService : ICountryService
    {
        private readonly ICountryRepository countryRepository;
        private readonly IRecipeRepository recipeRepository;
        public CountryService(ICountryRepository countryRepository, IRecipeRepository recipeRepository)
        {
            this.countryRepository = countryRepository;
            this.recipeRepository = recipeRepository;
        }

        public bool Add(Country item)
        {
            try
            {
                item.CountryId = GenerateId.AutoGenerateId();
                item.HasRecipe = false;
                return countryRepository.Add(item);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public Country Get(string id)
        {
            try
            {
                return countryRepository.Get(x => x.CountryId == id && x.IsDelete == false);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public IEnumerable<Country> GetAllAdd()
        {
            try
            {
                return countryRepository.GetAll(x => x.IsDelete == false);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public IEnumerable<Country> GetAllFilter()
        {
            try
            {
                var countryList = countryRepository.GetAll(x => x.IsDelete == false && x.HasRecipe == true);
                return countryList.ToList();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public bool Delete(string id)
        {
            try
            {
                var country = countryRepository.Get(x => x.CountryId == id && x.IsDelete == false);
                if (country != null)
                {
                    country.IsDelete = true;
                    return countryRepository.Update(country);
                }
                else
                {
                    throw new Exception("Not Found Country");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public bool Update(Country item)
        {
            try
            {
                var country = countryRepository.Get(x => x.CountryId == item.CountryId && x.IsDelete == false);
                country.CountryName = item.CountryName;
                return countryRepository.Update(country);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void CheckCountryHasRecipe(string id)
        {
            try
            {
                var country = countryRepository.Get(x =>x.CountryId == id && x.IsDelete == false);
                if(country != null)
                {
                    var recipes = recipeRepository.GetAll(x => x.CountryId == country.CountryId && x.IsDelete == false);
                    if (recipes != null && recipes.Count() > 0)
                    {
                        country.HasRecipe = true;
                    }
                    else
                    {
                        country.HasRecipe = false;
                    }
                    countryRepository.Update(country);
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
