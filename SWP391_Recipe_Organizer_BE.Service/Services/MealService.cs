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
    public class MealService : IMealService
    {
        private readonly IMealRepository mealRepository;
        public MealService(IMealRepository mealRepository)
        {
            this.mealRepository = mealRepository;
        }
        public bool Add(Meal item)
        {
            try
            {
                item.MealId = GenerateId.AutoGenerateId();
                item.IsDelete = false;
                return mealRepository.Add(item);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public Meal Get(string id)
        {
            try
            {
                var meal = mealRepository.Get(id);
                return !meal.IsDelete.Value ? meal : null;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public IEnumerable<Meal> GetAll()
        {
            try
            {
                return mealRepository.GetAll(x => x.IsDelete == false);
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
                var meal = mealRepository.Get(id);
                if (meal != null)
                {
                    meal.IsDelete = true;
                    return mealRepository.Update(meal);
                }
                else
                {
                    throw new Exception("Not Found Meal");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public bool Update(Meal item)
        {
            try
            {
                var meal = mealRepository.Get(item.MealId);
                if (meal != null)
                {
                    meal.IsDelete = false;
                    return mealRepository.Update(item);
                }
                else
                {
                    throw new Exception("Not Found Meal");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
