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

            CreateMap<UserAccountAdminVM, UserAccount>();
            CreateMap<UserAccount, UserAccountAdminVM>();

            CreateMap<Country, CountryVM>();
            CreateMap<CountryVM, Country>();

            CreateMap<Meal, MealVM>();
            CreateMap<MealVM, Meal>();

            CreateMap<Ingredient, IngredientVM>();
            CreateMap<IngredientVM, Ingredient>();

            CreateMap<Photo, PhotoVM>();
            CreateMap<PhotoVM, Photo>();

            CreateMap<Plan, PlanVM>();
            CreateMap<PlanVM, Plan>();

            CreateMap<PlanDetail, PlanDetailVM>();
            CreateMap<PlanDetailVM, PlanDetail>();

            CreateMap<Plan, PlanUpdateVM>();
            CreateMap<PlanUpdateVM, Plan>();

            CreateMap<PlanDetail, PlanDetailUpdateVM>();
            CreateMap<PlanDetailUpdateVM, PlanDetail>();

            CreateMap<RecipeAddUpdateVM, Recipe>();
            CreateMap<Recipe, RecipeAddUpdateVM>();

            CreateMap<RecipeVM, Recipe>();
            CreateMap<Recipe, RecipeVM>();

            CreateMap<Direction, DirectionVM>();
            CreateMap<DirectionVM, Direction>();

            CreateMap<IngredientOfRecipe, IngredientOfRecipeVM>();
            CreateMap<IngredientOfRecipeVM, IngredientOfRecipe>();

            CreateMap<Review, ReviewVM>();
            CreateMap<ReviewVM, Review>();
        }
    }
}
