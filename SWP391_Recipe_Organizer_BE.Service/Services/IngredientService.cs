using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using SWP391_Recipe_Organizer_BE.Repo.Interface;
using SWP391_Recipe_Organizer_BE.Service.Interface;
using SWP391_Recipe_Organizer_BE.Ultility;
using System.ComponentModel;

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
                if (ingredientRepository.Get(x => x.IngredientName == item.IngredientName && x.IsDelete == false) != null)
                {
                    throw new Exception("Name exist");
                }
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
                return ingredientRepository.Get(x => x.IngredientId == id && x.IsDelete == false);
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
                var ingredient = ingredientRepository.Get(x => x.IngredientId == id && x.IsDelete == false);
                if (ingredient != null)
                {
                    ingredient.IsDelete = true;
                    return ingredientRepository.Update(ingredient);
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
                var ingredient = ingredientRepository.Get(x => x.IngredientId == item.IngredientId && x.IsDelete == false);
                if (ingredientRepository.Get(x => x.IngredientId != ingredient.IngredientId && x.IngredientName == item.IngredientName && x.IsDelete == false) != null)
                {
                    throw new Exception("Name exist");
                }
                ingredient.IngredientName = item.IngredientName;
                ingredient.Measure = item.Measure;
                ingredient.Fat = item.Fat;
                ingredient.Calories = item.Calories;
                ingredient.Carbohydrate = item.Carbohydrate;
                ingredient.Protein = item.Protein;
                ingredient.IsDelete = false;
                return ingredientRepository.Update(ingredient);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
