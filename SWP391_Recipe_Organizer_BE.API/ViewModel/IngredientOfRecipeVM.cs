namespace SWP391_Recipe_Organizer_BE.API.ViewModel
{
    public class IngredientOfRecipeVM
    {
        public string? IngredientId { get; set; } = null!;
        public string? RecipeId { get; set; } = null!;
        public double? Quantity { get; set; }
        public IngredientVM? IngredientVM { get; set; }
    }
    public class IoRAddUpdateVM
    {
        public string? Id { get; set; }
        public string IngredientName { get; set; } = null!;
        public string? RecipeId { get; set; } = null!;
        public double Quantity { get; set; }
    }
}
