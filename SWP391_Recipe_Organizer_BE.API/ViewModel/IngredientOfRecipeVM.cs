namespace SWP391_Recipe_Organizer_BE.API.ViewModel
{
    public class IngredientOfRecipeVM
    {
        public string? IngredientId { get; set; } = null!;
        public string? RecipeId { get; set; } = null!;
        public string? Description { get; set; }
        public IngredientVM? IngredientVM { get; set; }
    }
}
