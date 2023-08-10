using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using SWP391_Recipe_Organizer_BE.Repo.Interface;
using SWP391_Recipe_Organizer_BE.Service.Interface;
using SWP391_Recipe_Organizer_BE.Ultility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Service.Services
{
    public class NutritionService: INutritionService
    {
        private readonly INutritionRepository nutritionRepository;
        public NutritionService(INutritionRepository nutritionRepository)
        {
            this.nutritionRepository = nutritionRepository;
        }
        public bool Add(Nutrition item)
        {
            try
            {
                item.NutritionId = GenerateId.AutoGenerateId();
                item.IsDelete = false;
                return nutritionRepository.Add(item);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public Nutrition Get(string id)
        {
            try
            {
                var meal = nutritionRepository.Get(id);
                return !meal.IsDelete.Value ? meal : null;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public IEnumerable<Nutrition> GetAll()
        {
            try
            {
                return nutritionRepository.GetAll(x => x.IsDelete == false);
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
                var meal = nutritionRepository.Get(id);
                if (meal != null)
                {
                    meal.IsDelete = true;
                    return nutritionRepository.Update(meal);
                }
                else
                {
                    throw new Exception("Not Found Nutrition");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public bool Update(Nutrition item)
        {
            try
            {
                var meal = nutritionRepository.Get(item.NutritionId);
                if (meal != null)
                {
                    meal.IsDelete = false;
                    return nutritionRepository.Update(item);
                }
                else
                {
                    throw new Exception("Not Found Nutrition");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
