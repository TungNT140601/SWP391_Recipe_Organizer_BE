using AutoMapper;
using SWP391_Recipe_Organizer_BE.API.ViewModel;
using SWP391_Recipe_Organizer_BE.Repo.EntityModel;

namespace SWP391_Recipe_Organizer_BE.API
{
    public class Mapper : Profile
    {
        public Mapper()
        {
            CreateMap<UserAccountVM, UserAccount>();
            CreateMap<UserAccount, UserAccountVM>();

            CreateMap<Country, CountryVM>();
            CreateMap<CountryVM, Country>();

            CreateMap<Meal, MealVM>();
            CreateMap<MealVM, Meal>();

            CreateMap<Ingredient, IngredientVM>();
            CreateMap<IngredientVM, Ingredient>();

            CreateMap<Nutrition, NutritionVM>();
            CreateMap<NutritionVM, Nutrition>();

        }
    }
}
