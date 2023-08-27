namespace SWP391_Recipe_Organizer_BE.API.ViewModel
{
    public class IngredientVM
    {
        public string? IngredientId { get; set; }
        public string? IngredientName { get; set; }
        public string? Measure { get; set; }
        public int? Carbohydrate { get; set; } = 0;
        public int? Protein { get; set; } = 0;
        public int? Fat { get; set; } = 0;
        public int? Calories { get; set; } = 0;
    }
}
