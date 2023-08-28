using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Service.Interface
{
    public interface IRecipeService
    {
        Recipe Get(string id);
        Recipe GetInPlanWeek(string id);
        IEnumerable<Recipe> GetByCooker(string id);
        IEnumerable<Recipe> GetAll();
        IEnumerable<Recipe> GetAll(List<string> recipeIds);
        IEnumerable<string> GetSuggest(string search);
        IEnumerable<Recipe> SearchRecipe(string? name, string? countryId, string? mealId, int? minTime, int? maxTime, int? minServing, int? maxServing);
        IEnumerable<Recipe> SearchFavoriteRecipe(List<string> recipeIds, string? name, string? countryId, string? mealId, int? minTime, int? maxTime, int? minServing, int? maxServing);
        Task<bool> AddAsync(Recipe item, List<Photo> photos, List<Direction> directions, List<IngredientOfRecipe> lstIngredientOfRecipes);
        bool Delete(string id);
        Task<bool> Update(Recipe item, List<Photo> photos, List<Direction> directions, List<IngredientOfRecipe> lstIngredientOfRecipes);
    }
}
