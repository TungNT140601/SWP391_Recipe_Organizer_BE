using SWP391_Recipe_Organizer_BE.Repo.EntityModel;

namespace SWP391_Recipe_Organizer_BE.API.ViewModel
{
    public class PlanDetailVM
    {
        public string? PlanDetailId { get; set; }
        public string? PlanId { get; set; }
        public string? RecipeId { get; set; }
        public DateTime? Date { get; set; }
        public int? MealOfDate { get; set; }

        public PlanVM? Plan { get; set; }
        public RecipeVM? Recipe { get; set; }
    }
    public class PlanDetailUpdateVM
    {
        public string? PlanDetailId { get; set; }
        public string? PlanId { get; set; }
        public string? RecipeId { get; set; }
        public string? DateSt { get; set; }
        public int? MealOfDate { get; set; }
    }

    public class PlanDetailDateOfWeekVM
    {
        public string? PlanDetailId { get; set; }
        public int? MealOfDate { get; set; }
        public string? RecipeId { get; set; }
        public string? RecipeName { get; set; }
        public double? RecipeCalo { get; set; }
    }
    public class PlanDetailDateVM
    {
        public string? PlanDetailId { get; set; }
        public string? RecipeName { get; set; }
        public string? RecipeId { get; set; }
        public string? Photos { get; set; }
        public int? TotalTime { get; set; }
        public int? TotalIngredient { get; set; }
        public int? Carbohydrate { get; set; }
        public int? Protein { get; set; }
        public int? Fat { get; set; }
        public int? Calories { get; set; }
    }

    public class PlanDetailWeekVM
    {
        public List<PlanDetailDateOfWeekVM>? Breakfast { get; set; } = new List<PlanDetailDateOfWeekVM> { };
        public List<PlanDetailDateOfWeekVM>? Lunch { get; set; } = new List<PlanDetailDateOfWeekVM> { };
        public List<PlanDetailDateOfWeekVM>? Dinner { get; set; } = new List<PlanDetailDateOfWeekVM> { };
    }
}
