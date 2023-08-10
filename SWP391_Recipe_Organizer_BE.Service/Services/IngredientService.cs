using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using SWP391_Recipe_Organizer_BE.Repo.Interface;
using SWP391_Recipe_Organizer_BE.Service.Interface;
using SWP391_Recipe_Organizer_BE.Ultility;

namespace SWP391_Recipe_Organizer_BE.Service.Services
{
    public class IngredientService : IIngredientService
    {
        private readonly IIngredientRepository ingredientRepository;
        public IngredientService(IIngredientRepository ingredientRepository)
        {
            this.ingredientRepository = ingredientRepository;
        }

        public bool Add(Ingredient item)
        {
            try
            {
                item.IngredientId = GenerateId.AutoGenerateId();
                item.IsDelete = false;
                return ingredientRepository.Add(item);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public Ingredient Get(string id)
        {
            try
            {
                return ingredientRepository.Get(id);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public IEnumerable<Ingredient> GetAll()
        {
            try
            {
                return ingredientRepository.GetAll(x => x.IsDelete == false);
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
                var country = ingredientRepository.Get(id);
                if (country != null)
                {
                    country.IsDelete = true;
                    return ingredientRepository.Update(country);
                }
                else
                {
                    throw new Exception("Not Found Ingredient");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public bool Update(Ingredient item)
        {
            try
            {
                var country = ingredientRepository.Get(item.IngredientId);
                country.IngredientName = item.IngredientName;
                return ingredientRepository.Update(country);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
