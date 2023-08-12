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
        public DateTime? Date { get; set; }
        public int? MealOfDate { get; set; }
    }
}
