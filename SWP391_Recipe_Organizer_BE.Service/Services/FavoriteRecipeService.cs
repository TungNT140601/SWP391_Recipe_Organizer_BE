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
    public class FavoriteRecipeService : IFavoriteRecipeService
    {
        private readonly IFavoriteRecipeRepository favoriteRecipeRepository;
        public FavoriteRecipeService(IFavoriteRecipeRepository favoriteRecipeRepository)
        {
            this.favoriteRecipeRepository = favoriteRecipeRepository;
        }

        public bool Add(FavoriteRecipe item)
        {
            try
            {
                item.FavoriteId = GenerateId.AutoGenerateId();
                item.FavoriteTime = DateTime.Now;
                return favoriteRecipeRepository.Add(item);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public FavoriteRecipe Get(string recipeId, string userId)
        {
            try
            {
                var favor = favoriteRecipeRepository.Get(x =>x.RecipeId == recipeId && x.UserId == userId);
                return favor != null ? favor : null;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public IEnumerable<FavoriteRecipe> GetAll(string userId)
        {
            try
            {
                var favor = favoriteRecipeRepository.GetAll(x => x.UserId == userId, new System.Linq.Expressions.Expression<Func<FavoriteRecipe, object>>[]
                {
                    x => x.Recipe
                });
                return favor != null ? favor : null;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public bool Remove(FavoriteRecipe item)
        {
            try
            {
                var favor = favoriteRecipeRepository.Get(x => x.FavoriteId == item.FavoriteId && x.UserId == item.UserId);
                if (favor != null)
                {
                    return favoriteRecipeRepository.Remove(favor);
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
