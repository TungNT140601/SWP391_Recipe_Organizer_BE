namespace SWP391_Recipe_Organizer_BE.API.ViewModel
{
    public class NutritionInRecipeVM
    {
        public string? NutritionId { get; set; } = null!;
        public string? RecipeId { get; set; } = null!;
        public int? Quantity { get; set; }
    }
}
